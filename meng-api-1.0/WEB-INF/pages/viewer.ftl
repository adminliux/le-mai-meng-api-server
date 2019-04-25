<#--noinspection FtlReferencesInspection-->
<@html.business title="${title}">
<style>
    img {
        max-width: 100%;
    }
</style>
<body>
</body>
<script>
    var images = cm.getParamJson("images"),
            viewSrc = cm.getParam("viewSrc");

    var $p = $("<div></div>");
    $(images).each(function () {
        $p.append("<img onclick='view()' src='" + this + "'/>")
    });

    $(document.body).html($p);

    function view() {
        $p.viewer();
    }

    if (viewSrc) {
        $("img[src='" + viewSrc + "']").click();
    } else {
        view();
    }
</script>
</@html.business>