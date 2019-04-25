<@frame.businessV2 title="${title}">
    <#include "public/var.ftl">
<script src="${path}/resources/js/jq.resizableColumns.js"></script>
<style>

    /*.table.dataTable thead .sorting_desc:after{*/
    /*float: none;*/
    /*}*/
    /*.table.dataTable thead .sorting:after{*/
    /*float: none;*/
    /*}*/
    .SeletDeal {
        height: 30px;
        padding: 0px 10px;
        background-color: #fff;
        background-image: none;
        border: 1px solid #cfdadd;
        color: #777;
        margin-bottom: 5px;
        vertical-align: top;
    }

    .jsort {
        display: inline-block;
        width: 20px;
        height: 20px;
        position: relative;
        top: 5px;
        background: url(${path}/resources/img/jsort/jsort-order.png);
    }

    .jsort.asc {
        background-image: url(${path}/resources/img/jsort/jsort-asc.png);
    }

    .jsort.desc {
        background-image: url(${path}/resources/img/jsort/jsort-desc.png);
    }

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
        height: 100%;
        width: 100%;
        overflow: auto;
        z-index: 100;
        background: rgba(7, 17, 27, 0.8);
    }

    .popup-wrapper {
        min-height: 100%;
        width: 100%;
    }

    .popup-main {
        margin-top: 40px;
    }

    .popup-close {
        position: absolute;
        width: 24px;
        height: 24px;
        clear: both;
        font-size: 24px;
        right: 15px;
        top: 15px;
        color: white;
        text-align: center;
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
                            <form id="From" class="conditions-wrapper">
                                <div>
                                    <select name="dealType" class="SeletDeal">
                                        <option value="SHARE_CAR_INCOME">共享车收益</option>
                                        <option value="SYSTEM_GIVE">系统赠送</option>
                                        <option value="SYSTEM_DEDUCTION">系统扣除</option>
                                        <option value="CAR_RENTAL">租车</option>
                                        <option value="INTEGRAL_CONSUME">积分消费</option>
                                        <option value="INTEGRAL_GIVE">积分赠送</option>
                                        <option value="BALANCE_RECHARGE">余额充值</option>
                                        <option value="BOND_RECHARGE">保证金充值</option>
                                        <option value="BALANCE_RETURN">余额返还</option>
                                        <option value="BOND_RETURN">保证金返还</option>
                                        <option value="INTEGRAL_RECHARGE">积分充值</option>
                                        <option value="CASH_COUPON_RECHARGE">现金卷充值</option>
                                        <option value="WITHDRAWALS_BANK">提现至银行卡</option>
                                        <option value="CAR_ORDER_REFUND">租车订单退款</option>
                                        <option value="SERVICE_CHARGE">手续费</option>
                                    </select>

                                    <select name="payType" class="SeletDeal">
                                        <option value="">全部类型</option>
                                        <option value="ALI_PAY">支付宝</option>
                                        <option value="WX_PAY">微信</option>
                                        <option value="BALANCE">余额</option>
                                        <option value="BOND">保证金</option>
                                        <option value="INTEGRAL">积分</option>
                                        <option value="CASH_COUPON">现金卷</option>
                                        <option value="ENTITY_CASH_COUPON">实体现金卷</option>
                                        <option value="BANK">银行卡</option>
                                    </select>

                                    <select name="status" class="SeletDeal">
                                        <option value="">全部状态</option>
                                        <option value="CANCEL">已取消</option>
                                        <option value="COMPLETE">已完成</option>
                                        <option value="WAIT_PAY">待支付</option>
                                    </select>

                                    <input type="text" name="phoneNumber" placeholder="手机号">
                                    <input type="text" name="officialPartnerOrder" placeholder="第三方订单号">
                                    <input type="text" class="Wdate"
                                           onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" name="beginTime"
                                           placeholder="开始时间"/>
                                    -
                                    <input type="text" class="Wdate"
                                           onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" name="endTime"
                                           placeholder="结束时间"/>

                                    <input type="text" class="Wdate"
                                           onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" name="beginTimeUpdate"
                                           placeholder="修改开始时间"/>
                                    -
                                    <input type="text" class="Wdate"
                                           onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" name="endTimeUpdate"
                                           placeholder="修改结束时间"/>
                                </div>
                            </form>
                            <div class="down-wrapper">
                                <a class="down" onclick="findcCc()">下载</a>
                            </div>
                            <div class="query-wrapper">
                                <a class="query" onclick="findList()">查询</a>
                            </div>

                        </div>
                        <div class="filter-wrapper">
                            <ul class="filter-list">
                                <li class="filter-item">
                                    <input type="checkbox" class="check"><span class="text">姓名</span>
                                </li>
                            </ul>
                        </div>
                        <table class="table table-striped table-bordered table-hover dataTables-example" id="dragTable">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>手机号码</th>
                            <#--<th>交易类型</th>-->
                                <th>支付类型</th>
                                <th>金额</th>
                                <th>状态</th>
                                <th>第三方支付订单号</th>
                                <th>时间</th>
                            </tr>
                            </thead>
                            <tbody id="goodList">

                            </tbody>
                            <script type="text/html" id="f1">
                                {{each data.list as list}}
                                <tr>
                                    <td class="center">{{list.userCapitalRecord.id}}</td>
                                    <td><a id="{{list.userCapitalRecord.id}}" class="popupShow">{{list.user.phoneNumber}}{{if list.userAuth!=null}}({{list.userAuth.name}}){{/if}}</a>
                                    </td>

                                    <td>
                                        {{if list.userCapitalRecord.payType=="ALI_PAY"}}支付宝
                                        {{else if list.userCapitalRecord.payType=="WX_PAY"}}微信
                                        {{else if list.userCapitalRecord.payType=="BALANCE"}}余额
                                        {{else if list.userCapitalRecord.payType=="BOND"}}保证金
                                        {{else if list.userCapitalRecord.payType=="INTEGRAL"}}积分
                                        {{else if list.userCapitalRecord.payType=="CASH_COUPON"}}现金卷
                                        {{else if list.userCapitalRecord.payType=="ENTITY_CASH_COUPON"}}实体现金卷
                                        {{else if list.userCapitalRecord.payType=="BANK"}}银行卡
                                        {{else}}{{/if}}
                                    </td>
                                    <td class="center">{{list.userCapitalRecord.amount}}</td>
                                    <td class="center">
                                        {{if list.userCapitalRecord.status=="CANCEL"}}
                                        <span style="color: #e2d2d2">已取消</span>
                                        {{else if list.userCapitalRecord.status=="COMPLETE"}}
                                        <span style=" color:#867c6b;">已完成</span>
                                        {{else if list.userCapitalRecord.status=="WAIT_PAY"}}
                                        {{if list.userCapitalRecord.dealType=="WITHDRAWALS_BANK"}}
                                        <select onchange="updateType({{list.userCapitalRecord.id}},this.value)">
                                            <option value="WAIT_PAY" selected>待支付</option>
                                            <option value="COMPLETE">已完成</option>
                                        </select>
                                        {{else}}
                                        待支付
                                        {{/if}}
                                        {{else}}
                                        {{/if}}
                                    </td>
                                    <td class="center">{{list.userCapitalRecord.officialPartnerOrder}}</td>
                                    <td class="center">{{$timestampFormatYMDHM list.userCapitalRecord.gmtDatetime}}</td>
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
    <div class="popup">
        <div class="popup-wrapper clearfix">
            <div class="popup-close">
                <img src="${path}/resources/img/detail/close.png" width="64">
            </div>
            <div class="popup-main">
                <h2 class="name">详情信息</h2>
                <div class="title">
                    <div class="line"></div>
                    <div class="text people-honk">个人信息
                    </div>
                    <div class="line"></div>
                </div>
                <div class="people">
                    <div class="head">
                        <img src="" width="128" height="128">
                    </div>
                <#--固定-->
                    <ul class="info">
                        <li class="info-item"><span class="name">姓名：</span><span class="text fullName">陈xx</span></li>
                        <li class="info-item"><span class="name">手机：</span><span class="text phone">18858745620</span>
                        </li>
                        <li class="info-item"><span class="name">性别：</span><span class="text sex">男</span></li>
                        <li class="info-item"><span class="name">身份证：</span><span
                                class="text sfz">330327100501238821</span>
                        </li>
                    </ul>
                    <ul class="info">
                        <li class="info-item"><span class="name">余额：</span><span class="text balance">111</span></li>
                        <li class="info-item"><span class="name">押金：</span><span class="text bond">11111</span></li>
                        <li class="info-item"><span class="name">积分：</span><span class="text integral">123123</span>
                        </li>
                        <li class="info-item"><span class="name">现金卷：</span><span class="text cash">1111</span></li>
                    </ul>
                </div>
                <div class="orderShow">
                    <div class="title">
                        <div class="line"></div>
                        <div class="text order-honk">订单信息</div>
                        <div class="line"></div>
                    </div>
                    <div class="order">
                        <ul class="order-list">
                            <li class="order-item"><span class="name">订单号：</span><span class="text orderId">111</span>
                            </li>
                            <li class="order-item"><span class="name">状态：</span><span class="text status">111</span>
                            </li>
                            <li class="order-item"><span class="name">订单开始时间：</span><span
                                    class="text gmtDatetime">111</span></li>
                            <li class="order-item"><span class="name">取车时间：</span><span
                                    class="text takeDatetime">111</span></li>
                            <li class="order-item"><span class="name">还车时间：</span><span
                                    class="text returnDatetime">111</span></li>
                            <li class="order-item"><span class="name">开出公里数：</span><span
                                    class="text kilometers">111</span></li>
                        </ul>
                        <ul class="order-list">
                            <li class="order-item"><span class="name">分钟费用：</span><span
                                    class="text minutePrice">111</span></li>
                            <li class="order-item"><span class="name">公里费用：</span><span
                                    class="text mileagePrice">111</span></li>
                            <li class="order-item"><span class="name">保险金额：</span><span
                                    class="text insurancePrice">111</span></li>
                            <li class="order-item"><span class="name">消费金额：</span><span class="text price">111</span>
                            </li>
                            <li class="order-item"><span class="name">付款金额：</span><span class="text PayPrice">111</span>
                            </li>
                            <li class="order-item"><span class="name">支付类型：</span><span
                                    class="text carPayType">111</span></li>
                        </ul>
                    </div>
                </div>
                <div class="bankShow">
                    <div class="title">
                        <div class="line"></div>
                        <div class="text bank-honk">银行卡信息</div>
                        <div class="line"></div>
                    </div>
                    <div class="bank">
                        <ul class="bank-list">
                            <li class="bank-item"><span class="name">持卡人：</span><span class="text bindname">陈xx</span>
                            </li>
                            <li class="bank-item"><span class="name">手机号：</span><span
                                    class="text bindPhone">12475788545</span></li>
                            <li class="bank-item"><span class="name">所属银行：</span><span class="text bindBank">中国银行</span>
                            </li>
                            <li class="bank-item"><span class="name">卡片类型：</span><span class="text CardType">借记卡</span>
                            </li>
                            <li class="bank-item"><span class="name">银行卡号：</span><span
                                    class="text bindNumber">01234567891234567890</span>
                            </li>
                        </ul>

                    </div>
                </div>
                <div class="title">
                    <div class="line"></div>
                    <div class="text auth-honk">认证信息
                    </div>
                    <div class="line"></div>
                </div>
                <div class="auth">
                    <div class="info"><span class="name">认证状态：</span><span class="text">未认证</span></div>
                <#--可循环-->
                    <div class="auth-list">
                        <div class="auth-item">
                            <h2 class="name">驾驶证</h2>
                            <img src="" class="jsz">
                        </div>
                        <div class="auth-item">
                            <h2 class="name">身份证正面</h2>
                            <img src="" class="sfz1">
                        </div>
                        <div class="auth-item">
                            <h2 class="name">身份证反面</h2>
                            <img src="" class="sfz2">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Page-Level Scripts -->
    <script>
        //是否数字
        //        function InputCheckNum(event) {
        //            return (/[\d]/.test(String.fromCharCode(event.keyCode)));
        //        }01
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
            $(window).resize(function() {
               if(document.body.clientWidth>=625){
                   $('.bank').removeAttr("style");
                   $('.people').removeAttr("style");
                   $('.order').removeAttr("style");
               }
            });
            registerTableDragEvent();

            $('.jsort').each(function (idx) {
                $(this).click(function () {
                    if ($(this).hasClass('asc')) {
                        $(this).removeClass('asc').addClass('desc');
                        return
                    }
                    if ($(this).hasClass('desc')) {
                        $(this).removeClass('desc').addClass('asc');
                        return
                    }
                    $(this).parent().siblings().find('.jsort').removeClass('asc').removeClass('desc')
                    $(this).addClass('asc');

                })
            })
//    关闭弹窗
            $('.popup-close').click(function () {
                $('.popup').hide()
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

        function initPopup() {
            $('.bank').removeAttr("style");
            $('.people').removeAttr("style");
            $('.order').removeAttr("style");
            $('.bankShow').hide();
            $('.auth').show();
            $('.orderShow').hide();
        }

        function ShowPopup(data) {
            console.log(data);
            initPopup();
            var user = data.user;
            var userAuth = data.userAuth;
            var bankCardUser = data.bankCardUser;
            var bank = data.bank;
            var carOrderPay = data.carOrderPay;
            var carOrder = data.carOrder;
            var gender = '';
            var status = '未审核';
            if (user.gender != null) {
                gender = user.gender == 'MALE' ? '男' : '女';
            }
            $('.phone').text(user.phoneNumber);
            $('.sex').text(gender);
            $('.cash').text(user.cashCoupon);
            $('.bond').text(user.bond);
            $('.balance').text(user.balance);
            $('.integral').text(user.integral);
            $('.head img').attr('src', user.headPortrait.url);
            /*用户认证*/
            if (userAuth != null) {
                if (userAuth.status == "AUDITED") {
                    status = '审核通过';
                } else if (userAuth.status == 'AUDIT_FAILURE') {
                    status = '审核未通过';
                } else {
                    status = '待审核'
                }
                $('.auth').find('.text').text(status);
                $('.sfz').text(userAuth.idNumber);
                $('.fullName').text(userAuth.name);
                $('.jsz').attr('src', userAuth.driverLicenseImg.url);
                $('.sfz1').attr('src', userAuth.idImgFront.url);
                $('.sfz2').attr('src', userAuth.idImgBank.url);
            }
            /*银行信息*/
            if (bankCardUser != null) {
                $('.bindname').text(bankCardUser.name);
                $('.bindPhone').text(bankCardUser.bindPhone);
                $('.bindNumber').text(bankCardUser.number);
                $('.bindBank').text(bank.name);
                $('.CardType').text(bankCardUser.cardType == 'CREDIT' ? '信用卡' : '储蓄卡');
                $('.bankShow').show();
            }
            /*订单信息*/
            if (carOrderPay != null) {
                $('.orderId').text(carOrder.id);
                $('.status').text(returnOrderStatus(carOrder.status));
                $('.gmtDatetime').text(fmtDateM(carOrder.gmtDatetime));
                $('.takeDatetime').text(fmtDateM(carOrder.takeDatetime));
                $('.returnDatetime').text(fmtDateM(carOrder.returnDatetime));
                $('.kilometers').text(carOrder.kilometers != null ? carOrder.kilometers : '0');
                $('.minutePrice').text(carOrder.minutePrice != null ? carOrder.minutePrice : '0');
                $('.mileagePrice').text(carOrder.mileagePrice != null ? carOrder.mileagePrice : '0');
                $('.price').text(carOrder.price != null ? carOrder.price : '0');
                $('.PayPrice').text(carOrder.payPrice != null ? carOrder.payPrice : '0');
                $('.insurancePrice').text(carOrder.insurancePrice != null ? carOrder.insurancePrice : '0');
                $('.carPayType').text(returnCarPayType(carOrderPay.carPayType));
                $('.orderShow').show();

            }

            $('.popup').show();
        }

        var OrderStatus = [
            {value: 'RESERVE', exp: '已预定'},
            {value: "USE", exp: '使用中'},
            {value: "COMPLETE", exp: '已完成'},
            {value: "WAIT_PAY", exp: '待支付'},
            {value: "CANCEL", exp: '已取消'},
        ];

        var CarPayType = [
            {value: 'PAY_FIRST', exp: '先付费'},
            {value: 'PAY_OVERTIME', exp: '超时付费'},
            {value: 'COMPLETE', exp: '订单结算'},
            {value: 'PAY_FIRST_REFUND', exp: '先付费退款'},
            {value: 'CANCEL_ORDER', exp: '取消订单退款'},
            {value: 'COMPENSATE', exp: '补偿金'},
            {value: 'OTHER', exp: '其他'}
        ]

        function returnOrderStatus(str) {
            for (var i = 0; i < OrderStatus.length; i++) {
                if (str == OrderStatus[i].value) {
                    return OrderStatus[i].exp;
                }
            }
        }

        function returnCarPayType(str) {
            for (var i = 0; i < CarPayType.length; i++) {
                if (str == CarPayType[i].value) {
                    return CarPayType[i].exp;
                }
            }
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
//            var dealType = "BALANCE_RECHARGE";
            var fromList = $("#From").formSerialize();
            var p = $.extend({pageNum: pageNum}, {pageSize: pageSize}, fromList);
            Project.ajax("/admin/user/capital/page", p, null, null).ajaxOK(function (data) {
                $("#goodList").html(template("f1", data));//作用到表格
                $("#page").html(template("f2", data));//作用到分页
                if ( data.data.list != null && data.data.list.length != 0) {
                pages = data.data.pages;
                items = data.data.list;
                $('.popupShow').each(function () {
                    $(this).click(function () {
                        var id = $(this).attr('id');
                        for (var i = 0; i < items.length; i++) {
                            if (items[i].userCapitalRecord.id == id) {
                                ShowPopup(items[i]);
                                return;
                            }
                        }
                    })
                })
            }
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

        function updateType(id, status) {
            Project.ajax("/admin/user/capital/update", {id: id, status: status}, null, null).ajaxOK(function (data) {
                findList();
            }, true);
        }


        function findcCc(pageNum) {
            var phoneNumber=$("input[name=phoneNumber]").val();
            var status=$("select[name=status]").val();
            var officialPartnerOrder=$("input[name=officialPartnerOrder]").val();
            var dealType=$("select[name=dealType]").val();
            var payType=$("select[name=payType]").val();
            var beginTime=$("input[name=beginTime]").val();
            var endTime=$("input[name=endTime]").val();
            window.location.href="${apiHost}/api/json/admin/a/liushui?phoneNumber="+phoneNumber+"&status="+status+"&officialPartnerOrder="+officialPartnerOrder+"&dealType="+dealType+"&payType="+payType+"&beginTime="+beginTime+"&endTime="+endTime;
        }


    </script>

</div>

</@frame.businessV2>