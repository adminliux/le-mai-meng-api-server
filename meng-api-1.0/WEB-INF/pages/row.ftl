<#--noinspection ALL-->
<@html.business title="${title}">
<div class="col-md-12">
    <div class="card">
        <div class="header">
            <h4 class="title">详情</h4>
        </div>
        <div class="content">
            <form id="_f">
                <div class="row" id="tableSearch">
                </div>
                <div class="text-center">
                    <button type="button" onclick="submitUri('/edit/no/null',true)"
                            class="btn btn-info btn-fill btn-wd">
                        修改有值
                    </button>
                    <button type="submit" onclick="submitUri('/add/or/upt/by/id')" class="btn btn-info btn-fill btn-wd">
                        提交
                    </button>
                    <button type="reset" class="btn btn-info btn-fill btn-wd">清空</button>
                </div>
                <div class="clearfix"></div>
            </form>
        </div>
    </div>
</div>

<script>
    var enums, $_f = $("#_f"), subUri;
    Enum.clean();

    function submitUri(uri, sub) {
        subUri = uri;
        if (sub) update(subUri);
    }

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
            <#--noinspection JSUnfilteredForInLoop-->
                temp += "<option value='" + key + "'>" + tag[key].explain + "</option>"
            }
            return temp;
        });
    });


    function dataParse(types, data) {
        $(types).each(function () {
            var v = data[this.name];
            if (this.type === "java.util.Date") {
                if (!cm.stringIsEmpty(v)) {
                    data[this.name] = cm.timestampFormatYMDHMS(v);
                }
            } else if (this['bigType'] === "MD5") {
                data[this.name] = '';
            } else if (this['bigType'] === "LIST") {
                if (this.type.indexOf("Img") !== -1) {
                    var imgs = "";
                    $(v).each(function () {
                        imgs += "<img onclick=\"openImg(this)\" src='" + this.url + "' width='40'/>";
                    });
                    var vs = data.isV || [];
                    vs.push(this.name);

                    data.isV = vs;
                    data[this.name] = imgs;
                }
            }
        });
    }

    var id = cm.getParam("id"), type = cm.getParam("type");

    function update(subUri) {
        var fd = $_f.formSerialize();
        fd.apiTableType = type;
        fd = $.extend({}, window.rTexts, fd);
        Project.ajax('/global/admin/' + type + subUri, fd).ajaxOK(function () {
        }, true);
    }

    var rowData;
    tableViewAttribute(type, function (data) {
        calculatedFrom($("#tableSearch"), data, function () {
            $_f.unbind("submit");
            $_f.html5Validate(function () {
                update(subUri);
                return false;
            });

            if (id && id !== "") {
                Project.ajax('/global/admin/' + type + '/select/by/id', {id: id}).ajaxOK(function (row) {
                    row = row.data;
                    rowData = row;
                    dataParse(data, row);
                    $(row.isV).each(function () {
                        $("*[data-name-fd=" + this + "]").html(row[this]);
                    });

                    $_f.formAssign(row);
                    $_f.assignment(row);
                });
            }
        });
    });
</script>
</@html.business>