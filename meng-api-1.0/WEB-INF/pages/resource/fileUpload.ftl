<@html.business title="${title}">
<form>
    <label><input onchange="uploadFile(this)" type="file"></label>
    <input placeholder="搜索" onchange="ajaxByList(1)" name="keyword">
</form>
<div id="l_">

</div>
<script type="text/html" id="_l">
    {{each $data as it}}
    <div class="col-md-6">
        <div class="card">
            <div class="content">
                <div id="chartPreferences" class="ct-chart ct-perfect-fourth">
                    <img style="width: 100%;height: 100%" src="{{it.address.url}}">
                </div>
                <div class="footer">
                    <div class="chart-legend">
                        <i class="fa fa-circle text-info"></i><span>查看</span>
                        <i class="fa fa-circle text-info"></i><span data-clipboard-text="{{it.address.url}}"
                                                                    class="copy">复制地址</span>
                    </div>
                    <hr>
                    <div class="stats">
                        <i class="ti-timer"></i> {{it.name}}
                    </div>
                </div>
            </div>
        </div>
    </div>
    {{/each}}
</script>
<script>
    var pageNumFile = 1, type = bottomJo("GlobalResource");

    //文件修改
    function uploadFile(el) {
        var file = el.files[0];
        var fm = new FormData();
        fm.append("files", file);
        Project.ajaxUploadFilesV2(fm).ajaxOK(function (data) {
            data = data.data;
            var res = data[0], uri = res.uri;
            Project.ajax('/global/resource/check/file/type', {uri: uri}).ajaxOK(function (data) {
                var re = prompt("输入备注", file.name);
                re = re || file.name || uri;
                var param = {};
                param.fileType = data.data;
                param["address.uri"] = uri;
                param.name = re;
                param.apiTableType = type;
                Project.ajax('/global/admin/' + type + '/add/or/upt/by/id', param).ajaxOK(function () {
                }, true);
            });
        });
    }

    ajaxByList();

    function ajaxByList(page) {
        if (page) pageNumFile = page;
        var param = $("form").formSerialize();
        param.pageNum = (pageNumFile++).toString();
        param["sort['gmtDatetime']"] = true;
        Project.ajax('/global/admin/' + type + '/population/search', param).ajaxOK(function (data) {
            var ht = template('_l', data.data.list);
            if (page === 1) {
                $("#l_").html(ht);
            } else {
                $("#l_").append(ht);
            }
            new Clipboard('.copy');
        }, false, false, function () {
            pageNumFile--;
        });
    }

    $(window).scrollLast(function () {
        ajaxByList();
    });
</script>
</@html.business>