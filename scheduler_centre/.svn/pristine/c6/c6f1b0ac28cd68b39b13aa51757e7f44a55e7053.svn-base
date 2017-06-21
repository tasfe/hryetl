Ext.define('banggo.view.taskManager.ScheExecRecordForm', {
	extend : 'Ext.form.Panel',
	alias : 'widget.scheExecRecordForm',
	frame : true,// 面板渲染效果
	border : 0,
	minWidth : 700,
	minHeight : 80,
	requires : ['banggo.util.DateTime', 'banggo.util.DateTimePicker'],
	collapsible : true,
	region : 'north', // border布局，将页面分成东，南，西，北，中五部分
	fieldDefaults : {
		labelAlign : 'right',// label位于field的位置（left,top,right）
		labelWidth : 90
	},
	buttons : [{
				text : '查询',
				id : 'queryScheExecRecordId'
			}, {
				text : '重置',
				id : 'resetBtnId'
			}],
	initComponent : function() {
		var me = this;
		me.items = [{
			xtype : 'container',
			anchor : '100%',
			layout : 'hbox',
			items : [{
				xtype : 'container',
				layout : 'anchor',
				flex : 1,
				defaultType : 'textfield',
				items : [{
							fieldLabel : '开始时间从',
							xtype : 'datetimefield',
							padding : '5 7 5 7',
							width : 280,
							name : 'beginTimeFrom',
							format : 'Y-m-d H:i:s'
						}, {
							fieldLabel : '应用名称',
							name : 'appName',
							width : 280,
							triggerAction : "all",
							forceSelection : true,
							editable : false,
							padding : '5 7 5 7',
							width : 280,
							xtype : 'combobox',
							store : Ext
									.create('banggo.store.taskManager.ComboboxScheAppNamesStore'),
							valueField : 'value',
							displayField : 'key',
							emptyText : "请选择..."
						}, {
							fieldLabel : '应用执行编号',
							padding : '5 7 5 7',
							width : 280,
							name : 'remoteExecNo'
						}]
			}, {
				xtype : 'container',
				layout : 'anchor',
				flex : 1,
				defaultType : 'textfield',
				items : [{
							fieldLabel : '到',
							xtype : 'datetimefield',
							name : 'beginTimeTo',
							padding : '5 7 5 7',
							width : 280,
							format : 'Y-m-d H:i:s'
						}, {
							fieldLabel : '任务名称',
							padding : '5 7 5 7',
							width : 280,
							name : 'jobName'
						}, {
							fieldLabel : '运行状态',
							name : 'status',
							triggerAction : "all",
							forceSelection : true,
							editable : false,
							padding : '5 7 5 7',
							width : 280,
							xtype : 'combobox',
							store : Ext
									.create('banggo.store.taskManager.ComboxStatusStore'),
							valueField : 'value',
							displayField : 'text',
							emptyText : "请选择..."
						}]
			}, {
				xtype : 'container',
				layout : 'anchor',
				flex : 1,
				defaultType : 'textfield',
				items : [{
							fieldLabel : '任务组名称',
							padding : '5 7 5 7',
							width : 280,
							name : 'jobGroup'
						}, {
							fieldLabel : '执行编号',
							padding : '5 7 5 7',
							width : 280,
							name : 'execNo'
						}, {
							fieldLabel : '运行结果',
							xtype : 'combo',
							name : 'result',
							padding : '5 7 5 7',
							width : 280,
							triggerAction : "all",
							forceSelection : true,
							editable : false,
							store : Ext
									.create('banggo.store.taskManager.ComboxResultStore'),
							valueField : 'value',
							displayField : 'text',
							emptyText : "请选择..."
						}]
			}]
		}];
		me.callParent(arguments);
	}
});