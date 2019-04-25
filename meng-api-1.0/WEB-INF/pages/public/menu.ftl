<#macro menu title>
    <@html.frame title="${title}">
    <style>
        body {
            overflow: hidden;
        }
    </style>
    <div id="win10">
        <div class="desktop">
            <div id="win10-shortcuts" class="shortcuts-hidden">
            </div>
            <div id="win10-desktop-scene"></div>
        </div>
        <div id="win10-menu" class="hidden">
            <div class="list win10-menu-hidden animated animated-slideOutLeft">
                <div class="item"
                     onclick="Win10.exit()">
                    <i class="black icon fa fa-power-off fa-fw"></i><span class="title">关闭</span>
                </div>
            </div>
            <div class="blocks">
                <div class="menu_group">
                    <div class="title">Welcome</div>
                    <div class="block" loc="1,1" size="6,4">
                        <div class="content">
                            <div style="font-size:100px;line-height: 132px;margin: 0 auto ;display: block"
                                 class="fa fa-fw fa-windows win10-block-content-text"></div>
                            <div class="win10-block-content-text" style="font-size: 22px">欢迎使用 Win10-UI</div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="win10-menu-switcher"></div>
        </div>
        <div id="win10_command_center" class="hidden_right">
            <div class="title">
                <h4 style="float: left">消息中心 </h4>
                <span id="win10_btn_command_center_clean_all">全部清除</span>
            </div>
            <div class="msgs"></div>
        </div>
        <div id="win10_task_bar">
            <div id="win10_btn_group_left" class="btn_group">
                <div id="win10_btn_win" class="btn"><span class="fa fa-windows"></span></div>
                <div class="btn" id="win10-btn-browser"><span class="fa fa-internet-explorer"></span></div>
            </div>
            <div id="win10_btn_group_middle" class="btn_group"></div>
            <div id="win10_btn_group_right" class="btn_group">
                <div class="btn" id="win10_btn_time"></div>
                <div class="btn" id="win10_btn_command"><span id="win10-msg-nof" class="fa fa-comment-o"></span></div>
                <div class="btn" id="win10_btn_show_desktop"></div>
            </div>
        </div>
    </div>

    <script type="text/html" id="menuListTP">
        {{each $data as one}}
        <div class='shortcut' data-my='{{$jsonToString one}}'>
            {{imgView one.logo}}
            <div class='title'>{{one.introduce}}</div>
        </div>
        {{/each}}
    </script>
    //todo
    <script type="text/html" id="tMenuListTP">
        {{each urlDescribes as one}}
        <div onclick="openUrl('${path}{{uri[0]}}{{one.uri[0]}}','{{one.introduce}}')">
            {{imgView one.logo}}
            <div class='title'>{{one.introduce}}</div>
        </div>
        {{/each}}
    </script>
    <script>
        var index_ly;

        function openUrl(uri, name) {
            if (index_ly) layer.close(index_ly);
            Win10.openUrl(uri, "<i class='fa fa-user icon black-green'></i>" + name);
        }

        template.helper("imgView", function (src) {
            src = src || "";
            if (src.startWith("<?xml")) return src;
            return "<img src='" + src + "'/>"
        });


        Win10.onReady(function () {
            var $menuList = $("#win10-shortcuts");
            Project.ajax("/api/json/menu/list", null, null, true).ajaxOK(function (data) {
                data = data.data;
                //业务逻辑
                var $um = $("#useMenu");
                useMenuHan();

                //写入菜单
                function useMenuHan() {
                    if ($um.is(':checked')) {
                        getUsrData(function (usr) {
                            $menuList.html(template("menuListTP", filedAs(usr)));

                            function filedAs(usr) {
                                $(usr).each(function () {
                                    this.uri = [this.url];
                                <#--noinspection JSUnresolvedVariable-->
                                    this.introduce = this.name;
                                    if (this.children) {
                                        this.urlDescribes = filedAs(this.children);
                                    }
                                });
                                usr.usr = true;
                                return usr;
                            }
                        });
                    } else {
                        defaultMenu();
                    }
                }

                $um.change(function () {
                    useMenuHan();
                });

                //获取自定义菜单
                var usrData;

                function getUsrData(su) {
                    function run() {
                        su(usrData);
                    }

                    if (usrData) {
                        run();
                    } else {
                        Project.ajax("/admin/menu/list/admin", null, {
                            error: function () {
                                usrData = data;
                                run();
                                van("自定义菜单接口错误，使用默认菜单");
                            }
                        }).ajaxOK(function (d) {
                            usrData = d.data;
                            run();
                        }, null, false, function (error) {
                            usrData = data;
                            run();
                            if (error.code === "EMPTY") {
                                van("由于没有设置自定义菜单，使用默认菜单");
                            } else {
                                van("获取自定义菜单失败[" + error.msg + "],使用默认菜单");
                            }
                        });
                    }
                }

                //默认菜单
                function defaultMenu() {
                    $menuList.html(template("menuListTP", data));
                    $("*[data-my]").click(function () {
                        var my = JSON.parse($(this).attr("data-my"));
                        var list = my.urlDescribes;
                        index_ly = layer.open({
                            title: my.introduce,
                            type: 1,
                            shadeClose: true,
                            content: template('tMenuListTP', my)
                        });
                    });
                    Win10.renderShortcuts();
                }
            });

            $("#logout").click(function () {
                cm.setCookie("ADMIN_TOKEN", "");
                location.href = pathPage + "/user/login";
            });
            //设置壁纸
            Win10.setBgUrl({
                main: '${pathView}/img/wallpapers/main.jpg',
                mobile: '${pathView}/img/wallpapers/mobile.jpg'
            });

            Win10.setAnimated([
                'animated flip',
                'animated bounceIn'
            ], 0.01);
        });
        window.alert = wl;
    </script>
    </@html.frame>
</#macro>