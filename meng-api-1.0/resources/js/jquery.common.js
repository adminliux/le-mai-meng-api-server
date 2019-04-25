(function ($) {
    $.body = $("body");
    var isSor = false;

    function parseJSON(v) {
        try {
            return JSON.parse(v);
        } catch (e) {
            return v;
        }
    }


    $.fn.extend({
        /**
         * 下拉框三级联动
         * @param areaJson 数据
         * @param o 第一个
         * @param t 第二个
         * @param s 第三个
         */
        selectLinkage: function (areaJson, o, t, s) {
            this.each(function () {
                var temp_html;
                var oProvince = $(this).find(o);
                var oCity = $(this).find(t);
                var oDistrict = $(this).find(s);
                //初始化省
                var province = function () {
                    $.each(areaJson, function (i, province) {
                        temp_html += "<option value='" + province.p + "'>" + province.p + "</option>";
                    });
                    oProvince.html(temp_html);
                    city();
                };
                //赋值市
                var city = function () {
                    temp_html = "";
                    var n = oProvince.get(0).selectedIndex;
                    $.each(areaJson[n].c, function (i, city) {
                        temp_html += "<option value='" + city.ct + "'>" + city.ct + "</option>";
                    });
                    oCity.html(temp_html);
                    district();
                };
                //赋值县
                var district = function () {
                    temp_html = "";
                    var m = oProvince.get(0).selectedIndex;
                    var n = oCity.get(0).selectedIndex;
                    if (typeof(areaJson[m].c[n].d) == "undefined") {
                        oDistrict.css("display", "none");
                    } else {
                        oDistrict.css("display", "inline");
                        $.each(areaJson[m].c[n].d, function (i, district) {
                            temp_html += "<option value='" + district.dt + "'>" + district.dt + "</option>";
                        });
                        oDistrict.html(temp_html);
                    }
                };
                //选择省改变市
                oProvince.change(function () {
                    city();
                });
                //选择市改变县
                oCity.change(function () {
                    district();
                });

                province();
            });
        },
        htmlContain: function () {
            var $p = $("<div></div>");
            $p.append(this);
            return $p.html();
        },
        /**
         * HREF属性操作
         * @param {Object} value 属性值
         */
        href: function (value) {
            var name = "href";
            if (value) this.attr(name, value);
            return this.attr(name);
        },
        /**
         * SRC属性操作
         * @param {Object} value 值
         */
        attrSrc: function (value) {
            var name = "src";
            if (value) this.attr(name, value);
            return this.attr(name);
        },
        isHidden: function () {
            return !this.is(":visible");
        },
        /**
         * 扩展属性操作
         * @param {Object} name 属性名
         */
        extAttr: function (name, value) {
            name = 'data-' + name;
            if (value) {
                this.attr(name, value);
            }
            return this.attr(name);
        },
        /**
         * 节点过滤器
         * @param is 返回值true过滤
         */
        filterEl: function (is) {
            if (is) {
                var $this = this.children();
                $this.each(function (i, t) {
                    var $t = $(t);
                    if (is($t))
                        $t.remove();
                });
            }
        },
        /**
         *input checked的操作类型
         * @param mode 模式 1.选中 0，取消选中，-1：反选
         * @returns {*} 是否选中
         */
        checked: function (mode) {
            var checkedName = "checked",
                selectedName = "selected";

            switch (mode) {
                case -1: {
                    if (this.is('option')) {
                        if (isSelected(this)) this.removeAttr(selectedName);
                        else this.prop(selectedName, true);
                    } else {
                        if (isChecked(this)) this.removeAttr(checkedName);
                        else this.prop(checkedName, true);
                    }
                    break;
                }
                case 1: {
                    if (this.is('option')) {
                        this.prop(selectedName, true);
                    } else {
                        this.prop(checkedName, true);
                    }
                    break;
                }
                case 0: {
                    if (this.is('option')) {
                        this.removeAttr(selectedName);
                    } else {
                        this.removeAttr(checkedName);
                    }
                    break;
                }
                default: {
                    if (mode) console.log("值[" + mode + "]没有这个模式");
                }
            }

            function isChecked($t) {
                return $t.is(":checked");
            }

            function isSelected($t) {
                return $t.is(":isSelected");
            }

            return isChecked(this);
        },
        /**
         * 表单序列化，没有值参数值为NULL
         */
        formSerialize: function () {
            var o = {};
            var tg = this;
            if (this[0].nodeName !== "FORM") {
                tg = $("<form></form>");
                tg.append(this.clone());
            }
            var a = tg.serializeArray();
            $.each(a,
                function () {
                    if (o[this.name] !== undefined) {
                        o[this.name] = o[this.name] + "," + parseJSON(this.value);
                    } else {
                        o[this.name] = parseJSON(this.value);
                    }
                });
            return o;
        },
        /**
         * 父节点数量
         * @param {Object} sum 数量
         */
        parentSum: function (sum) {
            sum = sum || 1;
            var p = this;
            for (var i = 0; i < sum; i++) {
                p = p.parent();
            }
            return p;
        },
        /**
         * 淡入淡出效果
         * @param {Object} fn 函数
         */
        fade: function (fn) {
            this.css("opacity", "0"); //这句加在append前
            if (fn) fn(this);
            this.animate({
                opacity: 1
            }, 500); //这句的作用是使DIV缓慢显示
        },
        /**
         * 表单赋值
         * @param {Object} data 数据
         */
        formAssign: function (data) {
            dataChildrenToString(data);
            for (var attr in data) {
                if (typeof(data[attr]) == 'function') {
                    continue;
                }
                var $input = this.find(":input[name='" + attr + "']");
                var type = $input.attr("type");

                if (type == "checkbox") {
                    var avalues = data[attr].split(",");
                    for (var v = 0; v < avalues.length; v++) {
                        $input.each(function (i, n) {
                            var value = $(n).val();
                            if (value == avalues[v]) {
                                $(n).attr("checked", "checked");
                            }
                        });
                    }
                } else if (type == "radio") {
                    $input.each(function (i, n) {
                        var value = $(n).val();
                        if (value == data[attr] + "") {
                            $(n).attr("checked", "checked");
                        }
                    });
                } else {
                    $input.val(data[attr]);
                }
            }
        },
        //节点数据赋值
        assignment: function (data) {
            dataChildrenToString(data);
            for (var attr in data) {
                if (typeof(data[attr]) == 'function') {
                    continue;
                }
                var $names = this.find("*[data-name='" + attr + "']");
                $names.each(function (i, name) {
                    var $name = $(name),
                        tagName = $name[0].tagName;
                    if (tagName != "INPUT" || tagName != "SELECT") {
                        $name.html(data[attr]);
                    }
                    if (tagName == "IMG") {
                        $name.attr("src", data[attr]);
                    }
                });
            }

        },
        scrollLast: function (but, top) {
            //页面拉到底时自动加载更多
            $(this).scroll(function () {
                var wScrollY = window.scrollY; // 当前滚动条位置
                var wInnerH = window.innerHeight; // 设备窗口的高度（不会变）
                var bScrollH = document.body.scrollHeight; // 滚动条总高度
                if (wScrollY === 0) {
                    if (top) top();
                } else if (wScrollY + wInnerH >= bScrollH - 2) {
                    if (!isSor)
                        if (but) but();
                    isSor = true;
                    setTimeout(function () {
                        isSor = false;
                    }, 500);
                }
            });
        },
        scrollAjax: function (top, last) {
            var $lelment = this || window;
            $($lelment).scroll(function () {
                var scrollTop = $($lelment).scrollTop();
                if (scrollTop === 0) {
                    null ? top : top()
                }
                if (getScrollTop() + getClientHeight() >= getScrollHeight()) {
                    null ? last : last()
                }
            });

            //获取滚动条当前的位置
            function getScrollTop() {
                var scrollTop = 0;
                if (document.documentElement && document.documentElement.scrollTop) {
                    scrollTop = document.documentElement.scrollTop;
                } else if (document.body) {
                    scrollTop = document.body.scrollTop;
                }
                return scrollTop;
            }

            //获取当前可是范围的高度
            function getClientHeight() {
                var clientHeight = 0;
                if (document.body.clientHeight && document.documentElement.clientHeight) {
                    clientHeight = Math.min(document.body.clientHeight, document.documentElement.clientHeight);
                } else {
                    clientHeight = Math.max(document.body.clientHeight, document.documentElement.clientHeight);
                }
                return clientHeight;
            }

            //获取文档完整的高度
            function getScrollHeight() {
                return Math.max(document.body.scrollHeight, document.documentElement.scrollHeight);
            }
        },

        /**
         * 表单验证提交
         */
        validateSubmit: function (success, fail) {
            this.html5Validate(success(this.formSerialize()), fial);
        },
        /**
         * 表单跳转指定链接
         */
        formAction: function () {
            location.href = this.attr("action") + "?" + this.serialize();
        },
        /**
         * 节点是否相等
         * @param node 相等返回true
         * @returns {boolean}
         */
        nodeEqual: function (node) {
            return this[0] === node[0];
        },
        /**
         * 过滤已存在的节点
         * @param nodes 需要过滤的节点
         * @returns {*|HTMLElement} 不存在的节点
         */
        filterExistNode: function (nodes) {
            var not = [];
            this.each(function (_) {
                var is = false;
                nodes.each(function () {
                    if ($(this).nodeEqual($(_))) {
                        is = true;
                        return false;
                    }
                });
                if (is) not.push($(_));
            });
            return $(not);
        }, autoClass: function (name) {
            this.hasClass(name) ? this.removeClass(name) : this.addClass(name)
        }, createFormSerialize: function () {
            var $f = $("<form></form>");
            $f.append(this.clone(true));
            return $f.formSerialize();
        }
    })
})(jQuery);
