<#--noinspection ALL-->
<#macro businessV2 title>
<#--noinspection FtlImportCallInspection,FtlReferencesInspection-->
    <@frame.frameV2 title="${title}">
        <#nested>
        <!-- 全局js -->
    <#--noinspection FtlReferencesInspection-->
        <script src="${pathViewHAdmin}/js/bootstrap.min.js?v=3.3.6"></script>
    <#--noinspection FtlReferencesInspection-->
        <script src="${pathViewHAdmin}/js/plugins/jeditable/jquery.jeditable.js"></script>
        <!-- Data Tables -->
    <#--noinspection FtlReferencesInspection-->
        <script src="${pathViewHAdmin}/js/plugins/dataTables/jquery.dataTables.js"></script>
    <#--noinspection FtlReferencesInspection-->
        <script src="${pathViewHAdmin}/js/plugins/dataTables/dataTables.bootstrap.js"></script>
        <!-- 自定义js -->
    <#--noinspection FtlReferencesInspection-->
        <script src="${pathViewHAdmin}/js/content.js?v=1.0.0"></script>

        <!-- 时间 -->
    <#--noinspection FtlReferencesInspection-->
        <link rel="stylesheet" type="text/css" href="${pathView}/lib/Hui-iconfont/1.0.7/iconfont.css"/>
    <#--noinspection FtlReferencesInspection-->
        <link rel="stylesheet" type="text/css" href="${pathView}/lib/icheck/icheck.css" />
    <#--noinspection FtlReferencesInspection-->
        <script type="text/javascript" src="${pathView}/lib/layer/2.1/layer.js"></script>
    <#--noinspection FtlReferencesInspection-->
        <script type="text/javascript" src="${pathView}/lib/My97DatePicker/WdatePicker.js"></script>
    <#--noinspection FtlReferencesInspection-->
        <script type="text/javascript" src="${pathView}/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>

    </@frame.frameV2>
</#macro>