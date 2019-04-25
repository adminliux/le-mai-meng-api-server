//验证是否是汉字
function chinese(o) {
	if (!/^[\u4e00-\u9fa5]+$/gi.test($(o).val())) {
		alert("只能输入汉字");
		$(o).val('');
	}
}
// 判断是否为空
function isEmpty(s) {
	return s == '' || s == undefined || s == null ? true : false;
}
// 判断是否有效
function isValid(s, jack) {
	if (s == "" || s == undefined || s == null) {
		alert(jack + "不能为空");
		return false;
	}
	return true;
}
// 跳转页面
var jump = function(f, back) {
	if (back) {
		history.go(-1);
	} else {
		location.href = f;
	}
};
// 手机验证
var phone = function(mobile) {
	var reg = /^(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/;
	if (!reg.test(mobile)) {
		alert("请输入正确手机号！");
		return false;
	} else {
		return true;
	}
}

// 银行卡是否有效
function banknum(banknum) {
	var reg = /^\d{16}|\d{19}$/;
	if (!reg.test(banknum)) {
		alert("请输入正确格式的银行卡号！");
		return false;
	} else {
		return true;
	}
}
function isNum(val, jack) {
	if (!isNaN(val)) {
		return true;
	} else {
		alert(jack + "请输入数字");
		return false;
	}
}
function isNum1(val, jack) {
	if (!isNaN(val)) {
		return true;
	} else {
		return false;
	}
}

function CheckMail(mail) {
	var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
	if (filter.test(mail))
		return true;
	else {
		alert('您的电子邮件格式不正确');
		return false;
	}
}

// 长度校验
function validateLength(obj, n, m) {
	var l = obj.val().trim().length;
	if (l <= m && l >= n) {
		return true;
	} else {
		return false;
	}
};

// 身份证验证
function isCardID(sId) {
	var aCity = {
		11 : "北京",
		12 : "天津",
		13 : "河北",
		14 : "山西",
		15 : "内蒙古",
		21 : "辽宁",
		22 : "吉林",
		23 : "黑龙江",
		31 : "上海",
		32 : "江苏",
		33 : "浙江",
		34 : "安徽",
		35 : "福建",
		36 : "江西",
		37 : "山东",
		41 : "河南",
		42 : "湖北",
		43 : "湖南",
		44 : "广东",
		45 : "广西",
		46 : "海南",
		50 : "重庆",
		51 : "四川",
		52 : "贵州",
		53 : "云南",
		54 : "西藏",
		61 : "陕西",
		62 : "甘肃",
		63 : "青海",
		64 : "宁夏",
		65 : "新疆",
		71 : "台湾",
		81 : "香港",
		82 : "澳门",
		91 : "国外"
	}

	var iSum = 0;
	var info = "";
	if (!/^\d{17}(\d|x)$/i.test(sId)) {
		alert("你输入的身份证长度或格式错误");
		return false;
	}
	sId = sId.replace(/x$/i, "a");
	if (aCity[parseInt(sId.substr(0, 2))] == null) {
		alert("你的身份证地区非法");
		return false;
	}
	sBirthday = sId.substr(6, 4) + "-" + Number(sId.substr(10, 2)) + "-"
			+ Number(sId.substr(12, 2));
	var d = new Date(sBirthday.replace(/-/g, "/"));
	if (sBirthday != (d.getFullYear() + "-" + (d.getMonth() + 1) + "-" + d
			.getDate())) {
		alert("身份证上的出生日期非法");
		return false;
	}
	for (var i = 17; i >= 0; i--)
		iSum += (Math.pow(2, i) % 11) * parseInt(sId.charAt(17 - i), 11);
	if (iSum % 11 != 1) {
		alert("你输入的身份证号非法");
		return false;
	}
	// aCity[parseInt(sId.substr(0,2))]+","+sBirthday+","+(sId.substr(16,1)%2?"男":"女");//此次还可以判断出输入的身份证号的人性别
	return true;
}

// 倒计时
function getRTime(endTiemF) {
	var EndTime = new Date(endTiemF);
	var NowTime = new Date();
	var t = EndTime.getTime() - NowTime.getTime();

	var d = Math.floor(t / 1000 / 60 / 60 / 24);
	d = d * 24;
	var h = Math.floor(t / 1000 / 60 / 60 % 24);
	h = d + h;
	var m = Math.floor(t / 1000 / 60 % 60);
	var s = Math.floor(t / 1000 % 60);
	if (h == 0 && m == 0 && s == 0) {
		return 0;
	}
	var showT = h + "时" + m + "分" + s + "秒";
	return showT;
}

// 判断数组是否有
function isRepeat(arr) {
	// 过滤重复值
	var result = [], hash = {};
	for (var i = 0, elem; (elem = arr[i]) != null; i++) {
		if (!hash[elem]) {
			result.push(elem);
			hash[elem] = true;
		}
	}

	if (result.length >= 2) {// 有重复值
		return false;
	} else {
		return true;
	}
}
