Ext.define('banggo.view.taskManager.AddWorkFlowWindow', {
			extend : 'Ext.window.Window',
			alias : 'widget.addWorkFlowWindow',
			requires:['banggo.view.taskManager.AddWorkFlowForm'],
			width : 800,
			height : 550,
			layout:'border',
			title:'任务编排>>任务链编辑',
//			autoScroll : true,
			maximizable: true,
			maximized:true,
			items : [{
						xtype : 'addWorkFlowForm'
					}],
			initComponent : function() {
				var me = this;
				me.callParent(arguments);
			}
		});