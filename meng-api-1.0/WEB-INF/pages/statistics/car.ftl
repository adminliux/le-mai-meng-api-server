<@frame.businessV2 title="${title}">
    <#include "public/var.ftl">
<script src="${path}/resources/js/jq.resizableColumns.js"></script>
<script src="${path}/resources/js/echarts.js"></script>
<style>

    /*.table.dataTable thead .sorting_desc:after{*/
    /*float: none;*/
    /*}*/
    /*.table.dataTable thead .sorting:after{*/
    /*float: none;*/
    /*}*/

    .top-wrapper {
        display: flex;
        margin: 10px 0px;
    }

    .top-wrapper .custom-wrapper {
        flex: 0 0 80px;
        display: none;
    }

    .top-wrapper .custom-wrapper .custom {
        display: inline-block;
        border: 1px solid gainsboro;
        color: #777;
        height: 30px;
        line-height: 30px;
        padding: 0px 5px;
        border-radius: 4px;
    }

    .top-wrapper .query-wrapper .custom:hover {
        background-color: #eee;
        border-color: #ddd;
    }

    .top-wrapper .conditions-wrapper {
        flex: 1;
    }

    .top-wrapper .query-wrapper {
        flex: 0 0 60px;
    }

    .top-wrapper .down-wrapper {
        flex: 0 0 60px;
    }

    .top-wrapper .down-wrapper .down {
        display: inline-block;
        background: #d08538;
        color: white;
        height: 30px;
        line-height: 30px;
        padding: 0px 15px;
        border-radius: 4px;
    }

    .top-wrapper .conditions-wrapper input {
        height: 30px;
        padding: 6px 10px;
        background-color: #fff;
        background-image: none;
        border: 1px solid #cfdadd;
        color: #777;
        margin-bottom: 5px;
    }

    .top-wrapper .query-wrapper .query {
        display: inline-block;
        background: #23b7e5;
        color: white;
        height: 30px;
        line-height: 30px;
        padding: 0px 15px;
        border-radius: 4px;
    }

    /*.top-wrapper .query-wrapper .query:hover {*/
    /*background-color: #eee;*/
    /*border-color: #ddd;*/
    /*}*/

    .filter-wrapper {
        display: none;
    }

    .base-wrapper {
        font-size: 14px;
        overflow: hidden;
    }

    .base-wrapper .term {
        display: inline-block;
    }

    .base-wrapper .strip {
        display: inline-block;
    }

    .base-wrapper .page {
        display: inline-block;
    }

    .base-wrapper .paging {
        display: inline-block;
        float: right;
    }

    .base-wrapper .term span {
        display: inline-block;
        margin: 0px 4px;
    }

    .base-wrapper .strip select {
        display: inline-block;
        margin: 0 5px;
    }

    .base-wrapper .page input {
        width: 80px;
        border: 1px solid darkgray;
        border-radius: 2px;
        margin: 0px 2px;
        text-align: center;
    }

    .base-wrapper .page a {
        border: 1px solid gainsboro;
        height: 30px;
        width: 60px;
        color: #777;
        /* float: left; */
        line-height: 30px;
        text-align: center;
        border-radius: 4px;
        margin: 0 5px;
        display: inline-block;
    }

    .base-wrapper .paging .prev {
        display: inline-block;
        border: 1px solid gainsboro;
        padding: 4px 10px;
        color: #777;
        /*cursor: not-allowed;*/
        background-color: #fff;
        margin-left: 0;
        border-top-left-radius: 4px;
        border-bottom-left-radius: 4px;
    }

    .base-wrapper .paging .prev:hover {
        color: #23527c;
        background-color: #eee;
        border-color: #ddd;
    }

    .base-wrapper .paging .first:hover {
        color: #777;
        background-color: white;

    }

    .base-wrapper .paging .next {
        display: inline-block;
        border: 1px solid gainsboro;
        padding: 4px 10px;
        color: #777;
        /*cursor: not-allowed;*/
        background-color: #fff;
        border-top-right-radius: 4px;
        border-bottom-right-radius: 4px;
    }

    .base-wrapper .paging .next:hover {
        color: #23527c;
        background-color: #eee;
        border-color: #ddd;
    }

    .base-wrapper .paging .first:hover {
        color: #777;
        background-color: white;

    }

    .base-wrapper .paging .num {
        padding: 5px 10px;
        text-decoration: none;
        background-color: #FFFFFF;
        border: 1px solid #DDDDDD;
        color: inherit;
    }

    .base-wrapper .paging .num.active {
        background-color: #f4f4f4;

    }

    .clearfix {
        display: inline-block;
    }

    .clearfix:after {

    }

    .popup {
        display: none;
        position: fixed;
        top: 0px;
        left: 0px;
        right: 0px;
        bottom: 0px;
        overflow: auto;
        z-index: -1;
        background: rgba(7, 17, 27, 0.8);
    }

    .popup-wrapper {
        width: 100%;
    }

    .popup-main {
        position: absolute;
        top: 35px;
        left: 10px;
        right: 10px;
        bottom: 0px;
    }

    .popup-close {
        position: absolute;
        width: 21px;
        height: 21px;
        clear: both;
        font-size: 24px;
        right: 15px;
        top: 2px;
        color: white;
        text-align: center;
        cursor: pointer;
    }

    .popup-close img {
        width: 100%;
    }

    .popup-main > .name {
        font-size: 20px;
        line-height: 20px;
        text-align: center;
        font-weight: 700;
        color: white;
    }

    .title {
        display: flex;
        width: 90%;
        margin: 28px auto 24px auto;
    }

    .title .line {
        flex: 1;
        position: relative;
        top: -6px;
        border-bottom: 1px solid rgba(255, 255, 255, 0.4);
    }

    .title .text {
        padding: 0px 12px;
        font-weight: 700;
        font-size: 16px;
        line-height: 16px;
        color: white;
        cursor: pointer;
    }

    /*个人信息*/
    .people {
        width: 90%;
        margin: 0 auto;
        display: flex;
        justify-content: center;

    }

    .people .head {
        flex: 0 0 128px;
    }

    .people .info {
        flex: 1;
        list-style: none;
    }

    .people .info .info-item {
        margin: 12px 0px 12px 10px;
    }

    .people .info .info-item:last-child {
        margin-bottom: 0px;
    }

    .people .info .info-item .name {
        color: #8ed2c4;
        font-weight: 700;
    }

    .people .info .info-item .text {
        color: white;
        font-size: 14px;
    }

    /*订单信息*/
    .order {
        width: 90%;
        margin: 0 auto;
        display: flex;
    }

    .order .order-list {
        flex: 1;
        list-style: none;
    }

    .order .order-list .order-item {
        margin: 12px 0px 12px 10px;
    }

    .order .order-list .order-item .name {
        color: #8ed2c4;
        font-weight: 700;
    }

    .order .order-list .order-item .text {
        color: white;
        font-size: 14px;
    }

    /*银行卡信息*/
    .bank {
        width: 90%;
        margin: 0 auto;
        display: flex;
    }

    .bank .bank-list {
        flex: 1;
    }

    .bank .bank-list .bank-item {
        margin: 10px 0px;
    }

    .bank .bank-list .bank-item .name {
        color: #8ed2c4;
        font-weight: 700;
    }

    .bank .bank-list .bank-item .text {
        color: white;
        font-size: 14px;
    }

    /*认证*/
    .auth {
        width: 90%;
        margin: 0 auto;
        justify-content: center;
    }

    .auth .info {
        text-align: center;
        font-size: 20px;
    }

    .auth .info .name {
        color: #8ed2c4;
        font-weight: 700;
    }

    .auth .info .text {
        color: white;
    }

    .auth-list {
        display: flex;
    }

    .auth-list .auth-item {
        flex: 1;
        color: white;
        text-align: center;
    }

    .auth-list .auth-item .name {
        color: white;
        margin-bottom: 5px;
    }

    .auth-list .auth-item img {
        max-width: 80%;
        min-width: 150px;
        margin: 5px;
    }

    @media (max-width: 625px) {
        .bank {
            display: block;
        }

        .bank-list {
            width: 300px !important;
            margin: 0 auto;
            border-bottom: 1px solid white;
        }

        .bank-list:last-child {
            border-bottom: 0px;
        }

        .order {
            display: block;
            width: 300px;
        }

        .auth-list {
            display: block;
        }

        .people {
            display: block;
            width: 300px;
            margin: 0 auto;
        }

        .people .head {
            text-align: center;
        }
    }

    .bankShow {
        display: none;
    }

    .orderShow {
        display: none;
    }

    .hideThis {
        display: none;
    }

    .popup-wrapper .chats-wrapper {
        position: absolute;
        top: 40px;
        left: 0px;
        right: 0px;
        bottom: 0px;
        width: 100%;
        overflow: hidden;
        overflow-y: auto;
    }

    .popup-wrapper .chats-wrapper .nav {
        width: 95%;
        margin: 0 auto;
        padding-top: 10px;
        display: flex;
    }

    .popup-wrapper .chats-wrapper .nav > a {
        border: 1px solid gainsboro;
        height: 40px;
        line-height: 40px;
        color: #777;
        background-color: #fff;
        margin: 0px;
        flex: 1;
        text-align: center;
    }

    .popup-wrapper .chats-wrapper .chats-item {
        border: 1px solid #eeeeee;
        background: #fff;
        width: 95%;
        min-width: 300px;
        margin: 0 auto;
        box-shadow: 0 1px 1px rgba(0, 0, 0, .05);
        margin-bottom: 10px;
    }

    .popup-wrapper .chats-wrapper .chats-item h2 {
        border-bottom: 1px solid #edf1f2;
        background-color: #f6f8f8;
        height: 40px;
        line-height: 40px;
        padding-left: 10px;
        margin-top: 0px;
    }

    .popup-wrapper .chats-wrapper .chats-item .chats-buttons {
        border-bottom: 1px solid #edf1f2;
        height: 40px;
        width: 100%;

    }

    .popup-wrapper .chats-wrapper .chats-item .chats-buttons a {
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

    .popup-wrapper .chats-wrapper .chats-item .content {
    }

    .popup-wrapper .chats-wrapper .chats-item .content > div {
        width: 80%;
        height: 400px;
        margin: 0 auto;
    }

</style>
<div class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>订单流水
                            <small>余额收入</small>
                        </h5>
                    </div>
                    <div class="ibox-content">
                        <div class="top-wrapper">
                            <div class="custom-wrapper">
                                <a class="custom" href="javascript:void(0);">自定义显示</a>
                            </div>
                            <div class="down-wrapper">

                            </div>
                            <div class="query-wrapper">

                            </div>

                        </div>
                        <div class="filter-wrapper">

                        </div>
                        <table class="table table-striped table-bordered table-hover dataTables-example" id="dragTable">
                            <thead>
                            <tr>
                                <th>车牌</th>
                                <th>车型</th>
                                <th>金额</th>
                                <th>图表</th>
                            </tr>
                            </thead>
                            <tbody id="goodList">

                            </tbody>
                            <script type="text/html" id="f1">
                                {{each data.list as list}}
                                <tr>
                                    <td class="center">{{list.carRelease.licensePlateNumber}}</td>
                                    <td class="center">{{list.carRelease.name}}</td>
                                    <td>{{list.priceSum}}</td>
                                    <td><a onClick="ShowPopup({{list.carId}},'{{list.carRelease.licensePlateNumber}}')">点击查看</a>
                                    </td>
                                </tr>
                                {{/each}}
                            </script>


                        </table>
                        <div class="base-wrapper" id="page">

                        </div>
                        <script type="text/html" id="f2">
                            <div class="term">共{{data.pages}}页，</div>
                            <div class="strip">每页
                                <select name="pageSize" onchange="findList()">
                                    {{if data.pageSize==10}}
                                    <option value="10" selected>10</option>
                                    <option value="20">20</option>
                                    <option value="50">50</option>
                                    <option value="100">100</option>
                                    {{else if data.pageSize==20}}
                                    <option value="10">10</option>
                                    <option value="20" selected>20</option>
                                    <option value="50">50</option>
                                    <option value="100">100</option>
                                    {{else if data.pageSize==50}}
                                    <option value="10">10</option>
                                    <option value="20">20</option>
                                    <option value="50" selected>50</option>
                                    <option value="100">100</option>
                                    {{else if data.pageSize==100}}
                                    <option value="10">10</option>
                                    <option value="20">20</option>
                                    <option value="50">50</option>
                                    <option value="100" selected>100</option>
                                    {{else}}
                                    {{/if}}
                                </select>行
                            </div>
                            <div class="page">到<input type="text" name="newPageNumber"
                                                      onkeyup="this.value=this.value.replace(/\D/g,'')">页
                                <a class="page-go" onclick="findPage()">跳转</a>
                            </div>
                            <div class="paging">
                                <!-- 分页 -->
                                {{if data.prePage==0}}
                                <a class="prev first">上一页</a>
                                {{else}}
                                <a class="prev" href="javascript:void(0)" onclick="findList({{data.prePage}})">上一页</a>
                                {{/if}}
                                {{each data.navigatepageNums as n}}
                                {{if data.pageNum==n}}
                                <a class="num active" href="javascript:void(0)" onclick="findList({{n}})">{{n}}</a>
                                {{else}}
                                <a class="num" href="javascript:void(0)" onclick="findList({{n}})">{{n}}</a>
                                {{/if}}
                            <#--<a class="num">2</a>-->
                                {{/each}}
                                {{if data.nextPage==0}}
                                <a class="next first">下一页</a>
                                {{else}}
                                <a class="next" href="javascript:void(0)" onclick="findList({{data.nextPage}})">下一页</a>
                                {{/if}}
                            </div>
                        </script>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
  <div class="popup">
      <div class="popup-wrapper clearfix">
          <div class="popup-close">
              <img src="${path}/resources/img/detail/close.png" width="64">
          </div>
          <div class="popup-main">
              <div class="chats-wrapper">
                  <div class="chats-item">
                      <h2 id="carTitle">车辆收入</h2>
                      <div class="chats-buttons">
                          <a onclick="initPopup(1)">天</a>
                          <a onclick="initPopup(2)">周</a>
                          <a onclick="initPopup(3)">月</a>
                          <a onclick="initPopup(4)">年</a>
                      </div>
                      <div class="content">
                          <div id="car" style="height: 600px;min-width: 300px"></div>
                      </div>
                  </div>
              </div>

          </div>
      </div>
  </div>
    <!-- Page-Level Scripts -->
    <script>
        var now = new Date();
        var this_day = now.getFullYear() + '-' + (now.getMonth() + 1) + '-' + now.getDate();
        var NowcarId = '';
        var NowName = '车辆收入';

        function fnClickAddRow() {
            $('#editable').dataTable().fnAddData([
                "Custom row",
                "New row",
                "New row",
                "New row",
                "New row"]);

        }

        function isNullOrUndefined(obj) {
            if (typeof(obj) == "undefined" || obj == null) {
                return true;
            }
            return false;
        }

        function registerTableDragEvent() {

            var dragTH; //记录拖拽的列
            //第一步按下
            $('#dragTable th').mousedown(function (e) {
                e = e || window.event;
                if (e.offsetX > $(this).innerWidth() - 10) {
                    dragTH = $(this);
                    dragTH.mouseDown = true;
                    dragTH.oldX = e.pageX || e.clientX;
                    dragTH.oldWidth = $(this).innerWidth();
                }
            })
            //第二步 拖动
            $('#dragTable th').mousemove(function (e) {
                //改鼠标样式
                if (e.offsetX > $(this).innerWidth() - 10) {
                    $(this).css({
                        cursor: "e-resize"
                    });
                } else {
                    $(this).css({
                        cursor: "default"
                    });
                }
                if (isNullOrUndefined(dragTH)) {
                    dragTH = $(this);
                }
                if (!isNullOrUndefined(dragTH.mouseDown) && dragTH.mouseDown == true) {
                    var difference = (e.pageX - dragTH.oldX) || (e.clientX - dragTH.oldX);
                    var newWidth = dragTH.oldWidth + difference; //新的宽度
                    dragTH.width(newWidth)
                }
            })
            // 第三步，释放
            $("table#dragTable th").mouseup(function (e) {
                // 还原鼠标样式
                // if (isNullOrUndefined(dragTH)) {
                //     dragTH = $(this);
                // }
                dragTH.mouseDown = false;
                // $(dragTH).css({
                //     cursor : "default"
                // });
            });
        }

        function readyBody() {
            // registerTableDragEvent();
//    关闭弹窗
            $('.popup-close').click(function () {
                $('.popup').css('z-index', -1);
                $('.popup').hide();
            })

        }

        $('.people-honk').click(function () {
            $('.people').slideToggle();
        })
        $('.bank-honk').click(function () {
            $('.bank').slideToggle();
        })
        $('.auth-honk').click(function () {
            $('.auth').slideToggle();
        });

        $('.order-honk').click(function () {
            $('.order').slideToggle();
        });

        function initPopup(number) {
            var series = [];
            var xAxis = [];
            var car = echarts.init(document.getElementById('car'));
            car.showLoading();
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
                        name: NowName,
                        type: 'bar',
                        data: series
                    }
                ]
            };

            Project.ajax("/admin/user/capital/find/car/sts", {
                dayNumber: number,
                carId: NowcarId
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
                car.hideLoading();
                car.setOption(option);
            })
        }

        function ShowPopup(carId, name) {
            $('#carTitle').text(name);
            NowcarId = carId;
            $('.popup').show();
            initPopup(1);
            $('.popup').css('z-index', 100);
        }


        //年月日时间
        function fmtDateM(dt) {
            dt = new Date(dt);
            var mm = dt.getMonth() + 1;//月
            var dd = dt.getDate();//日
            var hh = dt.getHours();//小时
            var ms = dt.getMinutes();//分钟
            return dt.getFullYear()
                    + ((mm < 10) ? ('-0' + mm) : ('-' + mm))
                    + ((dd < 10) ? ('-0' + dd) : ('-' + dd))
                    + ((hh < 10) ? (' 0' + hh) : (' ' + hh))
                    + ((ms < 10) ? (':0' + ms) : (':' + ms));
        }

        var pages;
        findList();
        var items = [];

        function findList(pageNum) {
            var pageSize = $("select[name=pageSize]").val();
//
            var p = $.extend({pageNum: pageNum}, {pageSize: pageSize});
            Project.ajax("/admin/user/capital/find/car/sts/sum", p, null, null).ajaxOK(function (data) {
                $("#goodList").html(template("f1", data));//作用到表格
                $("#page").html(template("f2", data));//作用到分页
                readyBody();
            });
        }

        function findPage() {
            var newPageNumber = $("input[name=newPageNumber]").val();
            if (newPageNumber <= 0 || newPageNumber > pages) {
                alert("请输入正确页数");
                return false;
            }
            findList(newPageNumber);
        }


    </script>
</@frame.businessV2>