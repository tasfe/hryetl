Ext.define('banggo.view.taskManager.WorkJobForm', {
	extend : 'Ext.form.Panel',
	alias : 'widget.workJobForm',
	title : "查询条件",
	region : 'north',
	layout : 'column',
	border : false,
	frame : true,
	fieldDefaults : {
		labelWidth : 80,
		labelAlign : 'right'
	},
	items : [ {
		xtype : 'container',
		layout : 'anchor',
		flex : 1,
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
		}]
	}, {
		xtype : 'container',
		layout : 'anchor',
		flex : 1,
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
		defaults : {
			anchor : '100%',
			labelAlign : 'right'
		},
		defaultType : 'textfield',
		items : [ {
			xtype : 'combobox',
			fieldLabel : "状态",
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
	buttons:[ 
		{text : '查询',id:'requeyWorkJobFormBtnId'}, {text:'重置',id:'resetWorkJobFormBtnId'} 
	],
	initComponent : function() {
		var me = this;
		me.callParent(arguments);
	}
});