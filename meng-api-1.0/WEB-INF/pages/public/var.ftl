<#--noinspection JSUnusedLocalSymbols,JSUnusedAssignment-->
<#--noinspection FtlReferencesInspection-->
<#assign path="${request.getContextPath()}">
<#--noinspection FtlReferencesInspection-->
<#assign pathView="${path}${config.resourcesPath}">
<#assign pathPage="${path}/page">
<#--noinspection FtlReferencesInspection-->
<#assign apiHost="${config.apiHost}">
<#assign pathViewHAdmin="${pathView}/hAdmin">
<!-- js -->
<script>
    <#--noinspection FtlReferencesInspection-->
    var path = "${path}", pathView = "${pathView}", apiHost = "${config.apiHost}", pathPage = path + "/page";
    window.wl = window.alert;
    window.source = "ADMIN";
    //apiHost = "http://localhost:8080/good_parents_war_exploded";
</script>