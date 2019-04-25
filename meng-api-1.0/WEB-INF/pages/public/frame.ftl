<#--noinspection ALL-->
<#macro frame title>
    <!DOCTYPE html>
    <html lang="zh-cn">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
        <title>商会-ADMIN</title>
        <#include "public/menuVal.ftl">
        <#--noinspection FtlReferencesInspection-->
        <link rel='Shortcut Icon' type='image/x-icon' href='${pathView}/img/windows.ico'>
        <#--noinspection FtlReferencesInspection-->
        <link href="${pathView}/css/animate.css" rel="stylesheet" type="text/css">
        <#--noinspection FtlReferencesInspection-->
        <script type="text/javascript" src="${pathView}/component/layer-v3.0.3/layer/layer.js"></script>
        <#--noinspection FtlReferencesInspection-->
        <link rel="stylesheet" href="${pathView}/component/font-awesome-4.7.0/css/font-awesome.min.css" type="text/css">
        <#--noinspection FtlReferencesInspection-->
        <link rel="stylesheet" href="${pathView}/css/viewer.min.css" type="text/css">
        <#--noinspection FtlReferencesInspection-->
        <link href="${pathView}/css/default.css" rel="stylesheet" type="text/css">
        <#--noinspection FtlReferencesInspection-->
        <script type="text/javascript" src="${pathView}/js/win10.js"></script>
        <#--noinspection FtlReferencesInspection-->
        <script src="${pathView}/laydate/laydate.js"></script>
    </head>
    <body>
    <#nested>
    </body>
    </html>
</#macro>
<#include "public/menu.ftl">
<#include "public/business.ftl">
