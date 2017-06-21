Ext.define('banggo.view.taskManager.EditUserWindow', {
	extend : 'Ext.window.Window',
	alias : 'widget.editUserWindow',
	requires:['banggo.view.taskManager.EditUserForm'],
	modal : true,
	resizable:false,
  	border:false,
	width:400,
	id:'editUserWindowId',
	autoHeight:true,
	title:'修改用户',
	items : [{
		xtype : 'editUserForm'
	}],
	initComponent : function() {
		var me = this;
		me.callParent(arguments);
	}
});