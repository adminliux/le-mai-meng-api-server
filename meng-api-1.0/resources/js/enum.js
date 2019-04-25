(function (global) {
    var enumDisplayNameKey = "localEnumDisplayName";

    var enumDisplay = function (url) {
        global.uri = url;
    };

    enumDisplay.prototype = {
        /**
         * 获取数据AJAX
         * @param {Object} url URL
         * @param success 成功回调
         */
        dataAjax: function (url, success) {
            Project.ajaxNoWait(url, {}, {async: false, dataType: "JSON"}).ajaxOK(function (data) {
                localStorage[enumDisplayNameKey] = JSON.stringify(data.data);
                if (success) success(data);
            });
        },
        clean: function () {
            localStorage.removeItem(enumDisplayNameKey);
        },
        /**
         * 获取数据AJAX
         * @param success 成功回调
         */
        dataAjaxGlobal: function (success) {
            Project.ajaxNoWait(global.uri, {}, {async: false, dataType: "JSON"}).ajaxOK(function (data) {
                data = data.data;
                localStorage[enumDisplayNameKey] = JSON.stringify(data);
                if (success) success(data);
            });
        },
        /**
         * 本地获取数据
         */
        dataLocal: function () {
            try {
                return JSON.parse(localStorage[enumDisplayNameKey]);
            } catch (e) {
                console.log(e);
                Enum.dataAjaxGlobal(function (data) {
                    return data.data;
                });
            }
        },
        obj: function (key, ok) {
            if (!cm.stringIsEmpty(key)) {
                var data = Enum.dataLocal();
                try {
                    var one = data[key];
                    if (!one) {
                        Enum.dataAjaxGlobal(function () {
                            return Enum.obj(key, ok);
                        });
                    } else {
                        _ok(one);
                        return one;
                    }
                } catch (e) {
                    console.log(e);
                    Enum.dataAjaxGlobal(function () {
                        return Enum.obj(key, ok);
                    });
                }
            }

            function _ok(d) {
                try {
                    if (ok) ok(d);
                } catch (e) {
                    localStorage.removeItem(enumDisplayNameKey);
                    console.log(e);
                }
            }
        },
        /**
         * 根据KEY获取值
         * @param {Object} key KEY
         * @param name 属性
         * @param isLoad 是否从新加载过
         * @param su 成OK
         * @param attrName 属性名
         */
        value: function (key, name, isLoad, su, attrName) {
            attrName = attrName || "explain";
            if (!cm.stringIsEmpty(key) && !cm.stringIsEmpty(name)) {
                var data = Enum.dataLocal();
                try {
                    var one = data[key];
                    var o = one[name];
                    var value = o[attrName];
                    if (cm.stringIsEmpty(value)) {
                        if (isLoad !== true)
                            Enum.dataAjax(global.uri, function () {
                                return Enum.value(key, name, true, su);
                            });
                    } else {
                        suRun();
                        return value;
                    }

                    function suRun() {
                        if (su) su(value, o);
                    }
                } catch (e) {
                    if (isLoad !== true)
                        Enum.dataAjax(global.uri, function () {
                            return Enum.value(key, name, true, su);
                        });
                }
            }
        },
        valueAttr: function (key, name, attrName) {
            return Enum.value(key, name, null, null, attrName);
        },
        /**
         * 获取解释
         * @param o enum
         */
        explain: function (o) {
            if (o) return o.explain;
        },
        /**
         * 生成SELECT选择
         * @param key 枚举ID
         * @param name 参数名称
         * @param must 是否必选
         * @param callback 完成回调
         */
        genderSelect: function (key, name, must, callback) {
            Enum.obj(key, function (data) {
                var $select = $('<select name="' + name + '"></select>');
                if (!must) $select.append("<option value=''>请选择</option>");
                for (var _k in data) {
                    // noinspection JSUnfilteredForInLoop
                    $select.append("<option value='" + _k + "'>" + Enum.explain(data[_k]) + "</option>");
                }
                var $p = $("<div></div>");
                $p.append($select);
                if (callback) callback($p.html());
            });
        }
    };
    global.enumDisplay = enumDisplay;
})(window);

if (window.enumDisplay) {
    window.Enum = new window.enumDisplay("/enum/data");
    if (window.template) {
        window.template.helper("$enumValue", Enum.value);
        window.template.helper("$valueAttr", Enum.valueAttr);
    }
}
