Ext.define('banggo.view.content.UserGroupContentPanel', {
	extend : 'Ext.panel.Panel',
	alias : 'widget.userGroupContentPanel',
	layout:'border',
	requires : ['banggo.view.taskManager.UserGroupForm',
				'banggo.view.taskManager.UserGroupGrid'],
	items : [
		{
			xtype : 'userGroupForm',
			flex:4
		}, {
			xtype : 'userGroupGrid',
			flex:20
		}],
		initComponet : function() {
			var me = this;
			me.callParent(arguments);
		}
});