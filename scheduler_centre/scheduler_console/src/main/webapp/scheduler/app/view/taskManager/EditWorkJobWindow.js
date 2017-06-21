Ext.define('banggo.view.taskManager.EditWorkJobWindow', {
	extend : 'Ext.window.Window',
	alias : 'widget.editWorkJobWindow',
	requires:['banggo.view.taskManager.EditWorkJobForm'],
	modal : true,
	resizable:false,
  	border:false,
	width:600,
	autoHeight:true,
	title:'修改任务预警',
	items : [{
		xtype : 'editWorkJobForm'
	}],
	initComponent : function() {
		var me = this;
		me.callParent(arguments);
	}
});