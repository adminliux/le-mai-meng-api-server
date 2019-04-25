<#--noinspection FtlReferencesInspection,FtlImportCallInspection,JSUnusedLocalSymbols-->
<@html.business title="${title}">
    <!--suppress JSUnfilteredForInLoop -->
    <div class="col-md-12" style="display: none">
        <div class="card">
            <div class="header">
                <h4 class="title">
                    总分类选择
                    <label onclick="$classes.autoClass('class-open')"
                           class="btn btn-default">展开/收起</label>
                    <label>跳转打开:
                        <input type="checkbox" id="_bkOpen">
                    </label>
                    <input placeholder="搜索" oninput="keySearch($(this))">
                </h4>
            </div>
            <div class="content table-responsive table-full-width class-open" id="classes">
            </div>
        </div>
    </div>


    <div class="col-md-12">
        <div class="card">
            <div class="header">
                <h4 class="title">表格查询条件</h4>
            </div>
            <div class="content">
                <form>
                    <div class="row" id="tableSearch_">
                    </div>
                    <div class="text-center">
                        <button class="btn btn-info btn-fill btn-wd">查询</button>
                        <button class="btn btn-info btn-fill btn-wd">清空</button>
                    </div>
                    <div class="clearfix"></div>
                </form>
            </div>
        </div>
    </div>

    <div class="col-md-12">
        <div class="card">
            <div class="header">
                <h4 class="title">表格内容</h4>
                <p class="category">
                    <button onclick="deleteRowCheckbox()" class="btn btn-info btn-fill btn-wd">删除</button>
                    <button onclick="deleteAll()" class="btn btn-info btn-fill btn-wd">清空所有</button>
                    <button onclick="addRow()" class="btn btn-info btn-fill btn-wd">添加一条</button>
                    <button onclick="exportExcel()" class="btn btn-info btn-fill btn-wd">导出</button>
                    <button onclick="exportExcelPage()" class="btn btn-info btn-fill btn-wd">导出本页</button>
                    <button onclick="exportExcelAll()" class="btn btn-info btn-fill btn-wd">导出全部</button>
                    <button onclick="setRegion()" class="btn btn-info btn-fill btn-wd">分配市区</button>
                    <button onclick="citySetAll()" class="btn btn-info btn-fill btn-wd">分配市区(全部记录)</button>
                </p>
            </div>
            <div class="content table-responsive table-full-width" id="_table">
            </div>
            <div id="paging"></div>
        </div>
    </div>




    <!--suppress ALL -->
    <div id="view"></div>
    <script type="text/html" id="view-tp">
        <section>
            <form>
                <h3>查询条件</h3>
                {{each fields as it}}
                <label>{{it.intro}}:
                    <input name="{{it.name}}">
                </label>
                {{/each}}
                {{each condBetween as it}}
                <label>{{it.intro}}:
                    <input name="{{it.name}}">至
                    <input name="{{it.name}}">
                </label>
                {{/each}}
                <button>查询</button>
            </form>
        </section>
        <section>
            <h3>查询列表</h3>
            <div>
                <button onclick="deleteRowCheckbox()">删除</button>
                <button onclick="deleteAll()">清空所有</button>
            </div>
            <div>
                <table id="table-page" style="width: 100%" border="1" cellspacing="0">
                    <thead>
                    <tr>
                        <th>多选</th>
                        {{each fields as it}}
                        <th>{{it.intro}}</th>
                        {{/each}}
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
                <div id="paging">
                </div>
            </div>
        </section>
    </script>
    <script type="text/html" id="pos-type-tp">
        {{each $data as it name}}
        <div data-key="{{it}}" class="col-md-3">
            <label class="btn btn-default btn-block">{{it}}
                <input name=type type="radio" value="{{name}}"/>
            </label>
        </div>
        {{/each}}
    </script>

    <script type="text/html" id="_select_city">
        <form>
            <input onchange="selectCityName(this)" placeholder="输入关键字搜索">
            <label>城市:
                <select onchange="cityCodeChange(this)" name="cityId" required>
                    <optgroup label="默认">
                        <option value="">请选择城市</option>
                    </optgroup>
                    <optgroup data-city label="结果">
                        {{each $data as it}}
                        <option value="{{it.code}}">{{it.name}}</option>
                        {{/each}}
                    </optgroup>
                </select>
            </label>
            <label>区域:
                <select name="regionId">
                    <optgroup label="默认">
                        <option value="">不选择区域</option>
                    </optgroup>
                    <optgroup data-reg label="城市列表">
                    </optgroup>
                </select>
            </label>
        </form>
    </script>

    <script>
        var type = cm.getParam("type"), $tbPage, rows, $tableSea = $("#tableSearch_"), $tableSeaFm = $tableSea.parent(),
            $classes = $("#classes"), $_table = $("#_table"), _select_p;

        //选择城市级联区域
        function cityCodeChange(el) {
            var code = $(el).val(), $reg = $("optgroup[data-reg]");
            if (code !== "") {
                Project.ajax("/region/query/by/city", {cityCode: code}).ajaxOK(function (data) {
                    $(data.data).each(function () {
                        $reg.append("<option value='" + this["code"] + "'>" + this["name"] + "</option>");
                    });
                });
            } else {
                $reg.empty();
            }
        }

        //选择城市名称
        function selectCityName(el) {
            var $city = $("optgroup[data-city]");
            Project.ajaxCityQueryByName_($(el).val()).ajaxOK(function (data) {
                $city.empty();
                $(data.data).each(function () {
                    $city.append("<option value='" + this["code"] + "'>" + this["name"] + "</option>");
                });
            });
        }

        //添加一行
        function addRow() {
            bkOpenByType(type);
        }

        function citySetAll() {
            setRegion(undefined, undefined, true);
        }


        //导出EXCEL
        function exportExcel() {
            var ids = getCheckIdParam("id");
            if (ids) location.href = Project.globalAdminUrl(type, '/export/excel/by/ids') + ids;
        }

        //导出EXCEL本页
        function exportExcelPage() {
            var ids = getCheckIdParam("id", true);
            if (ids) location.href = Project.globalAdminUrl(type, '/export/excel/by/ids') + ids;
        }


        Project.ajaxCityQueryByName_().ajaxOK(function (data) {
            _select_p = template('_select_city', data.data);
        });

        //导出EXCEL本页
        function exportExcelAll() {
            location.href = Project.globalAdminUrl(type, '/export/excel/all');
        }

        var enums;
        Enum.clean();
        Enum.dataAjaxGlobal(function (data) {
            enums = data;
            template.helper("enums", function () {
                return data;
            });
            template.helper("enumGenderOption", function (enumName) {
                enumName = parseSimEnum(enumName);
                var temp = '';
                var tag = data[enumName];
                for (var key in tag) {
                    temp += "<option value='" + key + "'>" + tag[key].explain + "</option>"
                }
                return temp;
            });
        });

        //获取选中ID
        function getCheckId(isAll) {
            isAll = isAll || false;
            var checked = ":checked";
            if (isAll) checked = "";
            var param = [];
            var $checked = $tbPage.find(":input[name=id]" + checked + ":not(.sort_cb)");
            if ($checked.length < 1)
                alert("至少选中一行");

            $checked.each(function () {
                param.push($(this).val());
            });
            return param;
        }

        //获取选中ID参数拼接
        function getCheckIdParam(name, isAll) {
            name = name || "ids";
            var params = "";
            $(getCheckId(isAll)).each(function () {
                params += "&" + name + "=" + this;
            });
            return params === "" ? null : params;
        }

        //删除选中行
        function deleteRowCheckbox() {
            var $checked = $(":input[name=id]:checked");
            var param = getCheckIdParam();
            if (param) {
                deleteRows(type, param, function () {
                    $checked.parentSum(2).remove();
                });
            }
        }

        //删除所有
        function deleteAll() {
            if (confirm("确定删除?"))
                Project.ajax('/global/admin/' + type + '/delete/all').ajaxOK(function () {
                    pageAjax(1);
                }, true);
        }


        function tableSearchView(type) {
            tableView(type, $_table, function (data) {
                calculatedFrom($tableSea, data, function () {
                    $tableSeaFm.unbind("submit");
                    $tableSeaFm.html5Validate(function () {
                        pageAjax(1);
                        return false;
                    });
                }, true);
                $tbPage = $_table.find("table");
                $(":input[name=ac]").change(function () {
                    $tbPage.find("input[name=id]").prop("checked", $(this).checked());
                });
                pageAjax(1);
            });
        }


        function loadByType(type) {
            tb_fun = {};
            pageNumPage = 0;
            tableSearchView(type);
        }

        //所有实体类
        Project.ajax("/global/admin/domain/all/classes").ajaxOK(function (data) {
            var classes = data.data;
            $classes.html(template('pos-type-tp', classes));

            if (type && type !== "") {
                loadByType(type);
                $("input[name=type][value='" + type + "']").checked(1);
            }
            $(":input[name=type]").change(function () {
                type = $(this).val();
                loadByType(type);
            });
        });


        //设置分类
        function setType() {
            type = $(":input[name=type]").val();
        }

        /**
         * 获取字段值
         * @param li 数据对象
         * @returns {*} 表格数据
         */
        function parseTableRow(li) {
            var html = '';
            rows.fields.forEach(function (t) {
                html += '<td>' + getRowValue(t.name, li) + '</td>';
            });
            return html;
        }


        //表格数据
        function pageAjax(pageNum, param) {
            param = param || {};
            param.tableId = $_table.attr("id");
            param = $.extend({}, window.rTexts, param);
            pageTableAjax(pageNum, param, $tableSeaFm, type, $("#paging"),
                $tbPage.find("tbody[data-list]"), null, "pageAjax");
        }
    </script>
</@html.business>