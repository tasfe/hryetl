Ext.define('banggo.view.taskManager.EditScheExecRecordWindow', {
			extend : 'Ext.window.Window',
			alias : 'widget.editScheExecRecordWindow',
			requires:['banggo.view.taskManager.EditScheExecRecordForm'],
			width : 700,
			height : 500,
			title:'更新任务',
			id:'editScheExecRecordWindowId',
			items : [{
						xtype : 'editScheExecRecordForm'
					}]
		});