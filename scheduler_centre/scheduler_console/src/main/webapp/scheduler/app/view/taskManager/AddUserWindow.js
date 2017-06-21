Ext.define('banggo.view.taskManager.AddUserWindow', {
	extend : 'Ext.window.Window',
	alias : 'widget.addUserWindow',
	requires:['banggo.view.taskManager.AddUserForm'],
	modal : true,
	resizable:false,
  	border:false,
	width:400,
	autoHeight:true,
	title:'新增用户',
	items : [{
		xtype : 'addUserForm'
	}],
	initComponent : function() {
		var me = this;
		me.callParent(arguments);
	}
});