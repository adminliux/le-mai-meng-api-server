<#--noinspection FtlFileReferencesInspection-->
<#macro business title>
<#--noinspection FtlImportCallInspection,FtlReferencesInspection-->
    <@html.frame title="${title}">
        <#include "public/var.ftl">
        <!-- Bootstrap Styles-->
        <!--suppress ALL -->
    <#--noinspection FtlImportCallInspection,FtlReferencesInspection-->
        <link href="${pathView}/css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <!-- FontAwesome Styles-->
    <#--noinspection FtlImportCallInspection,FtlReferencesInspection-->
        <link href="${pathView}/css/font-awesome.css" rel="stylesheet" type="text/css"/>
        <!-- Morris Chart Styles-->
    <#--noinspection FtlImportCallInspection,FtlReferencesInspection-->
        <link href="${pathView}/js/morris/morris-0.4.3.min.css" rel="stylesheet" type="text/css"/>
        <!-- Custom Styles-->
    <#--noinspection FtlImportCallInspection,FtlReferencesInspection-->
        <link href="${pathView}/css/custom-styles.css" rel="stylesheet" type="text/css"/>

        <!-- Animation library for notifications   -->
    <#--noinspection FtlImportCallInspection,FtlReferencesInspection-->
        <link href="${pathView}/css/animate.min.css" rel="stylesheet" type="text/css"/>

        <!--  Paper Dashboard core CSS -->
    <#--noinspection FtlImportCallInspection,FtlReferencesInspection-->
        <link href="${pathView}/css/paper-dashboard.css" rel="stylesheet" type="text/css"/>
        <!--  CSS for Demo Purpose, don't include it in your project     -->
    <#--noinspection FtlImportCallInspection,FtlReferencesInspection-->
        <link href="${pathView}/css/demo.css" rel="stylesheet" type="text/css"/>
    <#--noinspection FtlImportCallInspection,FtlReferencesInspection-->
        <link href="${pathView}/css/themify-icons.css" rel="stylesheet" type="text/css">
    <#--noinspection FtlImportCallInspection,FtlReferencesInspection-->
        <script src="${pathView}/cKeditor/ckeditor.js"></script>
    <#--noinspection FtlImportCallInspection,FtlReferencesInspection-->
        <link rel="stylesheet" href="${pathView}/cKeditor/samples/css/samples.css" type="text/css">
    <#--noinspection FtlImportCallInspection,FtlReferencesInspection-->
        <link rel="stylesheet" href="${pathView}/cKeditor/samples/toolbarconfigurator/lib/codemirror/neo.css"
              type="text/css">
        <style>
            body {
                overflow: auto;
            }

            .col-md-3 {
                float: none;
                display: inline-block;
                width: auto;
            }

            .class-open {
                overflow: auto;
                height: 100px;
            }

            input[type=radio] {

            }

            .se_radio {
                width: 20px;
                display: inherit;
            }

            button {
                min-width: 10px !important;
            }

            .min_but {
                font-size: 10px;
                padding: 2px;
            }

            td {
                text-overflow: ellipsis;
            }

            .btn {
                border-radius: 0;
            }

            /*.pci:hover {*/
            /*width: 500px;*/
            /*}*/

            .sort_cb {
                position: relative;
            }

            .sort_cb::before {
                content: '▲';
                position: absolute;
                top: -6;
                left: 0;
                width: 17px;
                height: 22px;
                line-height: 22px;
                text-align: center;
                color: white;
                font-size: 16px;
                background-color: #2B2E33;
                border-radius: 4px;
            }

            .sort_cb:checked::before {
                color: white;
                background-color: #00F7DE;
                content: '▼';
            }
        </style>

        <script type="text/html" id="tableSearchTP">
            {{each fields as it}}
            <div class="col-sm-6">
                <div id="dataTables-example_filter" class="dataTables_filter"><label>{{it.intro}}:<input
                                type="search" class="form-control input-sm" name="{{it.name}}"
                                aria-controls="dataTables-example"></label></div>
            </div>
            {{/each}}
            {{each condBetween as it}}
            <div class="col-sm-6">
                <div id="dataTables-example_filter" class="dataTables_filter"><label>{{it.intro}}:<input
                                type="search" class="form-control input-sm" name="{{it.name}}"
                                aria-controls="dataTables-example">-<input type="search" class="form-control input-sm"
                                                                           name="{{it.name}}"
                                                                           aria-controls="dataTables-example"></label>
                </div>
            </div>
            {{/each}}
        </script>

        <script type="text/html" id="tableSearchTP_">
            {{each $data as it}}
            <div class="col-md-3">
                <div class="form-group">
                <span data-link="{{it.link}}">{{it.intro}}
                    {{if it.bigType === "ENUM"}}
                    <a>
                        <select class="form-control border-input" {{required it canNull}} name="{{it.name}}">
                            <option value="">全部</option>
                            {{enumGenderOption it.type}}
                        </select>
                    </a>
                    {{else if it.bigType === "LIST"}}
                    <div data-name-fd="{{it.name}}"></div>
                    {{include 'tableSearchTP' [it]}}
                    {{else if it.bigType === "MAP"}}
                    {{else if it.bigType === "DECIMAL" || it.bigType === "INT"}}
                    <input {{required it canNull}} name="{{it.name}}" type="number" class="form-control border-input"
                           placeholder="请输入">
                    {{else if it.bigType === "STRING" || it.bigType === "MD5"}}
                    <input {{required it canNull}} name="{{it.name}}" class="form-control border-input"
                           placeholder="请输入">
                     {{else if it.bigType === "ENTITY"}}
                    <a>
                        <select class="form-control border-input" {{required it canNull}} name="{{it.name}}">
                            <option value="">全部</option>
                            {{entityGenderOption}}
                        </select>
                    </a>
                    {{else if it.bigType === "DATE"}}
                    <input {{required it canNull}} name="{{it.name}}" data-dt class="form-control border-input"
                           placeholder="请输入">
                    {{else if it.bigType === "IMG"}}
                    <input {{required it canNull}} name="{{it.name}}" data-type="date" class="form-control border-input"
                           placeholder="请输入">
                    {{else if it.bigType === "NESTING"}}
                    {{if it.type === bottomPo('UrlResImg')}}
                    <input {{required it canNull}} type="file" onchange="uptFile(this)"/>
                    <input {{required it canNull}} type="hidden" name="{{it.name}}.uri"/>
                    <img onclick="openImg(this)" width="50" class="pci" data-name="{{it.name}}.url" src="">
                    {{else}}
                    {{include 'tableSearchTP_' it.children}}
                    {{/if}}
                    {{else if it.bigType === "BOOL"}}
                    <em>
                        是:<input {{required it canNull}} name="{{it.name}}" type="radio" class="se_radio"
                                 placeholder="请输入" value="true">
                        否:<input {{required it canNull}} name="{{it.name}}" type="radio" class="se_radio"
                                 placeholder="请输入" value="false">
                    </em>
                    {{else if it.bigType === "RICH_TEXT"}}
                    <a onclick="rTextEdit(this,'{{it.name}}')" href="JavaScript:void(0)">编辑</a>
                    {{/if}}
                    <span data-r></span>
                </>
                </div>
            </div>
            {{/each}}
        </script>


        <script type="text/html" id="paging-tp">
            <a href='javascript:{{run}}("{{firstPage}}")'>第一页</a>
            <a href='javascript:{{run}}("{{nextPage}}")'>下一页</a>
            {{each navigatepageNums as navNum}}
            <a href='javascript:{{run}}("{{navNum}}")'>{{navNum}}</a>
            {{/each}}
            <a href='javascript:{{run}}("{{prePage}}")'>上一页</a>
            <a href='javascript:{{run}}("{{lastPage}}")'>最后一页</a>
            <div> 第<input placeholder="页码" type="number" onchange="uptPageNum(this,'{{run}}')"
                          value="{{pageNum}}" style="width: 80px;">页 1/{{pages}}页 共{{total}}条记录
                &nbsp;&nbsp;每页<input placeholder="一页大小" type="number" style="width: 80px;" value="{{pageSize}}"
                                     onchange="uptPageSize(this,'{{run}}')">条记录
            </div>
        </script>

        <script type="text/html" id="loadTableRowSelect_">
            <div class="col-md-12">
                <div class="card">
                    <form>
                        <p class="category">
                            <input name="keyword" style="width: calc(100% - 50px)" placeholder="关键字">
                            <button type="submit" style="width: 45px">查询</button>
                        </p>
                    </form>
                    <div class="content table-responsive table-full-width" id="_s_table">
                    </div>
                    <div class="paging"></div>
                </div>
            </div>
        </script>

        <script type="text/html" id="table_">
            <table class="table table-striped">
                <thead>
                <tr>
                    <th><label><input name="ac" type="checkbox"></label></th>
                    <th>区域</th>
                    {{each $data as it}}
                    <th data-name="{{it.name}}">
                        <a href="javascript:void(0)" onclick="sortChange(this)">
                            <input style="display: none;" class="sort_cb" name="{{it.name}}" type="checkbox"
                                   placeholder="排序">
                            {{it.intro}}
                        </a>
                    </th>
                    {{/each}}
                    <th>操作</th>
                </tr>
                </thead>
                <tbody data-old style="color: red"></tbody>
                <tbody data-list></tbody>
            </table>
        </script>

        <script type="text/html" id="page-td-tp">
            {{each list as it}}
            <tr>
                <td><label>
                        <input name="id" value="{{it.id}}" type="checkbox">
                    </label></td>
                <td>
                    {{it.region}}
                </td>
                {{tableRow it tableId}}
                <td>
                    <button class="btn btn-info btn-fill btn-wd min_but"
                            onclick="deleteRow('{{apiTableType}}','{{it.id}}')">
                        删除
                    </button>
                    <button class="btn btn-info btn-fill btn-wd min_but"
                            onclick="bkOpenByType('{{apiTableType}}','{{it.id}}')">
                        修改
                    </button>
                    <button onclick="setRegion('{{apiTableType}}','{{it.id}}')"
                            class="btn btn-info btn-fill btn-wd min_but">
                        分配市区
                    </button>
                </td>
            </tr>
            {{/each}}
        </script>
        <script type="text/html" id="_a">
            <a href='javascript:void(0)' onclick='openRow("{{link}}","{{id}}")'></a>
        </script>

        <script>
            var pageNumPage = 0, adminImgDisplay, adminImgDisplayView, adminImgContrast,
                adminImgContrastTarget, entitys, pageSize;

            function entityGenderOption() {
                var temp = '';
                for (var key in entitys) {
                    temp += "<option value='" + key + "'>" + entitys[key] + "</option>";
                }
                return temp;
            }

            var rTexts = {};

            function ajaxMainRowsLink(id, back, typeClass) {
                typeClass = typeClass || type;
                var ids = "";
                for (var i = 0; i < id.length; i++) {
                    ids += "&id=" + id[i];
                }
                Project.ajax("/table/display/" + typeClass + "/view/data/main", ids.substring(1)).ajaxOK(function (data) {
                    if (back) back(data.data);
                });
            }

            function uptPageSize(el, run) {
                var p = $(el).val();
                if (p !== "") {
                    pageSize = p;
                    if (run) eval(run + "()");
                }
            }

            function getJsonValue_(data, name) {
                try {
                    return data[name];
                } catch (e) {
                    return null;
                }
            }

            function rTextEdit(el, name) {
                var editor;
                var content = rTexts[name] || getJsonValue_(window.rowData, name) || "";
                //TODO
                var title = "编辑内容";
                var index = layer.open({
                    zIndex: 11,
                    type: 0,
                    title: title,
                    shadeClose: true,
                    shade: false,
                    maxmin: true, //开启最大化最小化按钮
                    area: ['90%', '90%'],
                    content: '<div data-rich-' + name + '>\n' + content +
                        '</div>',
                    yes: function () { //此处用于演示
                        rTexts[name] = editor.getData();
                        layer.close(index);
                    }
                });

                $("div[data-rich-" + name + "]").each(function () {
                    var $_ = $(this);
                    $_.attr("_compile", true);

                    var initSample = (function () {
                        var wysiwygareaAvailable = isWysiwygareaAvailable(),
                            isBBCodeBuiltIn = !!CKEDITOR.plugins.get('bbcode');

                        return function () {
                            if (wysiwygareaAvailable) {
                                editor = CKEDITOR.replace($_[0]);
                            }
                        };

                        function isWysiwygareaAvailable() {
                            if (CKEDITOR.revision === ('%RE' + 'V%')) {
                                return true;
                            }
                            return !!CKEDITOR.plugins.get('wysiwygarea');
                        }
                    })();
                    initSample();
                });
            }

            template.helper("entityGenderOption", entityGenderOption);

            loadEntitys();

            function loadEntitys() {
                //所有实体类
                Project.ajax("/global/admin/domain/all/classes").ajaxOK(function (data) {
                    var classes = data.data;
                    entitys = classes;
                });
            }

            //加载IMG
            function loadAdminImgDisplay() {
                var types = bottomJo('AdminImgDisplay');
                Project.ajax("/admin/img/" + types + "/all", {
                    apiTableType: types
                }).ajaxOK(function (data) {
                    data = data.data;
                    adminImgDisplay = data;
                    adminImgDisplayView = function (table, line) {
                        var list = data[table];
                        if (!list || list.length <= 0) return null;
                        for (var i = 0; i++; i < list.length) {
                            var it = list[i], targetColumn = it["targetColumn"];
                            for (var j = 0; j < targetColumn.length; j++) {
                                var col = targetColumn[j];
                                if (col === line) {
                                    return it["displayMode"] === "SHOW";
                                }
                            }
                        }
                        return true;
                    };
                    template.helper("adminImgDisplayView", adminImgDisplayView);
                });
            }

            loadAdminImgDisplay();
            loadAdminImgContrast();

            //加载托对比
            function loadAdminImgContrast() {
                var types = bottomJo('AdminImgContrast');
                Project.ajax("/admin/img/" + types + "/all", {
                    apiTableType: types
                }).ajaxOK(function (data) {
                    data = data.data;
                    adminImgContrast = data;
                    adminImgContrastTarget = function (table, line) {
                        var list = data[table];
                        if (!list || list.length <= 0) return null;

                        function getList(list, source, out) {
                            var def = [];
                            for (var i = -1; i++; i < list.length) {
                                var it = list[i], targetColumn = it[source];
                                for (var j = 0; j < targetColumn.length; j++) {
                                    var col = targetColumn[j];
                                    if (col === line) {
                                        return it[out] || def;
                                    }
                                }
                            }
                            return def;
                        }

                        var outList = getList(list, "sourceColumn", "targetColumn");
                        if (outList.length > 0) return outList;
                        return getList(list, "targetColumn", "sourceColumn");
                    };
                });
            }


            template.helper("required", function (it, canNull) {
                if (canNull) return null;
                if (!it["canNull"]) return "required";
            });

            function bottomPo(last) {
                return bottomJo("po." + last);
            }

            function bottomJo(last) {
                return "com.rpframework.module.common.bottom.entity." + last;
            }

            function bkOpenByType(type, id) {
                id = id || "";
                openRow(type, id, $("#_bkOpen").checked());
            }

            //设置记录区域
            function setRegion(_type, id, isAll) {
                _type = _type || type;
                layer.open({
                    title: '设置区域'
                    , content: _select_p
                    , yes: function (index, layero) {
                        layer.close(index);
                        var data = layero.find("form").serialize() + "&tableName=" + _type;
                        if (id) {
                            data += "&tableId=" + id;
                            Project.ajax("/global/partition/record/set", data).ajaxOK(function () {
                            }, true);
                        } else if (isAll) {
                            data += "&apiTableType=" + _type;
                            Project.ajax("/global/partition/record/set/all", data).ajaxOK(function () {
                            }, true);
                        } else {
                            var tbs = getCheckIdParam("tableIds");
                            if (tbs) {
                                data += tbs;
                                Project.ajax("/global/partition/record/sets", data).ajaxOK(function () {
                                }, true);
                            }
                        }
                    }
                });
            }

            function getViewerView(images, def) {
                return pathPage + "/index/viewer?images=" + encodeURI(JSON.stringify(images)) + "&viewSrc=" + def;
            }


            function openImg(el, type) {
                var $el = $(el), $group = $el.parentSum(3), images = [];
                if ($el.attr("data-src")) {
                    $group.find("img").each(function () {
                        var src_ = $(this).attr("data-src");
                        $(this).attrSrc(src_);
                    });
                }
                $group.find("img").each(function () {
                    images.push($(this).attrSrc());
                });
                var ts = adminImgContrastTarget(type, $el.attr("data-dm"));
                var def = $el.attrSrc($(this).attrSrc());
                var h = document.body.clientHeight - 50;
                if (!ts || ts.length <= 0) {
                    var $if = $("<iframe  style='width: 100%;height: " + h + "px'></iframe>");
                    $if.attr("src", getViewerView(images, def));
                    layer.open({
                        type: 1,
                        title: "图片预览",
                        shadeClose: true,
                        shade: false,
                        maxmin: true, //开启最大化最小化按钮
                        area: ['100%', '100%'],
                        content: $if.htmlContain()
                    });
                } else {
                    var $p = $("<div></div>");
                    $(ts).each(function () {
                        var src_ = $group.find("img[data-dm='" + this + "']").attrSrc();
                        $p.append("<iframe  style='width: 50%;height: " + h + "px' src='" + getViewerView(images, src_) + "'></iframe>")
                    });
                    $p.append("<iframe  style='width: 50%;height: " + h + "px' src='" + getViewerView(images, def) + "'></iframe>")
                    layer.open({
                        type: 1,
                        title: "图片预览",
                        shadeClose: true,
                        shade: false,
                        maxmin: true, //开启最大化最小化按钮
                        area: ['100%', '100%'],
                        content: $p.html()
                    });
                }
                /*$group.viewer({inline: true, zIndexInline: 100});
                $().each(function () {
                    $group.viewer({inline: true, zIndexInline: 100});
                    //$group.find("img[data-dm='" + this + "']").click();
                });*/
            }

            template.helper("bottomPo", bottomPo);
            template.helper("pathView", function () {
                return pathView;
            });

            //排序事件
            function sortChange(el) {
                var $this = $(el), $sort = $this.find("input[type=checkbox]");
                if ($sort.isHidden()) {
                    $sort.show();
                } else {
                    if ($sort.checked()) $sort.hide();
                    $sort.checked(-1);
                }
            }

            function uptPageNum(el, run) {
                var p = $(el).val();
                if (p !== "") {
                    if (run) eval(run + "(" + p + ")");
                }
            }

            function uptFile(el) {
                var file = el.files[0], fm = new FormData(), _ = $(el),
                    $in = _.next(), $img = $in.next();
                fm.append("files", file);
                Project.ajaxUploadFilesV2(fm).ajaxOK(function (data) {
                    data = data.data[0];
                    $in.val(data.uri);
                    $img.attrSrc(data.url);
                });
            }

            function parseSimEnum(enum_) {
                var sp = enum_.split(".");
                return sp[sp.length - 1];
            }

            function imageType() {
                return bottomPo("UrlResImg");
            }

            function isImgUrl(t) {
                return t.type === imageType();
            }

            template.helper("parseSimEnum", parseSimEnum);

            /**
             * 获取字段值
             * @param t 字段名称
             * @param li 数据对象
             * @returns {*} 无值返回空字符
             */
            function getRowValue(t, li, type) {
                for (var i in li) {
                    <#--noinspection JSUnfilteredForInLoop-->
                    if (i === t.name) {
                        var it = t.value || li[i], last = $("<span></span>");
                        if (t.link) last = $(template('_a', {link: t.link, id: it}));

                        function getValue() {
                            switch (t["bigType"]) {
                                case "NESTING":
                                    if (isImgUrl(t)) {
                                        var dis = adminImgDisplayView(type, t.name);
                                        var src = dis ? pathView + "/load_img.svg" : it.url;
                                        var dataSrc = dis ? "data-src" : "";
                                        return "<img onclick='openImg(this,type)' data-dm=" + t.name + " class='pci' width='30' " + dataSrc + "='" + it.url + "' src='" + src + "'/>"
                                    } else if (t.type === bottomPo("UrlResHref")) {
                                        if (it) {
                                            return '<a href="javascript:void(0)" onclick=\'openHref("' + it.url + '")\'>查看</a>';
                                        } else {
                                            return '无';
                                        }
                                    }
                                    return "解析错误";
                                case "DATE":
                                    return cm.timestampFormatYMDHMS(it);
                                case "BOOL":
                                    return it ? "是" : "否";
                                case "ENUM":
                                    return Enum.value(parseSimEnum(t['type']), it);
                                case "LIST": {
                                    if (t.type.indexOf("UrlResImg") != -1) {
                                        var valueAll = "";
                                        $(it).each(function (_i, _v) {
                                            valueAll += getRowValue(
                                                $.extend(t, {
                                                    bigType: "NESTING",
                                                    type: imageType(),
                                                    value: _v
                                                }), li, type);
                                        });
                                        return valueAll;
                                    } else {
                                        return it;
                                    }
                                }
                                case "RICH_TEXT":
                                    return "<a data-content='" + it + "' onclick=\"openRText(this)\">查看</a>"
                                default:
                                    return it;
                            }
                        }

                        last.html(getValue());
                        var $p = $("<div></div>");
                        $p.append(last);
                        return $p.html();
                    }
                }
                return "";
            }

            function openRText(el) {
                var title = "查看内容";
                layer.open({
                    type: 0,
                    title: title,
                    shadeClose: true,
                    shade: false,
                    maxmin: true, //开启最大化最小化按钮
                    area: ['90%', '90%'],
                    content: el.getAttribute("data-content")
                });
            }

            function tableViewAttribute(type, success) {
                Project.ajax('/global/admin/' + type + '/calculated/attribute').ajaxOK(function (data) {
                    data = data.data;
                    if (success) success(data);
                });
            }

            var tb_fun = {};

            function tableView(type, $table, success) {
                tableViewAttribute(type, function (data) {
                    $table.html(template("table_", data));
                    template.helper("tableRow", function (li, tbId) {
                            var f = tb_fun[tbId];
                            if (f) {
                                return f(li);
                            } else {
                                tb_fun[tbId] = function (li) {
                                    var html = '';
                                    var html = '';
                                    data.forEach(function (t) {
                                        var rv = getRowValue(t, li, type);
                                        var linkTpye = t.link, v = li[t.name];
                                        html += '<td data-name="' + t.name + '" data-value="' + v + '" data-type="' + linkTpye + '">' + rv + '</td>';
                                    });
                                    return html;
                                };
                                return tb_fun[tbId](li);
                            }
                        }
                    );

                    if (success) success(data);
                });
            }

            function calculatedFrom($tableSearch, data, success, canNull) {
                data.canNull = canNull;
                $tableSearch.html(template("tableSearchTP_", data));
                $tableSearch.find("*[data-link]").click(function () {
                    var $_ = $(this), link = $_.attr('data-link'), $in = $_.find("input");
                    if (link && link !== "") {
                        loadTableRowSelect(link, $in.val(), function (it, fm) {
                            $in.val(it.id);
                            var v = it[fmMainInfo(fm)];
                            if (!v) v = "";
                            if (link === "com.daolezuche.entity.CarModelsPriceMode") {
                                delete it["id"];
                                delete it["gmtDatetime"];
                                delete it["uptDatetime"];
                                $tableSearch.formAssign(it);
                            }
                            $_.find("span[data-r]").html(v);
                        });
                    }
                });

                //时间选择器
                $tableSearch.find("input[data-dt]").each(function () {
                    var id = "_" + Math.round(Math.random() * 5000);
                    $(this).attr("id", id);
                    //if (!cm.stringIsEmpty($(this).val())) {
                    laydate.render({
                        elem: '#' + id, type: 'datetime'
                    });
                    //}
                });
                if (success) success();
            }


            function arrayFst(arr, if_) {
                for (var i = 0; i < arr.length; i++) {
                    var it = arr[i];
                    if (if_(it)) return it;
                }
            }

            function fmMainInfo(fd) {
                var it = arrayFst(fd, function (it) {
                    return it["mainAttr"];
                });
                return it ? it.name : "id";
            }

            var loadP = {};

            //--搜索
            function loadTableRowSelect(type, id, success) {
                var index = layer.open({
                        type: 1,
                        title: '查看/修改关联记录',
                        shadeClose: true,
                        shade: false,
                        maxmin: true, //开启最大化最小化按钮
                        area: ['90%', '90%'],
                        content: template("loadTableRowSelect_", {}),
                        success: function (el) {
                            var $tbPage = $(el).find(".table-responsive");
                            var $from = $(el).find("form");


                            function tableAjax(pageNum, fd) {
                                pageTableAjax(pageNum,
                                    {apiUri: "/population/search", tableId: type},
                                    $from, type, $(el).find(".paging"), $tbPage.find("tbody[data-list]"), function (data) {
                                        $tbPage.find("input[type=checkbox]").change(function () {
                                            var $in = $(this), id = $in.val();
                                            if ($in.checked()) {
                                                var att = arrayFst(data.list, function (it) {
                                                    return it.id + "" === id;
                                                }) || {};
                                                layer.close(index);
                                                if (success) success(att, fd);
                                            }
                                        });
                                    }, "loadP.tableAjax"
                                );
                            }

                            loadP.tableAjax = tableAjax;

                            tableView(type, $tbPage, function (data) {
                                if (id) {
                                    Project.ajax('/global/admin/' + type + '/select/by/id', {id: id}).ajaxOK(function (row) {
                                        row = row.data;
                                        rowsSetData(type, [row], function (list) {
                                            $tbPage.find("tbody[data-old]").html(template('page-td-tp', {list: list}));
                                        });
                                    });
                                }
                                tableAjax(1, data);

                                $from.html5Validate(function () {
                                    tableAjax(1, data);
                                    return false;
                                });
                            });
                        }
                    })
                ;
            }

            function keySearch($in, $p, keyName) {
                keyName = "data-key";
                $p = $p || $(document.body);
                var keyword = $in.val();
                var $all = $p.find('*[' + keyName + ']');
                if (keyword === "") {
                    $all.show();
                } else {
                    $all.hide();
                    $p.find('*[' + keyName + '*="' + keyword + '"]').show();
                }
            }

            function openHref(href, title) {
                title = title || "查看网页";
                layer.open({
                    type: 2,
                    title: title,
                    shadeClose: true,
                    shade: false,
                    maxmin: true, //开启最大化最小化按钮
                    area: ['90%', '90%'],
                    content: href
                });
            }

            function openRow(type, id, brack) {
                var url = path + "/base/row?type=" + type + "&id=" + id;
                if (brack) {
                    location.href = url;
                } else {
                    openHref(url, "查看/修改关联记录");
                }
            }

            function rowsSetData(type, list, ok) {
                var reParam = "tableName=" + type;
                var idList = [];
                $(list).each(function () {
                    reParam += "&tableIds=" + this.id;
                    idList.push(this.id);
                });
                //查询区域
                Project.ajax('/global/partition/record/finds', reParam).ajaxOK(function (record) {
                    $(record.data).each(function (i, r) {
                        $(list).each(function (j) {
                            if (r['pr']['tableId'] === this.id) {
                                var reg = r.reg, cy = reg.city;
                                list[j].reg = reg;
                                var name_ = "";
                                if (cy) name_ += cy['name'];
                                if (reg.region) name_ += "." + reg.region.name;
                                list[j].region = name_;
                            }
                        });
                    });
                    if (ok) ok(list);
                });

                //主字段
                Project.ajax("/table/display/" + type + "/view/fields", {displayPosition: "MAIN"}).ajaxOK(function (data) {
                    data = data.data;
                    var deletes = data.second;
                    for (var i = 0; i < deletes.length; i++) {
                        var d = deletes[i];
                        $("th[data-name=" + d + "]").remove();
                        $("td[data-name=" + d + "]").remove();
                    }
                });

                //关联字段
                ajaxMainRowsLink(idList, function (datas) {
                    for (var key in datas) {
                        var data = datas[key];
                        var rows = data.first;
                        var fs = data.second;

                        function getFsIntro(name) {
                            for (var i = 0; i < fs.length; i++) {
                                var fsData = fs[i];
                                if (fsData.name === name) return fsData.intro;
                            }
                            return "";
                        }

                        for (var i = 0; i < rows.length; i++) {
                            var row = rows[i];
                            var rowData = row.row;
                            var rowId = rowData.id;
                            var diaplayData = row.diaplay;
                            var htmlRow = "";
                            for (var j = 0; j < diaplayData.length; j++) {
                                var diaplayDataRow = diaplayData[j];
                                var diaplayDataRowName = diaplayDataRow.first;
                                var diaplayDataRowVal = diaplayDataRow.second;
                                if (diaplayDataRowVal === null) diaplayDataRowVal = "No";
                                var intro = getFsIntro(diaplayDataRowName);
                                htmlRow += "&nbsp;<a href='javascript:void(0)' title='" + intro + "'>" + diaplayDataRowVal + "</a>";
                            }
                            $("td[data-value='" + rowId + "'][data-type='" + key + "'] a").html(htmlRow);
                        }
                    }
                }, type);

            }

            //根据主键删除
            function deleteRows(type, ids, ok) {
                if (confirm("确定删除?"))
                    Project.ajax('/global/admin/' + type + '/delete/by/ids', ids).ajaxOK(function () {
                        if (ok) ok();
                        if ($("td").length < 1) pageAjax(1);
                    }, true);
            }

            //删除一行
            function deleteRow(type, id) {
                deleteRows(type, {ids: id}, function () {
                    $(":input[name=id][value=" + id + "]").parentSum(3).remove();
                });
            }


            //表格数据
            function pageTableAjax(pageNum, param, $tableSeaFm, type, $paging, $tb, success, run) {
                param = param || {};
                param = $.extend(true, param, $tableSeaFm.formSerialize());
                if (pageNum) pageNumPage = pageNum;
                param.pageNum = pageNumPage;
                param.pageSize = pageSize;
                param.apiTableType = type;

                $("input[class=sort_cb]").change(function () {
                    pageTableAjax(pageNum, param, $tableSeaFm, type, $paging, $tb, success, run);
                });
                //排序
                $("input[class=sort_cb]:visible").each(function () {
                    var _ = $(this);
                    param['sort[\'' + _.attr("name") + '\']'] = _.checked() + "";
                });

                var uri = param.apiUri || "/search/vague/sort/page";
                Project.ajax('/global/admin/' + type + uri, param).ajaxOK(function (pageData) {
                    var data = pageData.data;
                    data.run = run;
                    data.tableId = param.tableId;
                    $paging.html(template('paging-tp', data));


                    rowsSetData(type, data.list, function (list) {
                        data.list = list;
                        data.apiTableType = type;
                        $tb.html(template('page-td-tp', data));
                        if (success) success(data);
                    });
                }, null, null, function (data) {
                    if (data.code === "EMPTY") {
                        $tb.empty();
                        pageNumPage--;
                    }
                });
            }
        </script>
        <#nested>
    </@html.frame>
</#macro>