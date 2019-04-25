UE.registerUI('135editor',function(editor,uiName){
    var dialog = new UE.ui.Dialog({
        iframeUrl: editor.options.UEDITOR_HOME_URL+'dialogs/135editor/135EditorDialogPage.html',
        cssRules:"width:"+ parseInt(document.body.clientWidth*0.9) +"px;height:"+(window.innerHeight -50)+"px;",
        editor:editor,
        name:uiName,
        title:"135缂栬緫鍣�"
    });
    dialog.fullscreen = false;
    dialog.draggable = false;
    var btn = new UE.ui.Button({
        name:'btn-dialog-' + uiName,
        className:'edui-for-135editor',
        title:'135缂栬緫鍣�',
        onclick:function () {
            dialog.render();
            dialog.open();
        }
    });
    return btn;
},undefined);
// 淇敼鏈€鍚庣殑undefined鍙傛暟涓烘暟瀛楀簭鍙凤紝姣斿5锛屽彲璋冩暣135缂栬緫鍣ㄦ寜閽殑椤哄簭銆傞粯璁ゅ嚭鐜板湪鏈€鍚庨潰