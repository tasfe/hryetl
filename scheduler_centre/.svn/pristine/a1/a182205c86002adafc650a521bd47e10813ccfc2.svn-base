Ext.define('banggo.view.content.JobContentPanel', {
			extend : 'Ext.panel.Panel',
			alias : 'widget.jobContentPanel',
			layout:'border',
			requires : ['banggo.view.taskManager.JobForm',
					'banggo.view.taskManager.JobGrid'],
			items : [
			         {
						xtype : 'jobForm',
						flex:6
					}, {
						xtype : 'jobGrid',
						flex:17
					}],
			initComponet : function() {
				var me = this;
				me.callParent(arguments);
			}
		});