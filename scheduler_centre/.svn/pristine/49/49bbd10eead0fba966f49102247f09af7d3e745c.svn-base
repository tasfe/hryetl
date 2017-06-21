
String.prototype.contains = function(item){ 
	return RegExp(item).test(this); 
}

// 验证邮箱
function checkEmail(_val) {
    if (_val != "")
    {
        var pattern = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
        var flag = pattern.test(_val);
        if(!flag) {
            return false;
        }
    }
    return true;
}

//判断是否为数字
function checkIsNum(_val){
	 if (_val != ""){
		var pattern = /^[0-9]*[0-9][0-9]*$/;
		var flag = pattern.test(_val);
		return flag;
	 }
	 return true;
}

//获取左对齐格式
function getLeftFormate(value) {
	return "<div style='text-align:left;'>"+value+"</div>";
};

// 获取右对齐格式
function getRightFormate(value) {
	return "<div style='text-align:right;'>"+value+"</div>";
};

//获取金额保留2位右对齐格式
function getMoneyFormate(value) {
	return "<div style='text-align:right;'>"+getMoney(value)+"</div>";
};

//获取2位金额
function getMoney(value) {
	var s = value.toString();
	
	var index = s.indexOf(".");
	
	if (index == -1) {
		s =  s + ".00";
	} else {
		var leng = s.substring(index + 1);
		
		if (leng.length == 1) {
			s = s + "0";
		}
	}
	
	return s;
};
/**
 * int类型转换成时间格式（Y-m-d H:i:s）
 * @param {} v 当前字段名
 * @param {} record 
 * @return {}
 */
function formatDate(v,record){
						return Ext.isEmpty(v)?'':Ext.Date.format(new Date(v),'Y-m-d H:i:s')
					}
