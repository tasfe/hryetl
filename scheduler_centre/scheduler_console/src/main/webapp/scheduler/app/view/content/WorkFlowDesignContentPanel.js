Ext.define('banggo.view.content.WorkFlowDesignContentPanel', {
	extend : 'Ext.panel.Panel',
	alias : 'widget.workFlowDesignContentPanel',
	layout:'border',
	requires : ['banggo.view.taskManager.WorkFlowForm'
	            ,'banggo.view.taskManager.WorkFlowGrid'],
	items : [
	         {
				xtype : 'workFlowForm',
				flex:5
			}
			, {
				xtype : 'workFlowGrid',
				flex:17
			}
				],
	initComponet : function() {
		var me = this;
		me.callParent(arguments);
	}
});