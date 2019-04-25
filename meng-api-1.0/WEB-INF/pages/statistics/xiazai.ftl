<@frame.businessV2 title="${title}">
    <#include "public/var.ftl">
<style>
    .buttons-wrapper {
        width: 100%;
        height: 100%;
    }

    .buttons-main {
        width: 80%;
        margin: 0 auto;
    }

    .buttons-list {
        margin: 0 auto;
    }

    .buttons-list li {
        list-style: none;
        float: left;
        width: 170px;
        text-align: center;
        box-sizing: border-box;
        border: 1px solid gainsboro;
        height: 170px;
        margin: 5px;
    }

    @media (min-width: 1024px) {
        .buttons-list li {
            width: 185px;
            height: 185px;
        }
    }

    @media (min-width: 1280px) {
        .buttons-list li {
            width: 235px;
            height: 235px;
        }
    }

    @media (min-width: 1366px) {
        .buttons-list li {
            width: 260px;
            height: 260px;
        }
    }

    @media (min-width: 1440px) {
        .buttons-list li {
            width: 275px;
            height: 275px;
        }
    }

    @media (min-width: 1600px) {
        .buttons-list li {
            width: 300px;
            height: 300px;
        }
    }

    @media (min-width: 1900px) {
        .buttons-list li {
            width: 350px;
            height: 350px;
        }
    }

    .buttons-list li a {
        display: none;
    }

    .buttons-list li p {
        height: 40px;
        line-height: 40px;
    }

    .buttons-list li:hover {
        border: 2px solid #839af1;

    }

    .buttons-list li:hover p {
        display: none;
    }

    .buttons-list li:hover a {
        display: block;
        width: 80%;
        margin: 0 auto;
        background: #5d9afc;
        height: 40px;
        line-height: 40px;
        color: white;
        border-radius: 5px;
    }

    .buttons-list li dl {
        height: 100%;

    }

    .buttons-list li dt {
        box-sizing: border-box;
        height: 70%;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .buttons-list li dt img {
        width: 30%;
    }

    .buttons-list li dd {
        box-sizing: border-box;
        cursor: pointer;
        overflow: hidden;
        height: 30%;
        display: flex;
        justify-content: center;
        align-items: center;
    }


</style>
<div class="buttons-wrapper">
    <div class="buttons-main">
        <ul class="buttons-list">
            <li>
                <dl>
                    <dt><img src="${path}/resources/img/down/inbla.png"></dt>
                    <dd>
                        <p>余额充值</p>
                        <a href="${apiHost}/api/json/admin/a/balance/recharge">下载</a>
                    </dd>
                </dl>
            </li>
            <li>
                <dl>
                    <dt><img src="${path}/resources/img/down/wx.png"></dt>
                    <dd>
                        <p>微信充值</p>
                        <a href="${apiHost}/api/json/admin/a/wechant/pay">下载</a>
                    </dd>
                </dl>
            </li>
            <li>
                <dl>
                    <dt><img src="${path}/resources/img/down/aipay.png"></dt>
                    <dd>
                        <p>支付宝充值</p>
                        <a href="${apiHost}/api/json/admin/a/ali/pay">下载</a>
                    </dd>
                </dl>
            </li>
            <li>
                <dl>
                    <dt><img src="${path}/resources/img/down/cash.png"></dt>
                    <dd>
                        <p>现金卷充值</p>
                        <a href="${apiHost}/api/json/admin/a/cash/coupon/recharge/total">下载</a>
                    </dd>
                </dl>
            </li>
            <li>
                <dl>
                    <dt><img src="${path}/resources/img/down/zcsl.png"></dt>
                    <dd>
                        <p>租车数量</p>
                        <a href="${apiHost}/api/json/admin/a/car/number">下载</a>
                    </dd>
                </dl>
            </li>
            <li>
                <dl>
                    <dt><img src="${path}/resources/img/down/zclc.png"></dt>
                    <dd>
                        <p>租车里程</p>
                        <a href="${apiHost}/api/json/admin/a/car/mileage">下载</a>
                    </dd>
                </dl>
            </li>
            <li>
                <dl>
                    <dt><img src="${path}/resources/img/down/zccs.png"></dt>
                    <dd>
                        <p>租车次数</p>
                        <a href="${apiHost}/api/json/admin/a/car/frequency">下载</a>
                    </dd>
                </dl>
            </li>
            <li>
                <dl>
                    <dt><img src="${path}/resources/img/down/add.png"></dt>
                    <dd>
                        <p>新增用户数</p>
                        <a href="${apiHost}/api/json/admin/a/user/number">下载</a>
                    </dd>
                </dl>
            </li>
            <li>
                <dl>
                    <dt><img src="${path}/resources/img/down/bond.png"></dt>
                    <dd>
                        <p>交纳押金人数</p>
                        <a href="${apiHost}/api/json/admin/a/deposit/number">下载</a>
                    </dd>
                </dl>
            </li>
            <li>
                <dl>
                    <dt><img src="${path}/resources/img/down/outbond.png"></dt>
                    <dd>
                        <p>退押金数</p>
                        <a href="${apiHost}/api/json/admin/a/deposit/back/number">下载</a>
                    </dd>
                </dl>
            </li>
            <li>
                <dl>
                    <dt><img src="${path}/resources/img/down/bla.png"></dt>
                    <dd>
                        <p>余额提现</p>
                        <a href="${apiHost}/api/json/admin/a/balance/back">下载</a>
                    </dd>
                </dl>
            </li>
            <li>
                <dl>
                    <dt><img src="${path}/resources/img/down/count.png"></dt>
                    <dd>
                        <p>统计总订单收益</p>
                        <a href="${apiHost}/api/json/admin/a/order/total">下载</a>
                    </dd>
                </dl>
            </li>
        </ul>
    </div>
</div>
<!--
余额充值  微信充值 支付宝充值

  租车数量  租车里程 租车次数

新增用户数 交纳押金人数   退押金数
  余额提现 统计总订单收益
-->
</@frame.businessV2>