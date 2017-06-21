Ext.define('banggo.view.content.WorkContentPanel', {
	extend : 'Ext.panel.Panel',
	alias : 'widget.workContentPanel',
	layout:'border',
	requires : ['banggo.view.taskManager.WorkJobForm',
				'banggo.view.taskManager.WorkJobGrid'],
	items : [
		{
			xtype : 'workJobForm',
			flex:4
		}, {
			xtype : 'workJobGrid',
			flex:19
		}],
		initComponet : function() {
			var me = this;
			me.callParent(arguments);
		}
});