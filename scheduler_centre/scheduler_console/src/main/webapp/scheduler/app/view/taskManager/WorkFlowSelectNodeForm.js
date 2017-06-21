Ext.define('banggo.view.taskManager.WorkFlowSelectNodeForm', {
			extend : 'Ext.form.Panel',
			alias : 'widget.workFlowSelectNodeForm',
			title : "查询条件",
			region : 'north',
			layout : 'column',
			border : false,
//			collapsible : true,
			frame : true,
			fieldDefaults : {
				labelWidth : 80,
				labelAlign : 'right'
			},
			items : [{
						xtype : 'combobox',
						name : 'appName',
						store : 'taskManager.ComboboxScheAppNamesStore',
						padding : '0 10',
						width : 240,
						triggerAction : "all",
						forceSelection : true,
						editable : false,
						fieldLabel : "应用名称",
						emptyText : "请选择...",
						valueField : 'value',
						displayField : 'key'
					}, {
						xtype : 'textfield',
						fieldLabel : '任务名',
						padding : '0 10',
						width : 240,
						name : 'jobName'
					}, {
						xtype : 'textfield',
						fieldLabel : '任务组名称',
						padding : '0 10',
						width : 240,
						name : 'jobGroup'
					}, {
						xtype : 'combobox',
						fieldLabel : "任务状态",
						emptyText : "请选择...",
						triggerAction : "all",
						forceSelection : true,
						editable : false,
						store : Ext.create("Ext.data.Store", {
									fields : ["name", "value"],
										data : [ {
													name : "请选择",
													value :""
												},
									         {
												name : "正常",
												value : 1
											}, {
												name : "停止",
												value : 0
											}]
								}),
						mode : "local",
						forceSelection : true,
						displayField : "name",
						valueField : "value",
						queryMode : "local",
						padding : '0 10',
						width : 240,
						name : 'status'
					},{
						xtype : 'hidden',
						name : 'type',
						value:1
					}],
			buttons : [{
						text : '查询',
						id : 'requeyWorkFlowSelectFormBtnId'
					}, {
						text : '重置',
						id : 'resetWorkFlowSelectFormBtnId'
					}],
			initComponent : function() {
				var me = this;

				me.callParent(arguments);
			}
		});