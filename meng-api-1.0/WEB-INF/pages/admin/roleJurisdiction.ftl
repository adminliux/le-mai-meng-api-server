<@html.business title="${title}">
<form>
    <label>角色:
        <select required id="role">
            <option value="">请选择</option>
        </select>
    </label>
    <label>全选/反选:
        <input type="checkbox" id="allCheck">
    </label>
    <button type="submit">修改</button>
</form>
<div style="background-color: #40ffa6" id="list">
</div>
<script type="text/html" id="_list">
    {{each $data as it}}
    <div style="float: left;border:1px solid red;">
        <span><input name="checkMenu" type="checkbox" placeholder="全选">{{it.introduce}}</span>
        <ul>
            {{each it.urlDescribes as ju}}
            <li><input name="ju" value="{{ju.id}}" type="checkbox" placeholder="单选">{{ju.introduce}}</li>
            {{/each}}
        </ul>
    </div>
    {{/each}}
</script>
<script>
    var $role = $("#role");
    Project.ajax("/role/list").ajaxOK(function (data) {
        $(data.data).each(function () {
            $role.append("<option value='" + this.id + "'>" + this.name + "</option>");
        });
        $role.change(function () {
            $("input[name=ju]:checked").checked(0);
            var roleId = $(this).val();
            if (roleId) {
                Project.ajax('/authentication/select/by/role/id',
                        {roleId: roleId}).ajaxOK(function (data) {
                    $(data.data).each(function () {
                        $("input[name=ju][value='" + this['jurisdictionId'] + "']").checked(1);
                    });
                });
            }
        });
    });
    Project.ajax('/jurisdiction/select/url').ajaxOK(function (data) {
        $("#list").html(template('_list', data.data || []));
        $("input[name=checkMenu]").change(function () {
            $(this).parentSum(2).find("input").checked($(this).checked() ? 1 : 0);
        });
    });

    $("form").html5Validate(function () {
        var jus = $("input[name=ju]:checked");
        var roleId = $role.val();
        var param = {};
        jus.each(function (i) {
            param["authentications[" + i + "].roleId"] = roleId;
            param["authentications[" + i + "].jurisdictionId"] = $(this).val();
        });

        Project.ajax('/authentication/update', param).ajaxOK(function () {
        }, true);
        return false;
    });

    $("#allCheck").change(function () {
        $("input[type=checkbox]").checked($(this).checked() ? 1 : 0);
    });
</script>
</@html.business>