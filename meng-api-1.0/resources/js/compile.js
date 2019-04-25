var apiLoad = true, isApp = function () {
    return false;
};

function showProgress() {
}

function hideProgress() {
}

function toLogin() {
    location.href = pathPage + "/user/login";
}

/**
 * 转换JSON
 * @param v JSON字符串
 * @returns {*}
 */
function parseJSON(v) {
    try {
        return JSON.parse(v);
    } catch (e) {
        console.error(e);
        return v;
    }
}

function keyMosaic(name, key) {
    if (name && name !== "")
        return name + "." + key;
    return key;
}

function dataChildrenToString(data, name, old) {
    name = name || "";
    old = old || data;
    for (var key in data) {
        // noinspection JSUnfilteredForInLoop
        var v = data[key];
        if (typeof v === "object") {
            dataChildrenToString(v, keyMosaic(name, key), old);
        } else {
            old[keyMosaic(name, key)] = v;
        }
    }
    return data;
}

//自定义弹框
function h5Toast(msg, duration, click) {
    duration = isNaN(duration) ? 2000 : duration;
    var m = document.createElement('div');
    m.onclick = click;
    m.innerHTML = msg;
    m.style.cssText = "width:60%; min-width:150px; background:#000; opacity:0.5; height:40px; color:#fff;" +
        "line-height:40px; text-align:center; border-radius:5px; position:fixed; top:40%; left:20%; z-index:999999; font-weight:bold;font-size:0.5em";
    document.body.appendChild(m);
    setTimeout(function () {
        var d = 0.5;
        m.style.webkitTransition = '-webkit-transform ' + d + 's ease-in, opacity ' + d + 's ease-in';
        m.style.opacity = '0';
        setTimeout(function () {
            document.body.removeChild(m);
        }, d * 1000);
    }, duration);
}

function toast(msg, click) {
    h5Toast(msg, 2000, click);
}