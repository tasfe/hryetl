Ext.define('banggo.view.taskManager.WorkFlowForm', {
			extend : 'Ext.form.Panel',
			alias : 'widget.workFlowForm',
			title : "查询条件",
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
						id : 'requeyWorkFlowFormBtnId'
					}, {
						text : '重置',
						id : 'resetWorkFlowFormBtnId'
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
							xtype : 'textfield',
							fieldLabel : '任务链名称',
							padding : '5 7 5 7',
							width : 240,
							name : 'scheChainName'
						} ]
					}, {
						xtype : 'container',
						layout : 'anchor',
						flex : 1,
						defaultType : 'textfield',
						items : [ {
							xtype : 'textfield',
							fieldLabel : '任务组名称',
							padding : '5 7 5 7',
							width : 240,
							name : 'jobGroup'
						},{
							xtype : 'textfield',
							fieldLabel : '版本号',
							padding : '5 7 5 7',
							width : 240,
							name : 'queryVersion'
						}
						   ]
					},{
						xtype : 'textfield',
						fieldLabel : '任务名',
						padding : '5 7 5 7',
						width : 240,
						name : 'jobName'
					}]
				}];
				me.callParent(arguments);
			}
		});