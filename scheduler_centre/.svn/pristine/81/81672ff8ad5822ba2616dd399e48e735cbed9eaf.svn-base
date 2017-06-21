Ext.define('banggo.view.taskManager.WorkFlowExecuteForm', {
			extend : 'Ext.form.Panel',
			alias : 'widget.workFlowExecuteForm',
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
			title : "查询条件",
			buttons : [{
						text : '查询',
						id : 'requeyWorkFlowExecuteFormBtnId'
					}, {
						text : '重置',
						id : 'resetWorkFlowExecuteFormBtnId'
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
									fieldLabel : '执行编号',
									padding : '5 7 5 7',
									width : 280,
									name : 'execNo'
								},{
									xtype : 'combobox',
									name : 'appName',
									store : 'taskManager.ComboboxScheAppNamesStore',
									padding : '5 7 5 7',
									width : 280,
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
						defaultType : 'textfield',
						items : [{
									fieldLabel : '到',
									xtype : 'datetimefield',
									name : 'beginTimeTo',
									padding : '5 7 5 7',
									width : 280,
									format : 'Y-m-d H:i:s'
								}, {
									fieldLabel : '任务链名称',
									padding : '5 7 5 7',
									width : 280,
									name : 'scheChainName'
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
									xtype : 'combobox',
									fieldLabel : "运行状态",
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
											name : "执行中",
											value : 1
										}, {
											name : "执行结束",
											value : 2
										} ]
									}),
									mode : "local",
									forceSelection : true,
									displayField : "name",
									valueField : "value",
									queryMode : "local",
									width : 280,
									name : 'status'
								}]
					}]
				}];
				me.callParent(arguments);
			}
		});