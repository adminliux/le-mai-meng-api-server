<@frame.businessV2 title="${title}">
    <#include "public/var.ftl">
<style>
    .chats-wrapper {
        position: absolute;
        top: 0px;
        left: 0px;
        right: 0px;
        bottom: 0px;
        background: #f0f3f4;
        overflow: auto;
    }

    .chats-wrapper .nav {
        width: 95%;
        margin: 0 auto;
        padding-top: 10px;
        display: flex;
    }

    .chats-wrapper .nav > a {
        border: 1px solid gainsboro;
        height: 40px;
        line-height: 40px;
        color: #777;
        background-color: #fff;
        margin: 0px;
        flex: 1;
        text-align: center;
    }

    .chats-wrapper .chats-item {
        border: 1px solid #eeeeee;
        background: #fff;
        width: 95%;
        margin: 0 auto;
        box-shadow: 0 1px 1px rgba(0, 0, 0, .05);
        margin-bottom: 10px;
    }

    .chats-wrapper .chats-item h2 {
        border-bottom: 1px solid #edf1f2;
        background-color: #f6f8f8;
        height: 40px;
        line-height: 40px;
        padding-left: 10px;
        margin-top: 0px;
    }

    .chats-wrapper .chats-item .chats-buttons {
        border-bottom: 1px solid #edf1f2;
        height: 40px;
        width: 100%;

    }

    .chats-wrapper .chats-item .chats-buttons a {
        width: 60px;
        display: inline-block;
        border: 1px solid gainsboro;
        padding: 4px 10px;
        color: #777;
        background-color: #fff;
        border-radius: 4px;
        text-align: center;
        margin-left: 10px;
    }

    .chats-wrapper .chats-item .chats-buttons select {
        height: 30px;
        padding: 0px 10px;
        background-color: #fff;
        background-image: none;
        border: 1px solid #cfdadd;
        color: #777;
        margin-bottom: 5px;
        vertical-align: top;
    }

    .chats-wrapper .chats-item .chats-buttons input[disabled] {
        background: #CCCCCC;
    }

    .chats-wrapper .chats-item .content {

    }

    .chats-wrapper .chats-item .content > div {
        width: 80%;
        height: 400px;
        margin: 0 auto;
    }
</style>
<script src="${path}/resources/js/echarts.js"></script>
<script src="${path}/resources/laydate/laydate.js"></script>
<div class="chats-wrapper">
    <div class="nav">
        <a href="#zt">车辆状况</a>
        <a href="#yecz">余额充值</a>
        <a href="#ye">余额退款</a>
        <a href="#yjcz">押金充值</a>
        <a href="#yj">押金退款</a>
        <a href="#wd">新增网点</a>
        <a href="#cl">新增车辆</a>
        <a href="#cs">使用车次</a>
        <a href="#use">使用中车辆</a>
    </div>
    <div class="nav">
        <a href="#hy">会员状况</a>
        <a href="#xzhy">新增会员人数</a>
        <a href="#tkrs">会员押金退款</a>
        <a href="#hvyj">会员押金充值</a>
        <a href="#yysr">总运营收入</a>
    </div>
    <div class="chats-item">
        <h2 id="zt">车辆状况</h2>
        <div class="chats-buttons"></div>
        <div class="content">
            <div id="Car"></div>
        </div>
    </div>
    <div class="chats-item">
        <h2 id="yecz">余额充值</h2>
        <div class="chats-buttons">
            <a onclick="getBalanceAdd(1)">天</a>
            <a onclick="getBalanceAdd(2)">周</a>
            <a onclick="getBalanceAdd(3)">月</a>
            <a onclick="getBalanceAdd(4)">年</a>
        </div>
        <div class="content">
            <div id="Addbalance" style="height: 600px"></div>
        </div>
    </div>
    <div class="chats-item">
        <h2 id="ye">余额退款</h2>
        <div class="chats-buttons">
            <a onclick="getBalanceTk(1)">天</a>
            <a onclick="getBalanceTk(2)">周</a>
            <a onclick="getBalanceTk(3)">月</a>
            <a onclick="getBalanceTk(4)">年</a>
        </div>
        <div class="content">
            <div id="balance" style="height: 600px"></div>
        </div>
    </div>
    <div class="chats-item">
        <h2 id="yjcz">押金充值</h2>
        <div class="chats-buttons">
            <a onclick="getBondAdd(1)">天</a>
            <a onclick="getBondAdd(2)">周</a>
            <a onclick="getBondAdd(3)">月</a>
            <a onclick="getBondAdd(4)">年</a>
        </div>
        <div class="content">
            <div id="Addbond" style="height: 600px"></div>
        </div>
    </div>
    <div class="chats-item">
        <h2 id="yj">押金退款</h2>
        <div class="chats-buttons">
            <a onclick="getBondTk(1)">天</a>
            <a onclick="getBondTk(2)">周</a>
            <a onclick="getBondTk(3)">月</a>
            <a onclick="getBondTk(4)">年</a>
        </div>
        <div class="content">
            <div id="bond" style="height: 600px"></div>
        </div>
    </div>
    <div class="chats-item">
        <h2 id="wd">新增网点</h2>
        <div class="chats-buttons">
            <a onclick="getAddBranch(1)">天</a>
            <a onclick="getAddBranch(2)">周</a>
            <a onclick="getAddBranch(3)">月</a>
            <a onclick="getAddBranch(4)">年</a>
        </div>
        <div class="content">
            <div id="Branch" style="height: 600px"></div>
        </div>
    </div>
    <div class="chats-item">
        <h2 id="cl">新增车辆</h2>
        <div class="chats-buttons">
            <a onclick="getAddCar(1)">天</a>
            <a onclick="getAddCar(2)">周</a>
            <a onclick="getAddCar(3)">月</a>
            <a onclick="getAddCar(4)">年</a>
        </div>
        <div class="content">
            <div id="addCar" style="height: 600px"></div>
        </div>
    </div>
    <div class="chats-item">
        <h2 id="cs">使用车次</h2>
        <div class="chats-buttons">
            <a onclick="getCarNumber(1)">天</a>
            <a onclick="getCarNumber(2)">周</a>
            <a onclick="getCarNumber(3)">月</a>
            <a onclick="getCarNumber(4)">年</a>
        </div>
        <div class="content">
            <div id="Number" style="height: 600px"></div>
        </div>
    </div>
    <div class="chats-item">
        <h2 id="use">使用中车辆</h2>
        <div class="chats-buttons">
            <a onclick="getUseCar(1)">天</a>
            <a onclick="getUseCar(2)">周</a>
            <a onclick="getUseCar(3)">月</a>
            <a onclick="getUseCar(4)">年</a>
        </div>
        <div class="content">
            <div id="useCar" style="height: 600px"></div>
        </div>
    </div>
    <div class="chats-item">
        <h2 id="hy">会员状况</h2>
        <div class="chats-buttons"></div>
        <div class="content">
            <div id="Member"></div>
        </div>
    </div>
    <div class="chats-item">
        <h2 id="xzhy">新增会员数量</h2>
        <div class="chats-buttons">
            <select name="" id="AddMemberSumSelect" class="select">
                <option value="1">天</option>
                <option value="2">月</option>
                <option value="3">年</option>
            </select>
            <input type="text" class="Wdate"
                   onClick="WdatePicker({dateFmt:'yyyy年'})" id="AddMemberSumYear"
                   placeholder="点击选择年份"/>
            <input type="text" class="Wdate"
                   onClick="WdatePicker({dateFmt:'MM月'})" id="AddMemberSumMonth"
                   placeholder="点击选择月份"/>
            <a onclick="getAddMember()">查询</a>
        </div>
        <div class="content">
            <div id="AddMember" style="height: 600px"></div>
        </div>
    </div>
    <div class="chats-item">
        <h2 id="tkrs">会员押金退款数量</h2>
        <div class="chats-buttons">

        </div>
        <div class="content">
            <div id="MemberBond" style="height: 600px"></div>
        </div>
    </div>
    <div class="chats-item">
        <h2 id="hvyj">会员押金充值数量</h2>
        <div class="chats-buttons">
            <select name="" id="AddMemberSelect" class="select">
                <option value="1">天</option>
                <option value="2">月</option>
                <option value="3">年</option>
            </select>
            <input type="text" class="Wdate"
                   onClick="WdatePicker({dateFmt:'yyyy年'})" id="AddMemberYear"
                   placeholder="点击选择年份"/>
            <input type="text" class="Wdate"
                   onClick="WdatePicker({dateFmt:'MM月'})" id="AddMemberMonth"
                   placeholder="点击选择月份"/>
            <a onclick="getAddMemberBond()">查询</a>
        </div>
        <div class="content">
            <div id="AddMemberBond" style="height: 600px"></div>
        </div>
    </div>
    <div class="chats-item">
        <h2 id="yysr">总运营收入</h2>
        <div class="chats-buttons">
            <select name="" id="IncomeSelect">
                <option value="1">天</option>
                <option value="2">月</option>
                <option value="3">年</option>
            </select>
            <select name="" id="IncomeBooleanSelect">
                <option value="true">整租</option>
                <option value="false">时租</option>
            </select>
            <input type="text" class="Wdate"
                   onClick="WdatePicker({dateFmt:'yyyy年'})" id="IncomeYear"
                   placeholder="点击选择年份"/>
            <input type="text" class="Wdate"
                   onClick="WdatePicker({dateFmt:'MM月'})" id="IncomeMonth"
                   placeholder="点击选择月份"/>
            <a onclick="getIncome()">查询</a>
        </div>
        <div class="content">
            <div id="Income" style="height: 600px"></div>
        </div>
    </div>
</div>
<script type="text/javascript">
    /*
    * init
    * */

    var now = new Date();
    var this_day = now.getFullYear() + '-' + (now.getMonth() + 1) + '-' + now.getDate();
    // 车辆状态
    var CarStatus = {
        USE: "使用中",
        FREE: "空闲",
        REPAIR: "维修",
        OFFLINE: "已下线"
    };
    // 会员状态
    var MemberStatus = {
        userSum: "会员总量",
        activeSum: "活跃会员",
        effectiveSum: '有效会员数量',
        corpseSum: "僵尸用户数"
    };

    /*
    * function
    * */
    // 设置车辆状态
    function setCarStatus(str) {
        for (var key in CarStatus) {
            if (str == key) {
                return CarStatus[key];
            }
        }
    }

    // 设置会员状态
    function setMemberStatus(str) {
        for (var key in MemberStatus) {
            if (str == key) {
                return MemberStatus[key];
            }
        }
    }

    // 统计车辆状态
    function getCarStatus() {
        var series = [];
        var legend = [];
        var myChart = echarts.init(document.getElementById('Car'));
        myChart.showLoading();
        var option = {
            title: {
                text: '车辆状况',
                x: 'center'
            },
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            legend: {
                orient: 'vertical',
                left: 'left',
                data: legend
            },
            series: [
                {
                    name: '车辆状况',
                    type: 'pie',
                    radius: '55%',
                    center: ['50%', '60%'],
                    data: series,
                    itemStyle: {
                        emphasis: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }
            ]
        };
        Project.ajax("/admin/user/capital/find/car", null, null, null).ajaxOK(function (rv) {
            for (var key in rv.data) {
                series.push({value: rv.data[key], name: setCarStatus(key)});
                legend.push(setCarStatus(key));
            }
            myChart.hideLoading();
            myChart.setOption(option);
        });
    }

    // 统计会员状态
    function getMemberStatus() {
        var series = [];
        var legend = [];
        var Member = echarts.init(document.getElementById('Member'));
        Member.showLoading();
        var option = {
            title: {
                text: '会员状况',
                x: 'center'
            },
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            legend: {
                orient: 'vertical',
                left: 'left',
                data: legend
            },
            series: [
                {
                    name: '会员状况',
                    type: 'pie',
                    radius: '55%',
                    center: ['50%', '60%'],
                    data: series,
                    itemStyle: {
                        emphasis: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }
            ]
        };
        Project.ajax("/admin/user/capital/find/user/detail", null, null, null).ajaxOK(function (rv) {
            console.log(rv);
            for (var key in rv.data) {
                series.push({value: rv.data[key], name: setMemberStatus(key)});
                legend.push(setMemberStatus(key));
            }
            Member.hideLoading();
            Member.setOption(option);
        });
    }

    //获取车辆使用次数
    function getCarNumber(number) {
        var xAxis = [];
        var series = [];
        var CarNumber = echarts.init(document.getElementById('Number'));
        CarNumber.showLoading();
        var CarNumberOption = {
            title: {
                text: '使用车次'
            },
            tooltip: {
                trigger: 'axis',
                axisPointer: {
                    type: 'cross'
                }
            },
            toolbox: {
                show: true,
                feature: {
                    saveAsImage: {}
                }
            },
            xAxis: {
                type: 'category',
                boundaryGap: false,
                data: xAxis
            },
            yAxis: {
                type: 'value',
                axisLabel: {
                    formatter: '{value} 次'
                },
                axisPointer: {
                    snap: true
                }
            },
            visualMap: {
                show: false,
                dimension: 0,
                pieces: [{
                    lte: 6,
                    color: 'green'
                }, {
                    gt: 6,
                    lte: 8,
                    color: 'red'
                }, {
                    gt: 8,
                    lte: 14,
                    color: 'green'
                }, {
                    gt: 14,
                    lte: 17,
                    color: 'red'
                }, {
                    gt: 17,
                    color: 'green'
                }]
            },
            series: [
                {
                    name: '使用次数',
                    type: 'line',
                    smooth: true,
                    data: series,
                    markArea: {
                        data: []
                    }
                }
            ]
        };

        Project.ajax("/admin/user/capital/find/car/number", {dayNumber: number}, null, null).ajaxOK(function (rv) {
            if (rv.data.length > 0) {
                for (var i = 0; i < rv.data.length; i++) {
                    xAxis.push(rv.data[i].dateTimes);
                    series.push(rv.data[i].countNumber + '');
                }
            } else {
                xAxis.push(this_day);
                series.push('0')
            }
            CarNumber.hideLoading();
            CarNumber.setOption(CarNumberOption);
        });

    }

    //获取新增网点数量
    function getAddBranch(number) {
        var series = [];
        var xAxis = [];
        var AddBranch = echarts.init(document.getElementById('Branch'));
        AddBranch.showLoading();
        var option = {
            tooltip: {
                trigger: 'axis',
                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            legend: {
                data: []
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            xAxis: [
                {
                    type: 'category',
                    data: xAxis
                }
            ],
            yAxis: [
                {
                    type: 'value'
                }
            ],
            series: [
                {
                    name: '新增网点',
                    type: 'bar',
                    data: series
                }
            ]
        };

        Project.ajax("/admin/user/capital/find/branch/add", {dayNumber: number}, null, null).ajaxOK(function (rv) {
            if (rv.data.length > 0) {
                for (var i = 0; i < rv.data.length; i++) {
                    xAxis.push(rv.data[i].dateTimes);
                    series.push(rv.data[i].countNumber + '');
                }
            } else {
                xAxis.push(this_day);
                series.push('0')
            }
            AddBranch.hideLoading();
            AddBranch.setOption(option);
        })
    }

    //获取新增车数量
    function getAddCar(number) {
        var series = [];
        var xAxis = [];
        var AddCar = echarts.init(document.getElementById('addCar'));
        AddCar.showLoading();
        var option = {
            tooltip: {
                trigger: 'axis',
                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            legend: {
                data: []
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            xAxis: [
                {
                    type: 'category',
                    data: xAxis
                }
            ],
            yAxis: [
                {
                    type: 'value'
                }
            ],
            series: [
                {
                    name: '新增车辆',
                    type: 'bar',
                    data: series
                }
            ]
        };

        Project.ajax("/admin/user/capital/find/car/add", {dayNumber: number}, null, null).ajaxOK(function (rv) {
            if (rv.data.length > 0) {
                for (var i = 0; i < rv.data.length; i++) {
                    xAxis.push(rv.data[i].dateTimes);
                    series.push(rv.data[i].countNumber + '');
                }
            } else {
                xAxis.push(this_day);
                series.push('0')
            }
            AddCar.hideLoading();
            AddCar.setOption(option);
        })
    }

    //获取使用中车数量
    function getUseCar(number) {
        var series = [];
        var xAxis = [];
        var UseCar = echarts.init(document.getElementById('useCar'));
        UseCar.showLoading();
        var option = {
            tooltip: {
                trigger: 'axis',
                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            legend: {
                data: []
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            xAxis: [
                {
                    type: 'category',
                    data: xAxis
                }
            ],
            yAxis: [
                {
                    type: 'value'
                }
            ],
            series: [
                {
                    name: '使用中车辆',
                    type: 'bar',
                    data: series
                }
            ]
        };

        Project.ajax("/admin/user/capital/find/car/use/number", {dayNumber: number}, null, null).ajaxOK(function (rv) {
            if (rv.data.length > 0) {
                for (var i = 0; i < rv.data.length; i++) {
                    xAxis.push(rv.data[i].dateTimes);
                    series.push(rv.data[i].countNumber + '');
                }
            } else {
                xAxis.push(this_day);
                series.push('0')
            }
            UseCar.hideLoading();
            UseCar.setOption(option);
        })
    }

    //获取余额充值
    function getBalanceAdd(number) {
        var series = [];
        var xAxis = [];
        var Addbalance = echarts.init(document.getElementById('Addbalance'));
        Addbalance.showLoading();
        var option = {
            tooltip: {
                trigger: 'axis',
                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            legend: {
                data: []
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            xAxis: [
                {
                    type: 'category',
                    data: xAxis
                }
            ],
            yAxis: [
                {
                    type: 'value'
                }
            ],
            series: [
                {
                    name: '余额充值',
                    type: 'bar',
                    data: series
                }
            ]
        };

        Project.ajax("/admin/user/capital/find/balance/or/bond/add", {
            dayNumber: number,
            dealType: 'BALANCE_RECHARGE'
        }, null, null).ajaxOK(function (rv) {
            if (rv.data.length > 0) {
                for (var i = 0; i < rv.data.length; i++) {
                    xAxis.push(rv.data[i].dateTimes);
                    series.push(rv.data[i].countNumber + '');
                }
            } else {
                xAxis.push(this_day);
                series.push('0')
            }
            Addbalance.hideLoading();
            Addbalance.setOption(option);
        })
    }

    //获取余额退款
    function getBalanceTk(number) {
        var series = [];
        var xAxis = [];
        var balance = echarts.init(document.getElementById('balance'));
        balance.showLoading();
        var option = {
            tooltip: {
                trigger: 'axis',
                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            legend: {
                data: []
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            xAxis: [
                {
                    type: 'category',
                    data: xAxis
                }
            ],
            yAxis: [
                {
                    type: 'value'
                }
            ],
            series: [
                {
                    name: '余额退款',
                    type: 'bar',
                    data: series
                }
            ]
        };

        Project.ajax("/admin/user/capital/find/balance/or/bond", {
            dayNumber: number,
            payType: 'BALANCE'
        }, null, null).ajaxOK(function (rv) {
            if (rv.data.length > 0) {
                for (var i = 0; i < rv.data.length; i++) {
                    xAxis.push(rv.data[i].dateTimes);
                    series.push(rv.data[i].countNumber + '');
                }
            } else {
                xAxis.push(this_day);
                series.push('0')
            }
            balance.hideLoading();
            balance.setOption(option);
        })
    }

    //获取押金充值
    function getBondAdd(number) {
        var series = [];
        var xAxis = [];
        var Addbond = echarts.init(document.getElementById('Addbond'));
        Addbond.showLoading();
        var option = {
            tooltip: {
                trigger: 'axis',
                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            legend: {
                data: []
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            xAxis: [
                {
                    type: 'category',
                    data: xAxis
                }
            ],
            yAxis: [
                {
                    type: 'value'
                }
            ],
            series: [
                {
                    name: '押金充值',
                    type: 'bar',
                    data: series
                }
            ]
        };

        Project.ajax("/admin/user/capital/find/balance/or/bond/add", {
            dayNumber: number,
            dealType: 'BOND_RECHARGE'
        }, null, null).ajaxOK(function (rv) {
            if (rv.data.length > 0) {
                for (var i = 0; i < rv.data.length; i++) {
                    xAxis.push(rv.data[i].dateTimes);
                    series.push(rv.data[i].countNumber + '');
                }
            } else {
                xAxis.push(this_day);
                series.push('0')
            }
            Addbond.hideLoading();
            Addbond.setOption(option);
        })
    }

    //获取押金退款
    function getBondTk(number) {
        var series = [];
        var xAxis = [];
        var bond = echarts.init(document.getElementById('bond'));
        bond.showLoading();
        var option = {
            tooltip: {
                trigger: 'axis',
                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            legend: {
                data: []
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            xAxis: [
                {
                    type: 'category',
                    data: xAxis
                }
            ],
            yAxis: [
                {
                    type: 'value'
                }
            ],
            series: [
                {
                    name: '押金退款',
                    type: 'bar',
                    data: series
                }
            ]
        };

        Project.ajax("/admin/user/capital/find/balance/or/bond", {
            dayNumber: number,
            payType: 'BOND'
        }, null, null).ajaxOK(function (rv) {
            if (rv.data.length > 0) {
                for (var i = 0; i < rv.data.length; i++) {
                    xAxis.push(rv.data[i].dateTimes);
                    series.push(rv.data[i].countNumber + '');
                }
            } else {
                xAxis.push(this_day);
                series.push('0')
            }
            bond.hideLoading();
            bond.setOption(option);
        })
    }

    $('#AddMemberSumSelect').change(function () {
        var number = $(this).val();
        if (number > 2) {
            $('#AddMemberSumYear').val('');
            $('#AddMemberSumMonth').val('');
            $('#AddMemberSumYear').attr('disabled', true);
            $('#AddMemberSumMonth').attr('disabled', true);
        } else if (number == 2) {
            $('#AddMemberSumMonth').val('');
            $('#AddMemberSumMonth').attr('disabled', true);
            $('#AddMemberSumYear').attr('disabled', false);
        } else {
            $('#AddMemberSumMonth').attr('disabled', false);
            $('#AddMemberSumYear').attr('disabled', false);
        }
    });

    //获取新增会员数
    function getAddMember() {
        var data = {
            dayNumber: $('#AddMemberSumSelect').val(),
            yearNumber: $('#AddMemberSumYear').val(),
            monthNumber: $('#AddMemberSumMonth').val(),
        }
        var series = [];
        var xAxis = [];
        var AddMember = echarts.init(document.getElementById('AddMember'));
        AddMember.showLoading();
        var option = {
            tooltip: {
                trigger: 'axis',
                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            legend: {
                data: []
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            xAxis: [
                {
                    type: 'category',
                    data: xAxis
                }
            ],
            yAxis: [
                {
                    type: 'value'
                }
            ],
            series: [
                {
                    name: '新增会员',
                    type: 'bar',
                    data: series
                }
            ]
        };

        Project.ajax("/admin/user/capital/find/user/number", data, null, null).ajaxOK(function (rv) {
            if (rv.data.length > 0) {
                for (var i = 0; i < rv.data.length; i++) {
                    xAxis.push(rv.data[i].dateTimes);
                    series.push(rv.data[i].countNumber + '');
                }
            } else {
                xAxis.push(this_day);
                series.push('0')
            }
            AddMember.hideLoading();
            AddMember.setOption(option);
        })
    }

    //获取会员退押金数量
    function getMemberReturnBond() {
        var series = [];
        var series1 = [];
        var xAxis = [];
        var MemberBond = echarts.init(document.getElementById('MemberBond'));
        MemberBond.showLoading();
        var option = {
            tooltip: {
                trigger: 'axis',
                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            legend: {
                data: []
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            xAxis: [
                {
                    type: 'category',
                    data: xAxis
                }
            ],
            yAxis: [
                {
                    type: 'value'
                }
            ],
            series: [
                {
                    name: '会员押金退款金额',
                    type: 'bar',
                    data: series
                },
                {
                    name: '会员押金退款人数',
                    type: 'bar',
                    data: series1
                }
            ]
        };

        Project.ajax("/admin/user/capital/find/user/reduce/number", null, null, null).ajaxOK(function (rv) {
            if (rv.data.length > 0) {
                for (var i = 0; i < rv.data.length; i++) {
                    xAxis.push(rv.data[i].days);
                    series.push(rv.data[i].money + '');
                    series1.push(rv.data[i].countNumber + '');
                }
            } else {
                xAxis.push(this_day);
                series.push('0')
            }
            MemberBond.hideLoading();
            MemberBond.setOption(option);
        })
    }

    $('#AddMemberSelect').change(function () {
        var number = $(this).val();
        if (number > 2) {
            $('#AddMemberYear').val('');
            $('#AddMemberMonth').val('');
            $('#AddMemberYear').attr('disabled', true);
            $('#AddMemberMonth').attr('disabled', true);
        } else if (number == 2) {
            $('#AddMemberMonth').val('');
            $('#AddMemberMonth').attr('disabled', true);
            $('#AddMemberYear').attr('disabled', false);
        } else {
            $('#AddMemberMonth').attr('disabled', false);
            $('#AddMemberYear').attr('disabled', false);
        }
    });

    //获取会员充值押金数量
    function getAddMemberBond() {
        var data = {
            dayNumber: $('#AddMemberSelect').val(),
            yearNumber: $('#AddMemberYear').val(),
            monthNumber: $('#AddMemberMonth').val(),
        };
        var series = [];
        var series1 = [];
        var xAxis = [];
        var AddMemberBond = echarts.init(document.getElementById('AddMemberBond'));
        AddMemberBond.showLoading();
        var option = {
            tooltip: {
                trigger: 'axis',
                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            legend: {
                data: []
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            xAxis: [
                {
                    type: 'category',
                    data: xAxis
                }
            ],
            yAxis: [
                {
                    type: 'value'
                }
            ],
            series: [
                {
                    name: '会员充值押金总额',
                    type: 'bar',
                    data: series
                },
                {
                    name: '会员充值押金人数',
                    type: 'bar',
                    data: series1
                }
            ]
        };

        Project.ajax("/admin/user/capital/find/bond/number", data, null, null).ajaxOK(function (rv) {
            if (rv.data.length > 0) {
                for (var i = 0; i < rv.data.length; i++) {
                    xAxis.push(rv.data[i].days);
                    series.push(rv.data[i].money + '');
                    series1.push(rv.data[i].countNumber + '');
                }
            } else {
                xAxis.push(this_day);
                series.push('0')
            }
            AddMemberBond.hideLoading();
            AddMemberBond.setOption(option);
        })
    }
    $('#IncomeSelect').change(function () {
        var number = $(this).val();
        if (number > 2) {
            $('#IncomeYear').val('');
            $('#IncomeMonth').val('');
            $('#IncomeYear').attr('disabled', true);
            $('#IncomeMonth').attr('disabled', true);
        } else if (number == 2) {
            $('#IncomeMonth').val('');
            $('#IncomeMonth').attr('disabled', true);
            $('#IncomeYear').attr('disabled', false);
        } else {
            $('#IncomeMonth').attr('disabled', false);
            $('#IncomeYear').attr('disabled', false);
        }
    });
    //运营收入
    function getIncome() {
        var zs = $('#IncomeBooleanSelect').val();
        var data = {
            dayNumber: $('#IncomeSelect').val(),
            yearNumber: $('#IncomeYear').val(),
            monthNumber: $('#IncomeMonth').val(),
            zs: $('#IncomeBooleanSelect').val()
        };
        console.log(data);

        var series = [];
        var series1 = [];
        var xAxis = [];
        var Income = echarts.init(document.getElementById('Income'));
        Income.showLoading();
        var option = {
            tooltip: {
                trigger: 'axis',
                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            legend: {
                data: []
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            xAxis: [
                {
                    type: 'category',
                    data: xAxis
                }
            ],
            yAxis: [
                {
                    type: 'value'
                }
            ],
            series: [
                {
                    name: '运营收入总金额',
                    type: 'bar',
                    data: series
                }
            ]
        };

        Project.ajax("/admin/user/capital/find/income/number", data, null, null).ajaxOK(function (rv) {
            if (rv.data.length > 0) {
                for (var i = 0; i < rv.data.length; i++) {
                    xAxis.push(rv.data[i].days);
                    series.push(rv.data[i].money + '');
                }
            } else {
                xAxis.push(this_day);
                series.push('0')
            }
            Income.hideLoading();
            Income.setOption(option);
        })
    }


    /*
    * star
    * */

    window.onload = function () {
        getCarStatus();
        getMemberStatus();
        getBalanceTk(1);
        getBalanceAdd(1);
        getBondTk(1);
        getBondAdd(1);
        getAddBranch(1);
        getAddCar(1);
        getCarNumber(1);
        getUseCar(1);
        getAddMember(1);
        getMemberReturnBond();
        getAddMemberBond(1);
    }
</script>
</@frame.businessV2>