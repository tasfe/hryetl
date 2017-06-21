//声明全局变量
var realPath_PUB;
var authRealPath_PUB;
var userName_PUB;
var authOutRealPath_PUB;
Ext.onReady(function() {
	Ext.Loader.setConfig({
		enabled : true,
		disableCaching:false
	});
	Ext.Loader.setPath('Ext.ux', 'extjs4/examples/ux');

	Ext.application({
		name : 'banggo',
		appFolder : 'scheduler/app',
		title:'基础信息管理',
		launch : function() {
		},
		autoCreateViewport : true,
		controllers : ['MenuController',
			'taskManager.WorkFlowController',
			'taskManager.JobController',
			'taskManager.ScheExecRecordController',
			'taskManager.UpdateKettleDateController',
			'taskManager.WorkController',
			'taskManager.UserGroupController']
	});
			
	Ext.Ajax.request({
		url : 'sche/getUserInfo.htm',
		success : function(response, opts) {
			//全局变量赋值
			var json = Ext.decode(response.responseText);
			userName_PUB = json.UserInfo;
			authOutRealPath_PUB = json.AuthOutRealPath;
			authRealPath_PUB = json.AuthRealPath;
			realPath_PUB = json.HttpRealPath;
		},
		failure : function(response, opts) {
			Ext.MessageBox.alert("提示", "用户信息出错,请重新登录！");
		}
	});
			
	Ext.Ajax.on('requestcomplete',checkUserSessionStatus, this);     
	
	function checkUserSessionStatus(conn,response,options){
		    	
		if(response.responseText!=""){
			var ret = eval('('+response.responseText+')');
			if(typeof(ret.banggo_auth) != "undefined"){ 
				var code = ret.banggo_auth.code;
				var message = "";
				if (code == 401) {
					message = "请退出重新登录!";
				} else if (code == 403) {
					message = "没有权限，请退出和管理员联系!";
				} else if (code = 500) {
					message = "认证异常，请退出和管理员联系!";
				}
				
				if (message) {
					Ext.Msg.alert('提示', message, function(btn, text){    
			    		if (btn == 'ok'){    
				       		var redirect = authRealPath_PUB+'?returnUrl='+ encodeURIComponent(realPath_PUB);
				          	if(!realPath_PUB)
				          		window.location = redirect;
				        }    
			   		});
				}
			}
		}
	};   
});