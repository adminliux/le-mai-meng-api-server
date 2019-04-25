<#--noinspection ALL-->
<#macro frameV2 title>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <title>到乐租车-ADMIN</title>
    <#include "public/menuVal.ftl">
    <!--[if lt IE 9]>
    <meta http-equiv="refresh" content="0;ie.html"/>
    <![endif]-->
    <#--noinspection FtlReferencesInspection-->
    <link href="${pathViewHAdmin}/css/bootstrap.min.css?v=3.3.6" rel="stylesheet" type="text/css">
    <#--noinspection FtlReferencesInspection-->
    <link href="${pathViewHAdmin}/css/font-awesome.css?v=4.4.0" rel="stylesheet" type="text/css">
    <#--noinspection FtlReferencesInspection-->
    <link href="${pathViewHAdmin}/css/font-awesome.min.css?v=4.4.0" rel="stylesheet" type="text/css">
    <!-- Data Tables -->
    <#--noinspection FtlReferencesInspection-->
    <link href="${pathViewHAdmin}/css/plugins/dataTables/dataTables.bootstrap.css" rel="stylesheet" type="text/css">
    <#--noinspection FtlReferencesInspection-->
    <link href="${pathViewHAdmin}/css/animate.css" rel="stylesheet" type="text/css">
    <#--noinspection FtlReferencesInspection-->
    <link href="${pathViewHAdmin}/css/style.css?v=4.1.0" rel="stylesheet" type="text/css">
</head>
<body>
    <#nested>
</body>
</html>
</#macro>
<#include "public/menuV2.ftl">
<#include "public/businessV2.ftl">