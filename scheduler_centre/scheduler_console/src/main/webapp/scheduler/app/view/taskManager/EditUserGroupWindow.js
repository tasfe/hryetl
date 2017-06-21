Ext.define('banggo.view.taskManager.EditUserGroupWindow', {
	extend : 'Ext.window.Window',
	alias : 'widget.editUserGroupWindow',
	requires:['banggo.view.taskManager.EditUserGroupForm'],
	modal : true,
	resizable:false,
  	border:false,
	width:600,
	autoHeight:true,
	title:'修改用户组',
	items : [{
		xtype : 'editUserGroupForm'
	}],
	initComponent : function() {
		var me = this;
		me.callParent(arguments);
	}
});