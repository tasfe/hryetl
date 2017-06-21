Ext.define('banggo.view.taskManager.JobForm', {
	extend : 'Ext.form.Panel',
	alias : 'widget.jobForm',
	title : "查询条件",
	region : 'north',
	layout : 'column',
	border : false,
	// collapsible : true,
	frame : true,
	fieldDefaults : {
		labelWidth : 80,
		labelAlign : 'right'
	},
	items : [ {
		xtype : 'container',
		layout : 'anchor',
		flex : 1,
//		padding : '6 7 6 7',
		defaults : {
			anchor : '100%',
			labelAlign : 'right'
		},
		defaultType : 'textfield',
		items : [ {
			xtype : 'combobox',
			name : 'appName',
			store : 'taskManager.ComboboxScheAppNamesStore',
			padding : '5 7 5 7',
			width : 240,
			triggerAction : "all",
			forceSelection : true,
			editable : false,
			fieldLabel : "应用名称",
			emptyText : "请选择...",
			valueField : 'value',
			displayField : 'key'
		}, {
			xtype : 'combobox',
			fieldLabel : "任务类型",
			emptyText : "请选择...",
			triggerAction : "all",
			forceSelection : true,
			padding : '5 7 5 7',
			editable : false,
			store : Ext.create("Ext.data.Store", {
				fields : [ "name", "value" ],
				data : [ {
					name : "请选择",
					value : ""
				}, {
					name : "远程调用",
					value : 1
				}, {
					name : "任务链",
					value : -1
				} ]
			}),
			mode : "local",
			forceSelection : true,
			displayField : "name",
			valueField : "value",
			queryMode : "local",
			width : 240,
			name : 'type'
		} ]
	}, {
		xtype : 'container',
		layout : 'anchor',
		flex : 1,
//		padding : '6 7 6 7',
		defaults : {
			anchor : '100%',
			labelAlign : 'right'
		},
		defaultType : 'textfield',
		items : [ {
			xtype : 'textfield',
			fieldLabel : '任务名',
			padding : '5 7 5 7',
			width : 240,
			name : 'jobName'
		} ]
	}, {
		xtype : 'container',
		layout : 'anchor',
		flex : 1,
//		padding : '6 7 6 7',
		defaults : {
			anchor : '100%',
			labelAlign : 'right'
		},
		defaultType : 'textfield',
		items : [ {
			xtype : 'textfield',
			fieldLabel : '任务组名称',
			padding : '5 7 5 7',
			width : 240,
			name : 'jobGroup'
		} ]
	}, {
		xtype : 'container',
		layout : 'anchor',
		flex : 1,
//		padding : '6 7 6 7',
		defaults : {
			anchor : '100%',
			labelAlign : 'right'
		},
		defaultType : 'textfield',
		items : [ {
			xtype : 'combobox',
			fieldLabel : "任务状态",
			emptyText : "请选择...",
			triggerAction : "all",
			forceSelection : true,
			editable : false,
			store : Ext.create("Ext.data.Store", {
				fields : [ "name", "value" ],
				data : [ {
					name : "请选择",
					value : ""
				}, {
					name : "正常",
					value : 1
				}, {
					name : "停止",
					value : 0
				} ]
			}),
			mode : "local",
			forceSelection : true,
			displayField : "name",
			valueField : "value",
			queryMode : "local",
			padding : '5 7 5 7',
			width : 240,
			name : 'status'
		} ]
	} ],
	buttons : [ {
		text : '查询',
		id : 'requeyJobFormBtnId'
	}, {
		text : '重置',
		id : 'resetJobFormBtnId'
	} ],
	initComponent : function() {
		var me = this;

		me.callParent(arguments);
	}
});