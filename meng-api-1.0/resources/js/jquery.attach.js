/*
*@author 271151388@qq.com
*个人主页 http://www.imwinlion.com/
*专门为技术人员创业提供从工具到思维层面的支持的网站
*基本使用 https://my.oschina.net/u/2558718/blog/743780
*/
!~(function(w,d,$){
	var _attachsvr={};
	var defaultoptions={
			debug:false,
			onCheck:function(file){return true;},
			onComplete:function(json){},
			onError:function(r){},
			onProgress:function(xhr){},
			ctxdata:{},
			script:"",
			uploadkey:"files",
			filetype:[".jpg",".png",".jpeg",".zip",".mp3",".mp4"]
	}
	_attachsvr.doupload=function(file,optios){
		 var options = $.extend(defaultoptions,optios);
		 var data = new FormData();
		 	for(var i in options.ctxdata){
		 		data.append(i,options.ctxdata[i]);
		 	}
		    data.append(options["uploadkey"], file[0].files[0]);
		    var surport = false;
		    var filename =   file[0].files[0].name;
		    for(var i in options.filetype){
		    	
		    	if(filename.indexOf(options.filetype[i])>-1){
		    		surport = true;
		    	}
		    }
		    if(surport==false){
		    	options.onError({"result":"notsurport","msg":"这个文件类型不支持","data":{}})
		    	return false;
		    }
			if(!options.onCheck(file)){
				return false;
			}
		    $.ajax({
		        url: options.script,
		        type: 'POST',
		        data: data,
		        xhr: function() {
		         var xhr = $.ajaxSettings.xhr();
		         xhr.upload.addEventListener('progress', function(xhr){
		        	 options.onProgress(xhr);
		         }, false);
		         return xhr;//一定要返回，不然jQ没有XHR对象用了
		        },
		        processData: false,
		        contentType: false,
				error:function(XMLHttpRequest, textStatus, errorThrown){
					options.onError(
						{
							"result":"errornet",
							"msg":"网络通讯错误",
							"data":{"XMLHttpRequest":XMLHttpRequest,"textStatus":textStatus,"errorThrown":errorThrown}
						}
					);
				}
		    }).done(function(ret){
		    	options.onComplete({"result":"success","msg":"文件已经上传成功","data":ret});
		    });
	};
	w.attachsvr = _attachsvr;
	 $.fn.extend({
	        //插件名称 - paddingList
		 		attachsvr: function (options) {
	            var defaults = defaultoptions;
	            var options = $.extend(defaults, options);
	            return this.each(function () {
	                var o = options;
	                var obj = $(this);
	            $(this).unbind().change(function(){
                	_attachsvr.doupload(obj,o);});
               });
	            
	        }
	    });
})(window,document,jQuery)