//noinspection SpellCheckingInspection
(function (global) {
    var apiHost = global.apiHost,
        frontColorKey = "frontColor",
        TOKEN_COOKIE_NAME = "H5_TOKEN";

    var project = function (apiType, source) {
        global.apiType = apiType;
        if (!cm.stringIsEmpty(apiType)) {
            if (apiType === "API") {
                apiHost = apiHost + "/api/json";
            }
        }
        global.source = source;
    };

    project.prototype = {
        /**
         * @returns {string} API前撮地址
         */
        apiFix: function () {
            return apiHost;
        },
        /**
         * 前段颜色显示
         */
        frontColor: function () {
            var color = localStorage[frontColorKey];
            localStorage.removeItem(frontColorKey);
            /**
             * if (color == null) { Project.ajax("/config/front/color", {}, {
             * async: false }).ajaxOK(function (data) {
             * localStorage[frontColorKey] = data.data; }, false, false); }
             * $("head").append($('<style>.public-red{background:' + color + '
             * !important;}</style>'));
             */
        },
        /**
         * ajax请求数据
         * @param url   url 地址
         * @param data  data 参数
         * @param setting
         *            jquery参数
         * @param isLocal
         *            是否是项目内AJAX
         * @param isFile 是否文件上传
         * @param error 失败回掉
         * @param notWait 是否取消等待框
         */
        ajax: function (url, data, setting, isLocal, isFile, error, notWait) {
            data = data || {};

            var realUrl = apiHost + url,
                p = new promise.Promise();

            if (isLocal === true) {
                if (path) {
                    url = path + url;
                }
                realUrl = url;
            }


            var d = {
                source: source,
                CORSDomain: location.protocol + "//" + location.host
            };
            var paramType = 0;

            var dataType = Object.prototype.toString.call(data);
            if (dataType === "[object String]") {
                data += "&" + cm.parseParam(d);
                paramType = 1;
            } else if (dataType === "[object FormData]") {
                paramType = 1;
                for (var dn in d) {
                    if (d[dn] !== null) {
                        data.append(dn, d[dn]);
                    }
                }
            } else {
                paramType = 3;
                cm.objRemoveUnit(data);
                data = $.extend(d, data);
            }
            var opt = {
                data: data,
                type: 'post', // HTTP请求类型
                timeout: 0, // 永不超时
                success: function (data) {
                    if (!notWait) hideProgress();
                    console.log(JSON.stringify(data));
                    p.done(data);
                },
                url: realUrl,
                error: function (xhr) {
                    hideProgress();
                    var code = xhr.status;
                    toast("请求失败[code=" + code + "]\n" + http.codeDesc(code));
                },
                xhrFields: {
                    withCredentials: true
                },
                beforeSend: function () {
                    if (!notWait) showProgress("努力加载中", "请稍后...");
                }
            };
            if (apiType === "API") {
                opt.dataType = "json";
            }
            if (setting === null) {
            } else {
                opt = cm.merge(opt, setting);
            }
            if (isFile)
                paramType = 2;

            if (paramType !== 2) {
                try {
                    $.ajax(opt);
                } catch (e) {
                    toast("没有网络连接请检查网络");
                    console.log(e);
                }
            } else {
                if (!notWait) showProgress("努力加载中", "请稍后...");

                var paramData = {};
                switch (paramType) {
                    case 1:
                        paramData.body = data;
                        break;
                    case 2:
                        paramData.files = data;
                        break;
                    case 3:
                        paramData.values = data;
                        break;
                    default:
                        console.log("参数类似" + paramType + "不做处理");
                }

                var apiData = {
                    url: realUrl,
                    method: 'post',
                    data: paramData,
                    dataType: "JSON",
                    timeout: 99999999999999999
                };
                apiData = $.extend(true, apiData, setting);
                cm.objRemoveUnit(apiData.data.values);
                console.log(JSON.stringify(apiData));
                api.ajax(apiData, function (ret, err) {
                    function doneCompile() {
                        if (apiData.compile) apiData.compile(ret, err);
                    }

                    if (!notWait) hideProgress();
                    if (err) {
                        console.log(JSON.stringify(err));
                        doneCompile();
                        alert(err.msg || "请求错误");
                        if (error) error(err);
                    } else {
                        if (apiData.report) {
                            console.log(JSON.stringify(ret));
                            if (apiData.onpProgress) apiData.onpProgress(ret.progress);
                            if (ret.body) {
                                var code = ret.statusCode;
                                if (code && code !== 200) {
                                    toast("请求失败[code=" + code + "]\n" + http.codeDesc(code));
                                } else {
                                    p.done(ret.body);
                                    doneCompile();
                                }
                            }
                        } else {
                            doneCompile();
                            p.done(ret);
                        }
                    }
                });
            }
            return p;
        },
        /**
         * 上传文件
         */
        ajaxUploadVideoFile: function (uri, data, setting, isL) {
            return this.ajaxUploadFileUrl(uri, data, setting, isL);
        },
        globalAdmin: function (type, last) {
            last = last || "";
            return '/global/admin/' + type + last;
        },
        globalAdminUrl: function (type, last) {
            return this.apiFix() + this.globalAdmin(type, last) + "?type=" + type;
        },
        ajaxNoWait: function (url, data, setting, isLocal, isFile, error) {
            return this.ajax(url, data, setting, isLocal, isFile, error, true);
        },
        ajaxCityQueryByName: function (data, setting) {
            return this.ajax('/region/query/by/name', data, setting);
        },
        ajaxCityQueryByName_: function (name, setting) {
            return this.ajax('/region/query/by/name', {cityName: name}, setting);
        },
        /**
         * 新闻动态/物资行情
         * @param {Object} fd 参数
         * @param {Object} setting 设置
         */
        ajaxMarketSupplie: function (fd, setting) {
            return this.ajax('/market/supplie/get/list', fd, setting);
        },
        /**
         * 加载下拉框
         * @param {Object} type 类型
         * @param {Object} fn 回调
         */
        ajaxSelect: function (type, fn) {
            Project.ajax("/drop/down/data/get/list").ajaxOK(function (d) {
                d = d.data;
                $(d).each(function () {
                    if (this.type === type) {
                        if (fn) fn(this);
                        return false;
                    }
                });
            });
        },
        /**
         * ajax请求数据
         *
         * @param {Object}
         *            url 地址
         * @param {Object}
         *            data 参数
         * @param setting
         *            jquery参数
         */
        ajaxPage: function (url, data, setting) {
            var fileSetting = {
                processData: false,
                contentType: false,
                dataType: "text",
                type: "post"
            };
            if (setting != null) {
                fileSetting = cm.merge(fileSetting, setting)
            }
            return this.ajaxLocal(pathPage + url, data, fileSetting);
        },
        /**
         * 地址
         * @param {Object} code 城市CODE
         * @param {Object} su 成功回调
         */
        addressSimple: function (code, su) {
            this.ajax('/region/select/simple/by/region/code', {
                code: code
            }).ajaxOK(function (data) {
                if (su) su(data.data)
            });
        },
        /**
         * 系统消息数量
         * @param {Object} ok 成功回调
         */
        ajaxSysMsgSum: function (ok) {
            ok = ok || function () {
            };
            this.ajax("/sys/message/get/count").ajaxOK(function (d) {
                d = d.data;
                ok(d);
            });
        },
        ajaxUploadVideoParse: function (data, setting) {
            return this.ajaxUploadFileUrl("/on/demand//trans/coding", data, setting);
        },
        /**
         * 银行卡列表
         * @param {Object} data 参数
         * @param {Object} setting 配置
         */
        ajaxBankCardList: function (data, setting) {
            return this.ajax('/bank/card/get/list', data, setting);
        },
        /**
         * 一张银行卡
         */
        ajaxBankCard: function (data, set) {
            return this.ajax('/user/bank/card/bind/alr/bind/card', data, set);
        },
        /**
         * ajax请求数据
         *
         * @param {Object}
         *            url 地址
         * @param {Object}
         *            data 参数
         * @param setting
         *            jquery参数
         */
        ajaxLocal: function (url, data, setting) {
            return this.ajax(url, data, setting, true);
        },
        /**
         * 文件上传
         *
         * @param {Object}
         *            uri 地址
         * @param {Object}
         *            data
         * @param {Object}
         *            setting
         */
        ajaxUploadFileUrl: function (uri, data, setting) {
            var fileSetting = {
                processData: false,
                contentType: false,
                dataType: "json",
                type: "post"
            };
            if (setting != null) {
                fileSetting = cm.merge(fileSetting, setting)
            }
            return this.ajax(uri, data, fileSetting);
        },
        /**
         * 上传文件
         */
        ajaxUploadFiles: function (data, setting) {
            return this.ajaxUploadFileUrl('/file/upload/batch', data, setting);
        },
        /**
         * 上传文件
         */
        ajaxUploadFilesV2: function (data, setting) {
            return this.ajaxUploadFileUrl('/file/upload/v2/batch', data, setting);
        },
        /**
         * APIColud上传文件
         */
        ajaxUploadFilePath: function (paths, sett) {
            return this.ajax("/file/upload/batch", {files: paths}, sett, null, true);
        },
        /**
         * APIColud上传文件
         */
        ajaxUploadFilePathVideo: function (paths, sett) {
            return this.ajaxNoWait("/on/demand/trans/coding", {files: paths}, sett, null, true);
        }
        , /**
         * APIColud上传文件
         */
        ajaxUploadVideoAsync: function (paths, sett) {
            return this.ajaxNoWait("/video/release/async/upload/notify", {videoFile: paths}, sett, null, true);
        },
        /**
         * json弹出消息提示框
         *
         * @param data
         */
        ajaxAlert: function (data) {
            alert(data.msg || "请求错误");
        }
        ,
        ajaxUserInfo: function (data) {
            return this.ajax("/user/personal/info", data);
        }
        ,
        userInfo: function (id, ok) {
            Project.ajax('/user/get/user/by/id', {
                userId: id
            }).ajaxOK(function (d) {
                if (ok) ok(d.data);
            }, false, false, function () {
                alert("用户信息获取失败");
            });
        }
        ,
        /**
         * 用户列表
         *
         * @param data
         *            参数
         * @returns {*}
         */
        ajaxUserList: function (data) {
            return this.ajax("/user/selects/vague", data);
        }
        ,
        /**
         * 获取URL分割符号
         * @param {Object} callback 回调
         */
        getUrlSplit: function (callback, error) {
            this.ajax('/common/config/url/split').ajaxOK(function (data) {
                if (callback) callback(data.data);
            }, false, false, function (d) {
                if (error) error(d.msg);
            });
        }
        ,
        /**
         * 分页设置
         */
        ajaxPageSet: function (pageSize, data) {
            data = data || {};
            return data.pageSize = pageSize;
        }
        ,
        /**
         * 资金记录
         * @param {Object} data
         */
        ajaxMoneyRecord: function (data) {
            return this.ajax('/money/record/get/list/type', data);
        }
        ,
        getUser: function () {
            try {
                return JSON.parse(localStorage.user);
            } catch (e) {
                console.log(e);
            }
        }
        ,
        getUserAttr: function (attr) {
            var user = this.getUser();
            if (user != null) {
                return user[attr];
            }
        }
        ,
        getOpenId: function () {
            return this.getUserAttr("openId");
        }
        ,
        /**
         * 纺织列表
         * @param {Object} data 参数
         * @param {Object} st 设置
         */
        ajaxSupplyPage: function (data, st) {
            data = data || {};
            var it = bs.supplyIt();
            if (it.listParam) data = $.extend(true, it.listParam, data);
            return this.ajax(bs.supplyIt().listUri, data, st);
        }
        ,
        /**
         * 轮播图
         * @param {Object} data 数据
         * @param {Object} setting 设置
         */
        ajaxBanner: function (data, type, setting) {
            type = type || "0";
            data = data || {};
            var typeName = "type";
            if (!data[typeName]) data[typeName] = type;
            return this.ajax('/each/picture/get/list', data, setting);
        }
        ,
        /**
         * cookie存token
         * @param {Object} token
         */
        loginCookie: function (token) {
            cm.setCookie(TOKEN_COOKIE_NAME, token);
        }
        ,
        /**
         * COOOKIE获取令牌
         */
        getToken: function () {
            return cm.getCookie(TOKEN_COOKIE_NAME);
        }
        ,
        /**
         * 註銷對login的操作
         */
        logoutCookie: function () {
            cm.removeCookie(TOKEN_COOKIE_NAME);
        }
        ,
        /**
         * 修改用戶信息
         */
        ajaxUpdateUser: function (data, setting) {
            return this.ajax('/user/update/personal/info', data, setting);
        }
        ,
        /**
         * 地区详情
         * @param data 参数
         * @param setting 其他
         * @returns {*} then
         */
        ajaxRegionInfo: function (data, setting) {
            return this.ajax('/region/select/by/county/code', data, setting);
        }
        ,
        /**
         * 地区详情参数COde
         * @param code 代码
         * @returns {*} then
         */
        ajaxRegionInfoCode: function (code) {
            return this.ajaxRegionInfo({code: code});
        }
        ,
        /**
         * 登录框弹出
         */
        loginAlert: function () {
            $("body").append("<div id='mask'></div>");
            $(".mm_denglu").show();

            // 登录隐藏
            $("#mask").on('click', function () {
                $(this).remove();
                $(".mm_denglu").hide();
            });
        }
    }
    ;
    global.project = project;
    global.Project = new project("API");
})(window);

if (promise) {
    /**
     * AJAX数据返回处理
     *
     * @param code
     *            code码
     * @param callback
     *            回调
     * @param codeAlert
     *            是否弹出消息
     * @param alert
     *            弹出消息
     * @param notFn
     *            code不等回调
     * @param skipEmpty 跳过空数据
     */
    promise.Promise.prototype.ajax = function (code, callback, notFn, alert, skipEmpty, codeAlert) {
        this.ajaxV2(code, callback, notFn, alert, skipEmpty, codeAlert);
    };

    /**
     * AJAX数据返回处理
     *
     *            code码
     * @param code JSON_CODE
     * @param callback
     *            回调
     * @param notFn
     *            code不等回调
     * @param alert
     *            弹出消息
     * @param skipEmpty 跳过空数据
     * @param codeAlert 符合code弹出
     */
    promise.Promise.prototype.ajaxV2 = function (code, callback, notFn, alert, skipEmpty, codeAlert) {
        this.then(function (data) {
                function error() {
                    if (alert === undefined || alert === true) Project.ajaxAlert(data);
                    if (notFn && typeof notFn === "function") notFn(data);
                }

                var _code = data.code;
                if (_code === code) {
                    if (codeAlert) Project.ajaxAlert(data);
                    if (callback) callback(data);
                } else if (_code === "EMPTY") {
                    if (skipEmpty) return;
                    error();
                } else if (_code === "OVERTIME") {
                    //noinspection JSUnresolvedVariable
                    if (!window.noLogin) toLogin();
                    //location.href = dowAppUrl;
                } else {
                    error();
                }
            }
        );
    };

    /**
     * 数据成功返回处理
     */
    promise.Promise.prototype.ajaxOK = function (callback, codeAlert, alert, notFn, skipEmpty) {
        this.ajax("SUCCESS", callback, notFn, alert, skipEmpty, codeAlert);
    };

    /**
     * 数据成功返回处理
     */
    promise.Promise.prototype.okSkipEm = function (callback, codeAlert, alert, notFn) {
        this.ajaxOK(function (data) {
            if (callback) callback(data.data);
        }, codeAlert, alert, notFn, true);
    };

    /**
     * 数据失败返回处理
     *
     * @param callback
     *            回调
     * @param isAlert
     *            是否弹出消息
     */
    promise.Promise.prototype.ajaxFail = function (callback, isAlert) {
        this.ajax("FAIL", callback, isAlert);
    };
    /**
     * 数据为空返回处理
     *
     * @param callback
     *            回调
     * @param isAlert
     *            是否弹出消息
     */
    promise.Promise.prototype.ajaxEmpty = function (callback, isAlert) {
        this.ajax("EMPTY", callback, isAlert);
    };
    /**
     * 参数不合法返回处理
     *
     * @param callback
     *            回调
     * @param isAlert
     *            是否弹出消息
     */
    promise.Promise.prototype.ajaxParam = function (callback, isAlert) {
        this.ajax("PARAMETER_INVALID", callback, isAlert);
    };
}
if (template) {
    template.helper("$page", function (page, number) {
        page = page || {};
        page.pageNum = number;
        return JSON.stringify(page);
    });
}
