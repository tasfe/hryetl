Ext.define('banggo.view.taskManager.WorkFlowJobWindow', {
			extend : 'Ext.window.Window',
			alias : 'widget.workFlowJobWindow',
			id : 'workFlowJobWindow',
			requires : ['banggo.view.taskManager.WorkFlowSelectNodeForm',
						'banggo.view.taskManager.WorkFlowSelectNodeGrid'],
			width : 900,
			height : 600,
			layout:'border',
			title:'任务编排>>任务节点查询',
			maximizable: true,
			items : [{
						xtype : 'workFlowSelectNodeForm',
						flex:4
					}, {
						xtype : 'workFlowSelectNodeGrid',
						flex:17
					}]
			});