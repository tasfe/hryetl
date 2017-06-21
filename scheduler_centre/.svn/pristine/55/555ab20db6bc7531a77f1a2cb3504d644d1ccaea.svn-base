Ext.define('banggo.view.content.WorkFlowExecuteContentPanel', {
	extend : 'Ext.panel.Panel',
	alias : 'widget.workFlowExecuteContentPanel',
	layout:'border',
	requires : ['banggo.view.taskManager.WorkFlowExecuteForm'
	            ,'banggo.view.taskManager.WorkFlowExecuteGrid'],
	items : [
	         {
				xtype : 'workFlowExecuteForm',
				flex:7
			}
			, {
				xtype : 'workFlowExecuteGrid',
				flex:17
			}
				],
	initComponet : function() {
		var me = this;
		me.callParent(arguments);
	}
});