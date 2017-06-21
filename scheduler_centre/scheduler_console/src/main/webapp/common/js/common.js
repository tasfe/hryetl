//新增扩展 字符串 方法 replaceAll
String.prototype.replaceAll  = function(s1,s2){   
	return this.replace(new RegExp(s1,"gm"),s2);   
};

//格式化字符串 "第一个{0} {1}!,第二个{0} {1}".format("hello","world");
String.prototype.format = function(){
    var pattern = /\{\d+\}/g;
    var args = arguments;
    return this.replace(pattern, function(capture){ return args[capture.match(/\d+/)]; });
};

// 将from 表单序列号为 json 对象
$.fn.serializeObject = function(){
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
        if (o[this.name]) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};

$.importJs = function(uri){
	var jsFile = '<script type="text/javascript" src="'+uri+'"><\/script>';
	document.write(jsFile);
};

// 封装的 json 请求
$.requestJson = function(uri,callbackFun,param){
	param = param ? param :{};
	$.post(
		uri,
		param,
		function(data, textStatus, jqXHR){
			// alert("textStatus=" + textStatus);
			if($.isFunction(callbackFun)){
				callbackFun(data, textStatus, jqXHR);
			}
		},
		"json"
	);
};

// 分页跳转
function gotoPage(formName,page){
	if (!page)
		return;
	var form = $('form[name="'+formName+'"]');
	//var perPage = $('#perPage').val();
	form.append('<input type="hidden" name="page" value="'+page+'" />');
	form.submit();
};

// 分页跳转
function gotoPageIn(formName,inputId,maxPage){
	var inputPage = $('#'+inputId).val();
	var re = /^[0-9]*[1-9][0-9]*$/;
	if (!re.test(inputPage)) {
		$('#'+inputId).attr('value', '');
		return;
	}
		
	inputPage = inputPage > maxPage ? maxPage : inputPage;
	gotoPage(formName, inputPage);
};
