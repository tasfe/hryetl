Ext.define('banggo.view.taskManager.AddJobForm', {
	extend : 'Ext.form.Panel',
	alias : 'widget.addJobForm',
	border : 0,
	requires : [ 'banggo.util.DateTime', 'banggo.util.DateTimePicker' ],
	padding : '6 7 6 7',
	items : [ {
		xtype : 'fieldset',
		layout : 'anchor',
		title : '基本信息',
		defaultType : 'textfield',
		defaults : {
			labelAlign : 'right'
		},
		collapsible : true,
		items : [ {
			xtype : 'container',
			layout : 'hbox',
			padding : '1 7 1 7',
			items : [  {
				xtype : 'container',
				layout : 'anchor',
				flex : 1,
				padding : '6 7 6 7',
				defaults : {
					anchor : '100%',
					labelAlign : 'right'
				},
				defaultType : 'textfield',
				items : [{
					xtype : 'combobox',
					name : 'appName',
					store : 'taskManager.ComboboxScheAppNamesStore',// Ext.data.StoreManager.lookup('comboboxScheAppNamesStoreId'),
					padding : '16 7 16 7',
					labelWidth : 115,
					editable : false,
					fieldLabel : "应用名称",
					displayField : "value",
					valueField : 'value',
					allowBlank : false
				}, {
					fieldLabel : '任务名',
					padding : '16 7 16 7',
					allowBlank : false,
					name : 'jobName'
				}, {
					fieldLabel : '开始时间',
					xtype : 'datetimefield',
					padding : '16 7 16 7',
					name : 'beginDate',
					format : 'Y-m-d H:i:s'
				}, {
					fieldLabel : 'Cron表达式',
					padding : '16 7 16 7',
					minLength : 11,
					maxLength : 66,
					allowBlank : false,
					name : 'cronExp'
				}, {
					fieldLabel : '连接超时(毫秒)',
					padding : '16 7 16 7',
					value : 300000,
					name : 'connectTimeout',
					id : 'connectTimeoutId'
				} ]
			}, {
				xtype : 'container',
				layout : 'anchor',
				flex : 1,
				padding : '6 7 6 7',
				defaults : {
					anchor : '100%',
					labelAlign : 'right'
				},
				defaultType : 'textfield',
				items : [ {
					xtype : 'combobox',
					fieldLabel : "任务类型",
					emptyText : "请选择...",
					triggerAction : "all",
					forceSelection : true,
					padding : '16 7 16 7',
					editable : false,
					value:1,
					store : Ext.create("Ext.data.Store", {
								fields : ["name", "value"],
									data : [ {
												name : "请选择",
												value :""
											},
								         {
											name : "远程调用",
											value : 1
										}, {
											name : "任务链",
											value : -1
										}]
							}),
					mode : "local",
					forceSelection : true,
					displayField : "name",
					valueField : "value",
					queryMode : "local",
					width : 240,
					id : 'type',
					name : 'type'
				}, {
					fieldLabel : '任务组名称',
					padding : '16 7 16 7',
					allowBlank : false,
					name : 'jobGroup'
				}, {
					fieldLabel : '结束时间',
					xtype : 'datetimefield',
					padding : '16 7 16 7',
					name : 'endDate',
					format : 'Y-m-d H:i:s'
				}, {
					xtype : 'radiogroup',
					padding : '16 7 16 7',
					layout : {
						type : 'column',
						autoFlex : false
					},
					defaults:{
						name : 'isAllowConcurrent'
					},
					id:'isAllowConcurrentId',
					items : [ {
						inputValue : '1',
						padding : '0 5 0 17',
						margin : '0 25 0 17',
						boxLabel : '并行',
						checked : true
					}, {
						inputValue : '0',
						boxLabel : '串行'
					} ]
				}, {
					fieldLabel : '读取超时(毫秒)',
					padding : '16 7 16 7',
					name : 'readTimeout',
					id : 'readTimeoutId',
					value : 600000,
					format : 'Y-m-d'
				} ]
			} ]
		}, {
			xtype : 'textfield',
			padding : '1 7 1 7',
			name : 'remoteUrl',
			id : 'remoteUrlId',
//			vtype : 'url',
			width : 710,
			labelWidth : 115,
			vtypeText : "不是有效的URL地址",
			value : 'http://',
			fieldLabel : '应用系统URL'
		} ]
	}, {
		xtype : 'fieldset',
		autoScroll : true,
		autoShow : true,
		maxHeight : 300,
		height : 180,
		collapsible : true,// 可以收缩
		title : '参数列表',
		id : 'fieldSet'
	} ],
	buttons : [ {
		text : '新增参数',
		id : 'addParamAddJobFormBtnId'
	}, {
		text : '保存',
		id : 'finishAddJobFormId'
	}, {
		text : '重置',
		id : 'resetAddJobFormBtnId'
	}, {
		text : '关闭',
		id : 'closeAddJobFormBtnId'
	} ],
	initComponent : function() {
		var me = this;
		me.callParent(arguments);
	}
});