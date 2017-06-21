
Ext.define('banggo.view.taskManager.AddUserForm', {
	extend : 'Ext.form.Panel',
	alias : 'widget.addUserForm',
	border : 0,
	bodyStyle: 'padding:5px 5px 0',
	width: '100%',
	id:'addUserFormId',
    defaults: {
        border: false,
        xtype: 'panel',
        flex: 1,
        layout: 'anchor'
    },
    layout : 'hbox',
	items: [{
  		items: [
  		{
        	xtype: 'textfield',
         	fieldLabel: '用户名',
          	labelAlign:'right',
          	padding : '5 7 5 7',
     		name: 'userName'
    	},{
        	xtype: 'textfield',
         	fieldLabel: '姓名',
          	labelAlign:'right',
          	padding : '5 7 5 7',
     		name: 'name'
    	},{
        	xtype: 'textfield',
         	fieldLabel: '手机号码',
          	labelAlign:'right',
          	padding : '5 7 5 7',
     		name: 'mobile'
    	},{
        	xtype: 'textfield',
         	fieldLabel: '邮箱',
          	labelAlign:'right',
          	padding : '5 7 5 7',
     		name: 'email'
    	}]
	}],
	buttons : [ {
		text : '检测用户',
		id : 'searchAddUserFormId'
	},{
		text : '保存',
		id : 'finishAddUserFormId'
	}, {
		text : '重置',
		id : 'resetAddUserFormBtnId'
	}, {
		text : '关闭',
		id : 'closeAddUserFormBtnId'
	} ],
	initComponent : function() {
		
		var me = this;
		me.callParent(arguments);
	}
});