function showProgress() {
}

function toast(msg) {
    alert(msg);
}

function hideProgress() {
}

Number.prototype.toFixed = function (len) {
    var add = 0;
    var s;
    var s1 = this + "";
    var start = s1.indexOf(".");
    if (s1.substr(start + len + 1, 1) >= 5) add = 1;
    var temp = Math.pow(10, len);
    s = Math.floor(this * temp) + add;
    return s / temp;
};

/**
 * 判断两个日期部分是否相等
 * @param date 要比较的日期
 * @returns {boolean} 是否相等
 */
Date.prototype.equalDate = function (date) {
    date = date || new Date();
    return date.getDateString() === this.getDateString();
};
//noinspection SpellCheckingInspection
/**
 * 获取一个世家对象日期部分
 * @returns {string} yyyy-MM-dd
 */
Date.prototype.getDateString = function () {
    return this.getFullYear() + "-" + this.getMonth() + "-" + this.getDay();
};


String.prototype = {
    /**
     * Trim the head and tail spaces
     */
    trim: function () {
        return this.replace(/(^\s*)|(\s*$)/g, "");
    },
    isEmpty: function () {
        var string = this;
        if (typeof (string) == "undefined" || string == "" || string == null) {
            return true;
        }
        string += "";
        if (string.trim() == "") {
            return true;
        }
        return false;
    }
};

String.prototype.isNumber = function () {
    if (isNaN(this) == true) {
        return false;
    }
    return true;
};
/**
 * 末尾截取
 * @param {Object} i 倒数角标
 */
String.prototype.lastSubstr = function (i) {
    i = i || 0;
    return this.substr(0, this.length - i);
};
/**
 * 末尾保留
 * @param {Object} i 倒数角标
 */
String.prototype.lastRetain = function (i) {
    i = i || 0;
    var length = this.length;
    return this.substr(length - i, length);
};

String.prototype.subStr = function (str) {
    var i = this.indexOf(str);
    if (i === -1) return this;
    return this.substring(i + str.length, this.length);
};

String.prototype.subStrIndexOf = function (str) {
    var index = this.indexOf(str);
    if (index !== -1) {
        return this.substring(0, index);
    }
    return this;
};
String.prototype.subStrLastIndexOf = function (str) {
    var index = this.lastIndexOf(str);
    if (index !== -1) {
        return this.substring(index + 1, index.length);
    }
    return this;
};

String.prototype.isEmpty = function () {
    return cm.stringIsEmpty(this);
};
/** 日期格式化 */
Date.prototype.format = function (format) {
    var o = {
        "M+": this.getMonth() + 1, // month
        "d+": this.getDate(), // day
        "h+": this.getHours(), // hour
        "m+": this.getMinutes(), // minute
        "s+": this.getSeconds(), // second
        "q+": Math.floor((this.getMonth() + 3) / 3), // quarter
        "S": this.getMilliseconds()
        // millisecond
    };
    if (/(y+)/.test(format))
        format = format.replace(RegExp.$1, (this.getFullYear() + "")
            .substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(format))
            format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] :
                ("00" + o[k]).substr(("" + o[k]).length));
    return format;
};


String.prototype.startWith = function (compareStr) {
    return this.indexOf(compareStr) === 0;
};
//---------------------------common----
(function (global) {

    var bigParameterFix = "bigParameter_";
    var bigParameterName = "json";

    var common = function () {
    };
    common.prototype = {
        textToHtml: function (text) {
            return text.split('\r\n').join('</br>');
        },
        htmlToText: function (text) {
            return text.split('</br>').join('\r\n');
        },
        /**
         * 判断是否视频
         * @param fileName 文件名
         * @param isAlert 不是视频是否弹出出提示
         * @returns {boolean} 是否视频
         */
        fileIsVideo: function (fileName, isAlert) {
            var formats = ["avi", "wmv", "mpeg", "mp4", "mov", "mkv", "flv",
                "f4v", "m4v", "rmvb", "rm", "3gp", "dat", "ts", "mts", "vob"];
            var has = false;
            for (var i = 0; i < formats.length; i++) {
                if (formats.lastIndexOf(formats[i]) !== -1) {
                    has = true;
                    break;
                }
            }
            if (!has && !isAlert) alert("视频格式错误,值支持：" + formats);
            return has;
        },
        fileIsVideoNA: function (fileName) {
            return this.fileIsVideo(fileName, true);
        },
        allParam: function () {
            var search = location.search;
            if (search !== "") search = search.substring(1, search.length);
            var ps = search.split("&");
            var pm = {};
            ps.forEach(function (e) {
                if (e === "") return;
                var one = e.split("=");
                pm[one[0]] = decodeURI(one[1]);
            });
            return pm;
        },
        convertImgToBase64: function (url, callback, outputFormat) {
            var canvas = document.createElement('CANVAS'),
                ctx = canvas.getContext('2d'),
                img = new Image;
            img.crossOrigin = 'Anonymous';
            img.onload = function () {
                canvas.height = img.height;
                canvas.width = img.width;
                ctx.drawImage(img, 0, 0);
                var dataURL = canvas.toDataURL(outputFormat || 'image/png');
                callback.call(this, dataURL);
                canvas = null;
            };
            img.src = url;
        },
        /**
         * 获取图片大小
         * @param url 地址
         * @param su 回调
         */
        imgSize: function (url, su) {
            var img = new Image();
            img.src = url;
            if (img.complete) {
                run();
            } else {
                img.onload = function () {
                    run();
                };
                img.onerror = function () {
                    run();
                };
            }

            function run() {
                if (su) su(img.width, img.height, img);
            }
        },
        /**
         * 两数百分比
         * @param num 数字
         * @param total 总数
         * @returns {*} 百分比
         */
        percent: function (num, total) {
            num = parseFloat(num);
            total = parseFloat(total);
            if (isNaN(num) || isNaN(total)) {
                return "-";
            }
            return total <= 0 ? 0 : Math.round(num / total * 10000) / 100.00;
        },
        /**
         * 判断是否大图
         * @param url 地址
         * @param yes 回调
         * @param no 回调
         */
        imgIsBig: function (url, yes, no) {
            var _ = this;
            this.imgSize(url, function (w, h) {
                if (_.percent(h, w) < 83) {
                    yes();
                } else {
                    no();
                }
            });
        },
        /**
         * 表单拼装
         * @param url 地址
         * @param param 参数
         * @param method 请求方法
         */
        formGender: function (url, param, method) {
            method = method || "";

            var $from = $("<form id='" + new Date().getTime() + "' action='" + url + "' method='" + method + "'></form>");
            for (var name in param) {
                //noinspection JSUnfilteredForInLoop
                $from.append("<input type='hidden' name='" + name + "' value='" + param[name] + "'>")
            }
            return $from[0];
        },
        /**
         * 表单生成并提交
         * @param url 地址
         * @param param 参数
         * param method 请求方法
         */
        formGenderSubmit: function (url, param, method) {
            var $f = $("<div style='widows: 0;height: 0;'></div>");
            var form = this.formGender(url, param, method);
            var id = form.getAttribute("id");
            $f.append(form);
            $("body").append($f);
            document.forms[id].submit();
        },
        /**
         * @param s HTML
         * @returns {string|XML} 替换掉所有的 html标签，得到Html标签中的内容
         */
        filterLabel: function (s) {
            var dd = s.replace(/<\/?.+?>/g, "");
            return dd.replace(/&nbsp;/g, ""); //dds为得到后的内容
        },
        /**
         * 检测嗯见是否是图片
         * @param name 文件名
         * @param isAlert 不是图片是否弹出
         * @returns {string} 不是图片提示
         */
        fileIsImg: function (name, isAlert) {
            if (name.toString() === "[object File]") name = name.name;
            var b = /\.(gif|jpg|jpeg|png|GIF|JPG|PNG)$/.test(name);
            if (!b && !isAlert) alert("图片类型必须是.gif,jpeg,jpg,png中的一种");
            return b;
        },
        fileIsImgNA: function (name) {
            return this.fileIsImg(name, true);
        },
        getRoundedCanvas: function (sourceCanvas) {
            var canvas = document.createElement('canvas');
            var context = canvas.getContext('2d');
            var width = sourceCanvas.width;
            var height = sourceCanvas.height;

            canvas.width = width;
            canvas.height = height;

            context.imageSmoothingEnabled = true;
            context.drawImage(sourceCanvas, 0, 0, width, height);
            context.globalCompositeOperation = 'destination-in';
            context.beginPath();
            context.arc(width / 2, height / 2, Math.min(width, height) / 2, 0, 2 * Math.PI, true);
            context.fill();

            return canvas;
        },
        /**
         * 所有参数
         */
        allParame: function () {
            var url = location.search; //获取url中"?"符后的字串
            var theRequest = new Object();
            if (url.indexOf("?") != -1) {
                var str = url.substr(1);
                strs = str.split("&");
                for (var i = 0; i < strs.length; i++) {
                    theRequest[strs[i].split("=")[0]] = unescape(strs[i].split("=")[1]);
                }
            }
            return theRequest;
        },
        /**
         * 刪除cookie
         * @param {Object} name 名字
         */
        removeCookie: function (name) {
            this.setCookie(name, null, -1);
        },
        /**
         * base64文件编码转出BOLB对象
         * @param {Object} base64 文件BASE64编码
         * @return BLOB
         */
        base64ToBlob: function (base64) {
            var mimeString = base64.split(',')[0].split(':')[1].split(';')[0]; // mime类型
            var byteString = atob(base64.split(',')[1]); //base64 解码
            var arrayBuffer = new ArrayBuffer(byteString.length); //创建缓冲数组
            var intArray = new Uint8Array(arrayBuffer); //创建视图
            for (i = 0; i < byteString.length; i += 1) {
                intArray[i] = byteString.charCodeAt(i);
            }

            return new Blob([intArray], {
                type: mimeString
            }); //转成blob
        },
        /**
         *   写cookies
         * @param name 名字
         * @param value 值
         */
        setCookie: function (name, value, time, path) {
            path = path || "/";
            time = time || 30 * 24 * 60 * 60 * 1000
            var exp = new Date();
            exp.setTime(exp.getTime() + time);
            document.cookie = name + "=" + encodeURIComponent(value) + ";expires=" +
                exp.toGMTString() + ";path=" + path;
        },
        /**
         *   写cookies
         * @param name 名字
         * @param value 值
         * @param path 路径
         */
        setCookieSession: function (name, value, path) {
            path = path || "/";
            document.cookie = name + "=" + encodeURIComponent(value) + ";path=" + path;
        },
        getCookie: function (name) {
            var arr, reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");
            if (arr = document.cookie.match(reg))
                return unescape(arr[2]);
            else
                return null;
        },
        /**
         * 计算两时间段的小时+分钟数量
         * @param {Object} startDate开始时间
         * @param {Object} endDate 结束时间
         @return  [1,23]
         **/
        minutesOfTimeDifference: function (startDate, endDate) {
            var format = "yyyy-MM-dd hh:mm";
            var dt1 = endDate.format(format);
            var dt2 = startDate.format(format);
            var regTime = /(\d{4})-(\d{1,2})-(\d{1,2})( \d{1,2}:\d{1,2})/g;
            var interval = Math.abs(Date.parse(dt1.replace(regTime, "$2-$3-$1$4")) - Date.parse(dt2.replace(regTime, "$2-$3-$1$4"))) / 1000;
            var h = Math.floor(interval / 3600);
            var m = Math.floor(interval % 3600 / 60);
            return [h, m];
        },
        /**
         * 计算两时间段的 分钟数量
         * @param {Object} startDate 开始时间
         * @param {Object} endDate 结束时间
         @return  180
         **/
        timeDifferenceMinutes: function (startDate, endDate) {
            var ds = this.timeDifferenceByDay(endDate, startDate);
            return ds[0] * 24 * 60 + ds[1] * 60 + ds[2];
        },
        /**
         * 计算两时间相差的天时分秒
         * @param {Object} startDate 开始时间
         * @param {Object} endDate 结束时间
         */
        timeDifferenceByDay: function (startDate, endDate) {
            var date3 = startDate.getTime() - endDate.getTime(); //时间差的毫秒数

            //计算出相差天数
            var days = Math.floor(date3 / (24 * 3600 * 1000))

            //计算出小时数

            var leave1 = date3 % (24 * 3600 * 1000) //计算天数后剩余的毫秒数
            var hours = Math.floor(leave1 / (3600 * 1000))
            //计算相差分钟数
            var leave2 = leave1 % (3600 * 1000) //计算小时数后剩余的毫秒数
            var minutes = Math.floor(leave2 / (60 * 1000))
            //计算相差秒数
            var leave3 = leave2 % (60 * 1000) //计算分钟数后剩余的毫秒数
            var seconds = Math.round(leave3 / 1000)
            return [days, hours, minutes, seconds];
        },
        /**
         * 对象属性NULL值删除
         * @param {Object} data 对象
         */
        objRemoveUnit: function (data) {
            for (var i in data) {
                // noinspection EqualityComparisonWithCoercionJS
                if (data[i] == null || data[i] === "") delete data[i];
            }
        },
        /**
         * 获取文件base64编码
         * @param file 文件
         * @param success 成功回调
         */
        getBase64: function (file, success) {
            var reader = new FileReader();
            reader.readAsDataURL(file);
            reader.onload = function (e) {
                if (success) success(this.result);
            }
        },
        /**
         *JSON转URK参数
         * @param param 字符串
         * @returns {string}
         */
        parseParam: function (param) {
            var paramStr = "";
            for (var name in param) {
                if (param[name] != null) {
                    paramStr += "&" + name + "=" + param[name];
                }
            }
            return paramStr.substr(1);
        },
        /**
         * 时间戳转date
         * @param ns 时间戳
         * @returns {Date}
         */
        timestampParseDate: function (ns) {
            return new Date(parseInt(ns));
        },
        /**
         *  时间格式化 yyyy-MM-dd
         * @param date 时间
         * @returns {*}
         */
        dateFormatYMD: function (date) {
            return date.format("yyyy-MM-dd");
        },
        /**
         * 大参数传输
         * @param {Object} data 数据
         * @param {Object} id 标识
         */
        bigParameter: function (data, id) {
            id = id || location.href.split("?")[0];
            if (data) {
                if (typeof data == "string") {
                    localStorage[bigParameterFix + id] = data;
                } else {
                    localStorage[bigParameterFix + id] = JSON.stringify(data);
                }
            }
        },
        /**
         * 获取参数
         * @param {Object} id 表述
         * @param {Object} name key
         */
        getBigParameter: function (id, name) {
            id = id || document.referrer.split("?")[0];

            var json = JSON.parse(localStorage[bigParameterFix + id]);
            if (name) {
                return json[name];
            }
            return json;
        },
        /**
         * 页面大数据设置
         * @param {Object} data 数据
         *  @param {Object} id 标识
         */
        setBigParame: function (data, id) {
            var fd = {};
            fd[bigParameterName] = data;
            this.bigParameter(fd, id);
        },
        /**
         * 大数据获取
         * @param {Object} id 标识
         */
        getBigParame: function (id) {
            return this.getBigParameter(id, bigParameterName);
        },
        /**
         * 时间格式化 格式 yyyy-MM-dd hh:mm:ss
         * @param date 时间
         * @returns {*}
         */
        dateFormatYMDHMS: function (date) {
            return date.format("yyyy-MM-dd hh:mm:ss");
        },
        /**
         * 时间格式化 格式 yyyy-MM-dd
         * @param date 时间
         * @returns {*}
         */
        dateFormatYMD: function (date) {
            return date.format("yyyy-MM-dd");
        },
        /**
         * 时间格式化 格式 yyyy-MM-dd hh:mm
         * @param date 时间
         * @returns {*}
         */
        dateFormatYMDHM: function (date) {
            return date.format("yyyy-MM-dd hh:mm");
        },
        /**
         *时间戳格式化
         * @param ns 时间戳
         * @returns {*}
         */
        timestampFormatYMDHMS: function (ns) {
            return cm.dateFormatYMDHMS(cm.timestampParseDate(ns));
        },
        /**
         *时间戳格式化
         * @param ns 时间戳
         * @returns {*}
         */
        timestampFormatYMD: function (ns) {
            return cm.dateFormatYMD(cm.timestampParseDate(ns));
        },
        /**
         *时间戳格式化
         * @param ns 时间戳
         * @returns {*}
         */
        timestampFormatMDHM: function (ns) {
            return cm.dateFormatMDHM(cm.timestampParseDate(ns));
        },
        dateFormatMDHM: function (date) {
            return date.format("MM-dd hh:mm");
        },
        /**
         *时间戳格式化
         * @param ns 时间戳
         * @returns {*}
         */
        timestampFormatHM: function (ns) {
            return cm.dateFormatHM(cm.timestampParseDate(ns));
        },
        dateFormatHM: function (date) {
            return date.format("hh:mm");
        },
        /**
         *时间戳格式化
         * @param ns 时间戳
         * @returns {*}
         */
        timestampFormatYMDHM: function (ns) {
            return cm.dateFormatYMDHM(cm.timestampParseDate(ns));
        },
        /**
         * 时间戳格式化
         * @param ns 时间戳
         * @param format 格式
         */
        timestampFormat: function (ns, format) {
            return cm.timestampParseDate(ns).format(format);
        },
        /**
         * 设置/添加 url参数
         * @param {Object} name 参数名
         * @param {Object} value 值
         * @param {Object} url 地址
         * @param {Object} isJump 是否跳转页面
         */
        setUrlPara: function (name, value, url, isJump) {
            url = url || window.location.href;
            var currentUrl = url.split('#')[0];
            if (/\?/g.test(currentUrl)) {
                if (/name=[-\w]{4,25}/g.test(currentUrl)) {
                    currentUrl = currentUrl.replace(/name=[-\w]{4,25}/g, name + "=" + value);
                } else {
                    var q = currentUrl.split("?")[1],
                        keyValues = q.split("&"),
                        has = false;

                    for (var i = 0; i < keyValues.length; i++) {
                        var keyValue = keyValues[i];
                        keyValue = keyValue.split("=");
                        if (name == keyValue[0]) {
                            keyValues[i] = name + "=" + value;
                            has = true;
                            break;
                        }
                    }
                    if (has == false) {
                        keyValues[keyValues.length] = name + "=" + value;
                    }
                    q = "";
                    for (var i = 0; i < keyValues.length; i++) {
                        var keyValue = keyValues[i];
                        keyValue = keyValue.split("=");
                        q += "&" + keyValue[0] + "=" + keyValue[1];
                    }
                    q = q.substr(1);
                    currentUrl = currentUrl.split("?")[0] + "?" + q;
                }
            } else {
                currentUrl += "?" + name + "=" + value;
            }
            if (url.split('#')[1]) {
                currentUrl = currentUrl + '#' + urls.split('#')[1];

            }
            if (isJump) {
                window.location.href = currentUrl;
            } else {
                return currentUrl;
            }
        },
        /**
         * 生随机数
         * @param {Object} n 位数
         */
        random: function (n) {
            n = n || 4;
            var t = "";
            for (var i = 0; i < n; i++) {
                t += Math.floor(Math.random() * 10);
            }
            return t;
        },
        /**
         * 时间戳转date对象
         * @param {Object} timestamp 时间戳
         */
        timestampParseDate: function (timestamp) {
            return new Date(timestamp);
        },
        toString: function () {
            return "";
        },
        parseJson: function (string) {
            //			return JSON.parse($.base64.decode(string));
            return JSON.parse(utf8to16(base64decode(string)));
        },
        /**
         * 合并两个json对象属性为一个对象
         * @param jsonbject1
         * @param jsonbject2
         * @returns resultJsonObject
         */
        merge: function (jsonbject1, jsonbject2) {
            if (jsonbject1 == null) {
                jsonbject1 = {};
            }
            for (var attr in jsonbject2) {
                jsonbject1[attr] = jsonbject2[attr];
            }
            return jsonbject1;
        },
        /**
         * 获取URL参数
         * @param {Object} paramName
         */
        getParam: function (paramName) {
            return this.getParameHref(paramName);
        },
        /**
         * 获取URL参数
         * @param {Object} paramName
         */
        getParamJson: function (paramName) {
            return JSON.parse(this.getParam(paramName));
        },
        getParamJsonData: function () {
            return this.getParamJson("data");
        },
        getParameHref: function (name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
            var r = window.location.search.substr(1).match(reg);
            if (r != null)
                return decodeURIComponent(decodeURIComponent(decodeURIComponent(r[2])));
            return null;
        },
        getParameUrl: function (search, name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
            var r = search.substr(1).match(reg);
            if (r != null)
                return decodeURIComponent(decodeURIComponent(decodeURIComponent(r[2])));
            return null;
        },
        /**
         * 截取一段字符串的开头的数字
         * @param {Object} string 字符串
         */
        subStrStartNumber: function (string) {
            var numberStr = "",
                isFu = false;
            if (string[0] == "-") {
                string = string.substr(1);
                isFu = true;
            }
            for (var i = 0; i < string.length; i++) {
                var charStr = string[i];
                if (charStr.isNumber()) {
                    numberStr += charStr;
                } else {
                    break;
                }
            }
            if (isFu) {
                numberStr = "-" + numberStr;
            }
            return numberStr;
        },
        logFormat: function (data) {
            console.log(JSON.stringify(data));
        },
        isApp: function () {
            try {
                plus.android;
                return true;
            } catch (e) {
                return false;
            }
            /*if (plus) {
             return true;
             } else {
             return false;
             }*/
        },
        back: function (parame) {
            if (this.isApp() == false) {
                history.go(-1);
            } else {
                this.appGetParame(parame);
                // 解锁并关闭
                var _back = window.back;
                plus.screen.unlockOrientation();
                _back();
            }
        },
        href: function (html, type) {
            if (this.isApp() == false) {
                location.href = html;
            } else {
                var hrefs = html.split("?");
                this.appSetParame(hrefs[1]);

                var ws = null,
                    wp = null,
                    wo = null;

                // H5 plus事件处理
                function plusReady() {
                    ws = plus.webview.currentWebview();
                    wo = ws.opener();
                    wp = plus.webview.create(hrefs[0], hrefs[0], {
                        scrollIndicator: 'none',
                        scalable: false,
                        popGesture: 'none'
                    }, {
                        preate: true
                    });
                }

                if (window.plus) {
                    plusReady();
                } else {
                    document.addEventListener('plusready', plusReady, false);
                }

                // 动画窗口
                function animateWindow(type) {
                    wp.show(type);
                }

                // 关闭窗口
                var _back = window.back;

                function preateBack() {
                    if (!ws.preate) {
                        wp && wp.close();
                    }
                    _back();
                }

                window.back = preateBack;
                setTimeout(animateWindow(type), 2000);

                /*
                 var wpOne;
                 wpes.each(function(i, one) {
                 if (one.html == html) {
                 wpOne = one.wp;
                 return false;
                 }
                 })
                 animateWindow(type, wpOne);*/
            }
        },
        hrefForward: function (html) {
            this.href(html, "fade-in");
        },
        hrefBack: function (html) {
            this.href(html, "slide-in-left");
        },
        hrefUserInfo: function () {
            clickedBack("wode_ziliao.html");
            //			this.hrefBack("wode_ziliao.html");
        },
        hrefSetting: function () {
            clickedBack("shezhi.html");
        },
        appSetParame: function (parame) {
            localStorage[location.pathname] = parame;
        },
        appGetParame: function (name) {
            var parame = localStorage[location.pathname];
            if (!this.isEmpty(parame)) {
                if (!this.isEmpty(name)) {
                    parame = getParameUrl(name);
                }
            }
            return parame;
        },
        jsonParseParame: function (json) {
            var parameStr = "";
            for (var one in json) {
                var value = json[one];
                /*if (this.isUrlEncodedValue(value) == true) {
                 value = encodeURI(value);
                 }*/
                parameStr += "&" + one + "=" + encodeURI(encodeURI(value));
            }
            return encodeURI("?" + parameStr.substr(1));
        },
        /**
         * 發佈時間轉換
         * @param {Object} time 時見
         */
        issuedDateShow: function (time) {
            time = cm.timestampParseDate(time);
            var now = new Date();
            var c = cm.timeDifferenceMinutes(time, now);

            var nowF = now.getFullYear();
            var pF = time.getFullYear();
            if (nowF > pF) {
                return nowF - pF + "年";
            }
            if (c < 60) {
                return c + "分钟";
            } else if (c < 60 * 24) {
                return Math.round(c / 60) + "小时";
            }

            return Math.round(c / (60 * 24)) + "天";
        },
        isUrlEncodedValue: function (value) {
            /*	if (value.indexOf("&") != -1 || value.indexOf("=") != -1) {
             return true;
             } else {
             return false;
             }*/
            return true;
        },
        stringIsEmpty: function (string) {
            if (typeof (string) == "undefined" || string == "" || string == null) {
                return true;
            }
            string += "";
            if (string.trim() == "") {
                return true;
            }
            return false;
        },
        /**
         * 生成闭包内注释
         * @param {Object} fn 闭包
         */
        hereDoc: function (fn) {
            var text = fn.toString().split('\n').slice(1, -1).join('\n') + '\n';
            text = text.substr(text.indexOf("/*") + 2);
            text = text.substr(0, text.lastIndexOf("*/"));
            return text;
        },
        fRun: function (fn) {
            if (fn != null) {
                var ps = [];
                for (var i = 1; i < arguments.length; i++) {
                    ps[i - 1] = arguments[i];
                }
                fn(ps);
            }
        },

    };
    global.common = common;
    global.cm = new common();

    //----
    Date.prototype.dateFormatYMD = cm.dateFormatYMD;
    Date.prototype.dateFormatYMDHMS = cm.dateFormatYMDHMS;
    window.hereDoc = cm.hereDoc;
})(window);

(function (Obj) {
    function altTmplCm() {
    };

    altTmplCm.prototype = {
        /**
         * 节点添加
         * @param {Object} tmpl 模板
         * @param {Object} idFix ID前缀
         */
        tmplLoad: function (tmpl, idFix) {
            var content = "";
            var type = typeof tmpl;
            switch (type) {
                case "string":
                    content += tmplElGender(idFix, tmpl);
                    break;
                case "object":
                    for (var i in tmpl) {
                        var it = tmpl[i];
                        if (it) {
                            if (typeof it == "string") {
                                content += this.tmplElGender(idFix + "." + i, tmpl[i]);
                            }
                        }
                    }

                    break;
                default:
                    break;
            }
            var div = document.createElement("div");
            div.setAttribute("style", "width: 0;height: 0;");
            div.innerHTML = content;
            var body = document.body;
            if (body) {
                body.appendChild(div);
            } else {
                window.onload = function () {
                    document.body.appendChild(div);
                }
            }
        },
        /**
         * 模板添加
         * @param {Object} id ID
         * @param {Object} content 内容
         */
        tmplElGender: function (id, content) {
            return "<script id=" + id + ">" + content + "</script>";
        }
    };

    Obj.AltTmplCm = altTmplCm;
    Obj.altTmplCm = new AltTmplCm();
})(window);

Loader = (function () {

    var loadScript = function (url) {
        var script = document.createElement('script');
        script.setAttribute('src', url + '?' + 'time=' + Date.parse(new Date())); // 不用缓存
        document.body.appendChild(script);
    };

    var loadMultiScript = function (urlArray) {
        for (var idx = 0; idx < urlArray.length; idx++) {
            loadScript(urlArray[idx]);
        }
    };

    return {
        load: loadMultiScript,
    };

})();

if (window.template) {
    template.helper("$timestampFormatYMDHM", cm.timestampFormatYMDHM);
    template.helper("$timestampFormatYMDHMS", cm.timestampFormatYMDHMS);
    template.helper("$timestampFormatYMDHM", cm.timestampFormatYMDHM);
    template.helper("$timestampFormatYMD", cm.timestampFormatYMD);
    template.helper("$timestampFormatMDHM", cm.timestampFormatMDHM);
    template.helper("$timestampFormatHM", cm.timestampFormatHM);
    template.helper("timeFormat", cm.timestampFormat);
    template.helper("timeFormat2", function (tn) {
        return cm.timestampFormat(tn, "yy/MM/dd hh:mm");
    });

    template.helper("$jsonToString", function (json) {
        return JSON.stringify(json);
    });

    template.helper("$filterLabel", cm.filterLabel);

    template.helper("parseJSON", function (json, name) {
        return JSON.parse(json)[name];
    });
    template.helper("show", function (name) {
        if (name) return name;
        return "-";
    });
}
/**
 * HTTP
 * @param {Object} window 全局对象
 */
(function (window) {
    var http = function () {
    };

    http.prototype = {
        /**
         * 获取状态码的描述信息
         * @param {Object} code 状态码
         */
        codeDesc: function (code) {
            var status = this.statusCode[code];
            var desc;
            if (status) desc = status.desc;
            desc = desc || "未知错误";
            return desc;
        },
        /**
         * 状态信息
         */
        statusCode: {
            100: {
                desc: "是否可以在后续的请求中发送附件"
            },
            101: {
                desc: "转换协议"
            },
            200: {
                desc: "请求成功"
            },
            201: {
                desc: "已建立了新文档"
            },
            202: {
                desc: "请求正在被执行，但还没有处理完"
            },
            0: {
                desc: "请求超时或无网络连接/服务不可以用"
            },
            203: {
                desc: "文档被正常的返回，响应头信息可能不正确"
            },
            204: {
                desc: "没有内容，检查页面是否已经更新"
            },
            205: {
                desc: "没有新文档但浏览器要重置文档显示。将强迫浏览器清除表单域"
            },
            300: {
                desc: "Multiple Choices/多重选择"
            },
            301: {
                desc: "浏览器会自动连接到新的UR"
            },
            303: {
                desc: "See Other/参见其他信息"
            },
            304: {
                desc: "Not Modified/为修正"
            },
            305: {
                desc: "Use Proxy/使用代理"
            },
            307: {
                desc: "Temporary Redirect/临时重定向"
            },
            400: {
                desc: "Bad Request/错误请求,参数可能有误"
            },
            401: {
                desc: "Unauthorized/没有权限访问"
            },
            403: {
                desc: "Forbidden/禁止访问"
            },
            404: {
                desc: "Not Found/未找到，地址不存在"
            },
            405: {
                desc: "Method Not Allowed/方法未允许"
            },
            406: {
                desc: "Not Acceptable/无法访问"
            },
            407: {
                desc: "Proxy Authentication Required/代理服务器认证要求"
            },
            408: {
                desc: "Request Timeout/请求超时"
            },
            409: {
                desc: "Conflict/冲突"
            },
            410: {
                desc: "Gone/已经不存在"
            },
            411: {
                desc: "Length Required/需要数据长度"
            },
            412: {
                desc: "Precondition Failed/先决条件错误"
            },
            413: {
                desc: "Request Entity Too Large/请求实体过大"
            },
            414: {
                desc: "Request URI Too Long/请求URI过长"
            },
            415: {
                desc: "Unsupported Media Type/不支持的媒体格式"
            },
            416: {
                desc: "Requested Range Not Satisfiable/请求范围无法满足"
            },
            417: {
                desc: "Expectation Failed/期望失败"
            },
            500: {
                desc: "Internal Server Error/内部服务器错误"
            },
            501: {
                desc: "Not Implemented/未实现"
            },
            502: {
                desc: "Bad Gateway/错误的网关"
            },
            503: {
                desc: "Service Unavailable/服务无法获得"
            },
            504: {
                desc: "Gateway Timeout/网关超时"
            },
            505: {
                desc: "HTTP Version Not Supported/不支持的 HTTP 版本"
            }
        }
    }

    window.HTTP = http;
    window.http = new HTTP();
})(window);
