<#--noinspection FtlReferencesInspection-->
<@html.business title="${title}">
<!--suppress JSUnfilteredForInLoop -->
<style>
    .col-md-3 {
        float: none;
        display: inline-block;
        width: auto;
    }

    .class-open {
        overflow: auto;
        height: 100px;
    }

    .se_radio {
        width: 20px;
        display: inherit;
    }

    button {
        min-width: 10px !important;
    }

    hr {
        border-color: red;
    }
</style>
    <#include "public/var.ftl">
<script src="${pathView}/ckeditor/ckeditor.js"></script>
<link rel="stylesheet" href="${pathView}/ckeditor/samples/css/samples.css">
<link rel="stylesheet" href="${pathView}/ckeditor/samples/toolbarconfigurator/lib/codemirror/neo.css">

<div class="col-md-12">
    <div class="card">
        <div class="header">
            <h4 class="title">
                总分类选择
                <label onclick="$classes.autoClass('class-open')" class="btn btn-default">展开/收起</label>
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
            <h4 class="title">配置</h4>
        </div>
        <div class="content">
            <form id="upt_fm">
                <div class="row" id="con_">
                </div>
                <div class="text-center">
                    <button class="btn btn-info btn-fill btn-wd">修改</button>
                    <button type="reset" class="btn btn-info btn-fill btn-wd">清空</button>
                </div>
                <div class="clearfix"></div>
            </form>
        </div>
    </div>
</div>


<script type="text/html" id="pos-type-tp">
    {{each $data as it name}}
    <div data-key="{{it.explain}}" class="col-md-3">
        <label class="btn btn-default btn-block">{{it.explain}}
            <input name="configOpt" type="radio" value="{{name}}"/>
        </label>
    </div>
    {{/each}}
</script>

<script type="text/html" id="_con">
    {{if $data.bigType === "CITY_ID_LIST"}}
    {{each city() as it}}
    <div class="col-md-3">
        <label class="btn btn-default btn-block">{{it.name}}
            <input type="checkbox" name="cityId" value="{{it.code}}"/>
        </label>
    </div>
    {{/each}}
    {{else}}
    {{if typeIsNumber($data.type) }}
    <div class="col-md-5">
        <div class="form-group">
            <label>{{$data.intro || '请输入数字'}}</label>
            <input type="number" name="{{$data.name || '_v'}}" value="{{$data.data}}"
                   class="form-control border-input"
                   placeholder="0-36999999">
        </div>
    </div>
    {{else if $data.bigType === "RICH_TEXT"}}
    <div data-rich-text>
        {{#getOneConfig($data._name)}}
    </div>
    {{else if hasUrlRes($data.type,'UrlResImg')}}
    <div class="col-md-5">
        <div class="form-group">
            <label>{{$data.intro || '选择图片'}}</label>
            <input onchange="imgChange(this)" type="file" name="int"
                   class="form-control border-input">
            <img src="" data-res-img='{{getOneConfigLi($data)}}'/>
            <input type="hidden" value="{{getOneConfigLi($data)}}" name="{{$data.name || '_v'}}">
        </div>
    </div>
    {{else if typeIsString($data.type)}}
    <div class="col-md-5">
        <div class="form-group">
            <label>{{$data.intro || '请输入'}}</label>
            <input name="{{$data.name || '_v'}}" value="{{$data.data}}"
                   class="form-control border-input"
                   placeholder="">
        </div>
    </div>
    {{else if typeIsBoolean($data.type)}}
    <div class="col-md-5">
        <div class="form-group">
            <label>{{$data.intro || '请选择'}}</label>
            <label>是:
                <input type="radio" name="{{$data.name || '_v'}}" value="true"
                       class="form-control border-input">
            </label>
            <label>否:
                <input type="radio" name="{{$data.name || '_v'}}" value="false"
                       class="form-control border-input">
            </label>
        </div>
    </div>
    {{else if typeIsArray($data.type)}}
    {{if typeIsEnum($data.type)}}
    <table class="table table-striped">
        <thead>
        <tr>
            <th>内容</th>
            <th>是否启用</th>
            <th>移动排序</th>
        </tr>
        </thead>
        <tbody>
        {{each listEnumSort(getOneConfigLi($data),arraysToType($data.type)) as it i}}
        <tr>
            <td>{{it.explain}}</td>
            <td><label><input type="checkbox" name="_" value="{{i}}"></label></td>
            <td>
                <button type="button" onclick="moveUp(this)" class="btn btn-info btn-fill btn-wd">向上移动</button>
                <button type="button" onclick="moveDown(this)" class="btn btn-info btn-fill btn-wd">向下移动</button>
            </td>
        </tr>
        {{/each}}
        </tbody>
    </table>
    {{else if typeIsAny($data.type)}}
    {{each getOneConfigJson($data) as it}}
    <div data-ant-list>
        <div style="width: 100%" data-name="{{$data._name}}" data-list='{{$jsonToString it}}'
             data-any-type="{{getArrayToType($data.type)}}"></div>
        <button type="button" class="btn btn-info btn-fill btn-wd" onclick="$(this).parent().remove()">删除</button>
        <hr style="width: 100%;"/>
    </div>
    {{/each}}
    <button type="button" onclick="addOneLi(this)"
            style="display: {{getDisplay($data)}};" data-add class="btn btn-info btn-fill btn-wd">
        添加一列
    </button>
    {{else if typeIsString(arraysToType($data.type))}}
    {{each getOneConfigJson($data) as it}}
    <div>
        {{include '_con' {type:arraysToType($data.type),data:it} }}
        <hr style="width: 100%;"/>
        <button type="button" class="btn btn-info btn-fill btn-wd" onclick="$(this).parent().remove()">删除</button>
    </div>
    {{/each}}
    <hr style="width: 100%;"/>
    <button type="button" onclick="addOneLi(this)"
            style="display: {{getDisplay($data)}};" data-add class="btn btn-info btn-fill btn-wd">
        添加一列
    </button>
    {{/if}}
    {{else if typeIsEnum($data.type)}}
    {{each getEnumBigName($data.type) as it i}}
    <div class="col-md-5">
        <div class="form-group">
            <label>{{it.explain}}</label>
            <input type="radio" name="{{$data.name || '_v'}}" value="{{i}}"
                   class="form-control border-input"
                   placeholder="">
        </div>
    </div>
    {{/each}}
    {{else if typeObj($data.type)}}
    {{if $data.type.rawType === "java.util.Map"}}
    {{if mapParam1IsEnum($data)}}
    {{each mapParam1IsEnum($data) as it i}}
    <div class="col-md-5">
        <div class="form-group">
            <label>{{it.explain}}</label>
            <input type="hidden" name="_" value="{{i}}">
            {{if typeIsAny(getMapToType($data))}}
            <div data-name="{{$data._name}}" data-key="{{i}}"
                 data-any-type="{{getMapToType($data)}}"></div>
            {{else}}
            <div>
                {{include '_con' {type:getMapToType($data),data:getOneConfigMapVal($data._name,i)} }}
            </div>
            {{/if}}
        </div>
    </div>
    {{/each}}
    {{else}}
    {{each getOneConfigJson($data) as key value}}
    <div style="background-color: azure;border:2px solid red;float: left;">
        {{include '_con' {type:getMapToType($data),data:value,intro:getMapIntroKey($data._name),name:'_'} }}
        {{include '_con' {type:mapParam1Type($data),data:key,intro:getMapIntroValue($data._name)} }}
        <button type="button" class="btn btn-info btn-fill btn-wd" onclick="$(this).parent().remove()">删除</button>
    </div>
    {{/each}}
    <button type="button" onclick="addOneLi(this)"
            style="display: {{getDisplay($data)}};" data-add class="btn btn-info btn-fill btn-wd">
        添加一列
    </button>
    {{/if}}
    {{/if}}
    {{/if}}
    {{/if}}
</script>

<script>
    var $classes = $("#classes"), $c = $("#con_"), configValue, enums;
    Enum.clean();

    function moveUp(_a) {
        var _row = _a.parentNode.parentNode;
        //如果不是第一行，则与上一行交换顺序
        var _node = _row.previousSibling;
        while (_node && _node.nodeType !== 1) {
            _node = _node.previousSibling;
        }
        if (_node) {
            swapNode(_row, _node);
        }
    }

    function mapParam1Type($data) {
        return $data.type['actualTypeArguments'][0];
    }

    function mapParam1IsEnum($data) {
        return getEnumBigName(mapParam1Type($data));
    }

    template.helper("mapParam1Type", mapParam1Type);
    template.helper("mapParam1IsEnum", mapParam1IsEnum);

    function moveDown(_a) {
        var _row = _a.parentNode.parentNode;
        //如果不是最后一行，则与下一行交换顺序
        var _node = _row.nextSibling;
        while (_node && _node.nodeType !== 1) {
            _node = _node.nextSibling;
        }
        if (_node) {
            swapNode(_row, _node);
        }
    }

    function swapNode(node1, node2) {
        //获取父结点
        var _parent = node1.parentNode;
        //获取两个结点的相对位置
        var _t1 = node1.nextSibling;
        var _t2 = node2.nextSibling;
        //将node2插入到原来node1的位置
        if (_t1) _parent.insertBefore(node2, _t1);
        else _parent.appendChild(node2);
        //将node1插入到原来node2的位置
        if (_t2) _parent.insertBefore(node1, _t2);
        else _parent.appendChild(node1);
    }


    ajaxAllCity(function () {
        console.log("城市加载完毕");
    });
    getConfigValue();


    function typeIsArray(type) {
        if (typeof type === "object") {
            if (type["rawType"] === 'java.util.List') return true;
        }
        return type.toString().indexOf("[L") !== -1;
    }

    function typeIsBoolean(type) {
        return type === "boolean" || type === "java.lang.Boolean";
    }

    function typeIsString(type) {
        return type === 'java.lang.String';
    }

    function typeIsEnum(type) {
        type = type.toString();
        return /* type.indexOf("[L") ===-1 &&*/type.indexOf(".enums") !== -1;
    }

    function arraysToType(type) {
        return type.toString().substring("[L".length).replace(";", "");
    }

    function typeIsNumber(type) {
        return type === "int" || type === "java.lang.Float" || type === "float" || type === "java.lang.Integer";
    }

    function typeIsAny(type) {
        if (typeof type === "object") type = type["typeName"];
        return type.toString().indexOf("pojo.") !== -1;
    }

    function getArrayToType(data) {
        return data["actualTypeArguments"][0]["upperBounds"][0];
    }

    function listEnumSort(data, enumClass) {
        data = data || [];
        data = parseJSON(data);
        var all = getEnumBigName(enumClass);
        var news = {};
        data.forEach(function (t) {
            for (var key in all) {
                if (key === t) {
                    news[key] = all[key];
                    break;
                }
            }
        });
        for (var key in all) {
            if ($.inArray(key, data) !== -1) {
                news[key] = all[key];
            }
        }
        return news;
    }

    template.helper("typeIsBoolean", typeIsBoolean);
    template.helper("typeIsString", typeIsString);
    template.helper("getArrayToType", getArrayToType);
    template.helper("typeIsAny", typeIsAny);
    template.helper("typeIsNumber", typeIsNumber);
    template.helper("listEnumSort", listEnumSort);
    template.helper("arraysToType", arraysToType);
    template.helper("typeIsArray", typeIsArray);
    template.helper("typeIsEnum", typeIsEnum);


    Enum.dataAjaxGlobal(function (data) {
        enums = data;
    });

    function getMapToType($data) {
        return $data.type["actualTypeArguments"][1]["upperBounds"][0];
    }

    template.helper("getMapToType", getMapToType);

    function skipErr(ok) {
        try {
            if (ok) ok()
        } catch (e) {
            console.error(e);
        }
    }

    function hasUrlRes(name, last) {
        return name === bottomPo(last);
    }

    template.helper("typeObj", function (type) {
        return typeof type === "object"
    });

    template.helper("hasUrlRes", hasUrlRes);

    function getConfigValue() {
        Project.ajax('/config/select/all').ajaxOK(function (data) {
            configValue = data.data;
        });
    }

    function getEnumBigName(bigName) {
        if (bigName.indexOf(";") !== -1) {
            bigName = bigName.substring(0, bigName.length - 1);
        }
        bigName = bigName.split(".");
        return enums[bigName[bigName.length - 1]];
    }

    template.helper("getEnumBigName", getEnumBigName);

    function getOneConfigMapKeyVal(name) {
        return JSON.stringify(JSON.parse(getOneConfig(name)));
    }

    function getOneConfigMapVal(name, key) {
        return JSON.stringify(JSON.parse(getOneConfig(name))[key]);
    }

    function getOneConfigMapValAny(name, key, key2) {
        return JSON.stringify(JSON.parse(getOneConfig(name))[key][key2]);
    }

    template.helper("getOneConfigMapKeyVal", getOneConfigMapKeyVal);
    template.helper("getOneConfigMapValAny", getOneConfigMapValAny);
    template.helper("getOneConfigMapVal", getOneConfigMapVal);

    function getOneConfig(name) {
        var value = null;
        $(configValue).each(function () {
            if (this.name === name) {
                value = this.value;
                return true;
            }
        });
        return value;
    }

    function getOneConfigJson(name) {
        if (name.data) return name.data;
        return parseJSON(getOneConfig(name._name));
    }

    function getDisplay(data) {
        return data.data ? "none" : 'block';
    }

    function getOneConfigLi(it) {
        if (it.data) return it.data;
        return getOneConfig(it._name);
    }

    template.helper("getDisplay", getDisplay);
    template.helper("getOneConfigLi", getOneConfigLi);
    template.helper("getOneConfigJson", getOneConfigJson);
    template.helper("getOneConfig", getOneConfig);

    function imgChange(el) {
        var $img = $(el).next(), $v = $img.next();
        var file = el.files[0], fm = new FormData(), _ = $(el);
        fm.append("files", file);
        Project.ajaxUploadFilesV2(fm).ajaxOK(function (data) {
            data = data.data[0];
            $v.val(JSON.stringify({uri: data.uri}));
            $img.attrSrc(data.url);
        });
    }

    function loadTemp() {
        function load($_) {
            return $_.attr("_compile");
        }

        $("div[data-rich-text]").each(function () {
            var $_ = $(this);
            if (load($_)) return true;
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
        $("img[data-res-img]").each(function () {
            var $_ = $(this);
            if (load($_)) return true;
            skipErr(function () {
                $_.attr("_compile", true);
                var altVal = JSON.parse($_.attr("data-res-img"));
                Project.ajax('/file/upload/v2/res/fill/one', altVal).ajaxOK(function (data) {
                    $_.attrSrc(data.data.url);
                });
            });
        });

        $("div[data-any-type]").each(function () {
            var $_ = $(this);
            if (load($_)) return true;
            skipErr(function () {
                $_.attr("_compile", true);
                var altVal = $_.attr("data-any-type");
                Project.ajax('/metadata/any/attr', {javaClass: altVal}).ajaxOK(function (data) {
                    $(data.data).each(function () {
                        var listOne = $_.attr("data-list");
                        if (listOne || listOne === "") {
                            this.data = JSON.parse(listOne)[this.name];
                        } else {
                            this.data = getOneConfigMapValAny($_.attr("data-name"), $_.attr("data-key"), this.name);
                        }
                        $_.append(template('_con', this));
                    });
                    loadTemp();
                });
            });
        });
    }

    var addOneLi, editor;

    Enum.obj("ConfigOpt", function (configs) {
        $classes.html(template('pos-type-tp', configs));

        function getConfigVal(name) {
            return configs[name];
        }

        function getMapIntro(name) {
            var ex = Enum.explain(getConfigVal(name));
            ex = ex.substr(ex.indexOf("["));
            ex = ex.substring(1, ex.indexOf("]"));
            return ex.split(":");
        }

        function getMapIntroKey(name) {
            return getMapIntro(name)[0];
        }

        function getMapIntroValue(name) {
            return getMapIntro(name)[1];
        }

        template.helper("getMapIntroKey", getMapIntroKey);
        template.helper("getMapIntro", getMapIntro);
        template.helper("getMapIntroValue", getMapIntroValue);

        $classes.find("input[name=configOpt]").change(function () {
            var name = $(this).val(), opt = getConfigVal(name);
            opt._name = name;
            $c.html(template('_con', opt));

            addOneLi = function (el) {
                var $add = $(el);
                opt.data = [{}];
                $add.before(template('_con', opt));
                loadTemp();
            };

            loadTemp();

            try {
                var altVal = getOneConfig(name);
                if (altVal) {
                    if (opt["bigType"] === "CITY_ID_LIST") {
                        $(JSON.parse(altVal)).each(function () {
                            $("#con_").find("input[value='" + this + "']").prop("checked", true);
                        });
                    } else if (!opt["bigType"]) {
                        var _ty = opt["type"];
                        if (typeIsNumber(_ty)) {
                            $c.find("input").val(altVal);
                        } else if (hasUrlRes(_ty, "UrlResImg")) {
                            /*var $img = $c.find("img");
                            skipErr(function () {
                                altVal = JSON.parse(altVal);
                                Project.ajax('/file/upload/v2/res/fill/one', altVal).ajaxOK(function (data) {
                                    $img.attrSrc(data.data.url);
                                });
                            });
                            $c.find("input").change(function () {
                                var file = this.files[0], fm = new FormData(), _ = $(this);
                                fm.append("files", file);
                                Project.ajaxUploadFilesV2(fm).ajaxOK(function (data) {
                                    data = data.data[0];
                                    $img.attr('uri', data.uri);
                                    $img.attrSrc(data.url);
                                });
                            });*/
                        } else if (typeIsArray(_ty)) {
                            if (typeIsEnum(_ty)) {
                                $(JSON.parse(altVal)).each(function () {
                                    $c.find("input[value='" + this + "']").checked(1);
                                });
                            } else if (typeIsAny(_ty)) {

                            } else if (typeIsString(_ty)) {

                            }
                        } else if (typeIsBoolean(_ty)) {
                            $c.find("input[value='" + altVal + "']").checked(1);
                        }
                        else if (typeof _ty === "object") {
                            if (_ty["rawType"] === "java.util.Map") {
                                var args = _ty["actualTypeArguments"];
                                for (var key in getEnumBigName(args[0])) {

                                }
                            }
                        } else if (typeIsEnum(_ty)) {
                            $c.find("input[value='" + altVal + "']").checked(1);
                        }
                    }
                }
            } catch (e) {
                alert("填充数据失败:" + e);
            }

            var $fm = $("#upt_fm");
            $fm.unbind("submit");
            $fm.html5Validate(function () {
                var value;
                if (opt["bigType"] === "CITY_ID_LIST") {
                    value = [];
                    $c.find("input:checked").each(function () {
                        value.push($(this).val());
                    });
                    value = JSON.stringify(value);
                } else if (opt["bigType"] === "RICH_TEXT") {
                    value = editor.getData();
                } else if (!opt["bigType"]) {
                    if (typeIsNumber(opt["type"])) {
                        value = $c.find("input").val();
                    } else if (hasUrlRes(opt.type, "UrlResImg")) {
                        value = parseJSON($c.find("input[name=_v]").val());
                        value = JSON.stringify(value);
                    } else if (typeIsBoolean(_ty)) {
                        value = parseJSON($c.find("input[name=_v]:checked").val());
                    }
                    else if (typeIsArray(_ty)) {
                        if (typeIsEnum(_ty)) {
                            value = [];
                            $c.find("input:checked").each(function () {
                                value.push($(this).val());
                            });
                            value = JSON.stringify(value);
                        } else if (typeIsAny(_ty)) {
                            value = [];
                            $c.find("*[data-ant-list]").each(function () {
                                value.push($(this).createFormSerialize());
                            });
                            value = JSON.stringify(value);
                        } else if (typeIsString(arraysToType(_ty))) {
                            value = [];
                            $c.find("input").each(function () {
                                var _val = $(this).val();
                                if (_val && _val !== "") {
                                    value.push(_val);
                                }
                            });
                            value = JSON.stringify(value);
                        }
                    } else if (typeof _ty === "object") {
                        if (_ty["rawType"] === "java.util.Map") {
                            value = {};
                            $c.find("input[name=_]").each(function () {
                                var $v = $(this), $v_in = $v.parentSum(3).find("input[name=_v]");
                                if ($v_in.length > 0) {
                                    var _v = $v_in.val();
                                    if (_v && _v !== "") {
                                        value[$v.val()] = parseJSON(_v);
                                    }
                                } else {
                                    value[$v.val()] = $v.parent().createFormSerialize();
                                }
                            });
                            value = JSON.stringify(value);
                        }
                    } else if (typeIsEnum(_ty)) {
                        value = $c.find("input:checked").val();
                    }
                }

                update(name, value);
                return false;
            });
        });
    });

    function update(name, value) {
        Project.ajax('/config/update', {name: name, value: value}).ajaxOK(function () {
            getConfigValue();
        }, true);
    }

    function ajaxAllCity(ok) {
        Project.ajax('/region/select/region/city/list').ajaxOK(function (data) {
            template.helper("city", function () {
                return data.data;
            });
            if (ok) ok();
        });
    }
</script>
</@html.business>