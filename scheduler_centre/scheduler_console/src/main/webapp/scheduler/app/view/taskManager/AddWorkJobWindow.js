Ext.define('banggo.view.taskManager.AddWorkJobWindow', {
	extend : 'Ext.window.Window',
	alias : 'widget.addWorkJobWindow',
	requires:['banggo.view.taskManager.AddWorkJobForm'],
	modal : true,
	resizable:false,
  	border:false,
	width:600,
	autoHeight:true,
	title:'新增任务预警',
	items : [{
		xtype : 'addWorkJobForm'
	}],
	initComponent : function() {
		var me = this;
		me.callParent(arguments);
	}
});