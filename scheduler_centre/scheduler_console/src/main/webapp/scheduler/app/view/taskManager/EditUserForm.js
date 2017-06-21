
Ext.define('banggo.view.taskManager.EditUserForm', {
	extend : 'Ext.form.Panel',
	alias : 'widget.editUserForm',
	border : 0,
	bodyStyle: 'padding:5px 5px 0',
	width: '100%',
	id:'editUserFormId',
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
        	xtype: 'hiddenfield',
	    	name: 'id',
	    	value: ''
    	},
  		{
        	xtype: 'textfield',
         	fieldLabel: '用户名',
          	labelAlign:'right',
          	readOnly:true,
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
		text : '保存',
		id : 'finishEditUserFormId'
	},{
		text : '关闭',
		id : 'closeEditUserFormBtnId'
	} ],
	initComponent : function() {
		
		var me = this;
		me.callParent(arguments);
	}
});