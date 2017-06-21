Ext.define('banggo.view.taskManager.EditScheExecRecordForm', {
	extend : 'Ext.form.Panel',
	alias : 'widget.editScheExecRecordForm',
	requires:['banggo.util.DateTime',
				'banggo.util.DateTimePicker'],
	height : 450,
	border : 0,
	padding : '4 7 4 7',
	id:'editScheExecRecordFormId',
	buttons : [{
		text : '新增参数',
		handler : function() {
			var parent = this.ownerCt.ownerCt;
			var i = parent.layoutCounter+10;//
//			i++;
			var _textfield = Ext.create('Ext.form.FieldSet', {
						border : 0,
						id : 'FieldSetDown' + i,
						layout : {
							type : 'hbox'
						},
						items : [{
									xtype : 'textfield',
									padding : '0 5 0 5',
									fieldLabel : '参数名称',
									labelAlign : 'right',
									allowBlank : false,
									name : 'scheJobParamsList['+i+'].name',
									id:'scheJobParamsListName'+i
								}, {
									xtype : 'textfield',
									fieldLabel : '参数值',
									labelAlign : 'right',
									allowBlank : false,
									padding : '0 5 0 5',
									name : 'scheJobParamsList['+i+'].value',
									id:'scheJobParamsListValue'+i
								}, {
									xtype : 'button',
									padding : '0 5 0 5',
									text : '删除',
									handler : function() {
										var FieldSetDown = Ext
												.getCmp('FieldSetDown' + i);
										var parentF = FieldSetDown.ownerCt;
										parentF.remove(FieldSetDown);
									}
								}]
					});
			Ext.getCmp('_fieldSet').add(_textfield);
			parent.doLayout();
		}
	}, {
		text : '重置',
		handler : function() {
			this.up('form').getForm().reset();
		}
	}, {
		text : '保存',
		id : 'finishEditBtnId',
		handler : function(btn) {
			var form = this.up('form').getForm();
			var values = form.getValues();
			form.submit({
						url : '/scheduler_console/job/update.htm',
						method : 'POST',
						params : values,
						success : function(form, action) {
							Ext.MessageBox.alert('提示', '更新成功！');
							btn.ownerCt.ownerCt.ownerCt.close();
						},
						failure : function(form, action) {
							var ret = eval("("+action.response.responseText+")");
							Ext.MessageBox.alert('提示', '更新失败!'+ret.errorMsg);
						}
					});
		}
	}],
	initComponent : function() {
		var me = this;
		me.items = [{
		xtype : 'fieldset',
		layout : 'anchor',
		padding : '4 7 4 7',
		defaultType : 'textfield',
		defaults : {
			anchor : '100%',
			labelAlign : 'right'
		},
		collapsible : true,
		items : [{
			xtype : 'hiddenfield',
			name : 'status',
			value:''
		}, {
			xtype : 'hiddenfield',
			name : 'createDate',
			value:''
		}, {
			xtype : 'hiddenfield',
			name : 'createBy',
			value:''
		}, {
			xtype : 'hiddenfield',
			name : 'updateDate',
			value:''
		}, {
			xtype : 'hiddenfield',
			name : 'updateBy',
			value:''
		}, {
					xtype : 'container',
					layout : 'hbox',
					items : [{
								xtype : 'container',
								layout : 'anchor',
								flex : 1,
								padding : '4 7 4 7',
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
								},{
											fieldLabel : '任务名',
											padding : '4 7 4 7',
											allowBlank : false,
											name : 'jobName'
										}, {
											fieldLabel : '开始时间',
											xtype : 'datetimefield',
											padding : '4 7 4 7',
											name : 'beginDate',
											format : 'Y-m-d H:i:s'
										}, {
											fieldLabel : 'Cron表达式',
											padding : '4 7 4 7',
											minLength:11,
											maxLength:66,
											allowBlank : false,
											name : 'cronExp'
										}, {
											fieldLabel : '连接超时(毫秒)',
											padding : '4 7 4 7',
											name : 'connectTimeout',
											id : 'connectTimeoutId'
										}, {
											xtype : 'hidden',
											name : 'id',
											id : 'id'
										}, {
											xtype : 'hidden',
											name : 'idx',
											id : 'idx'
										}]
							}, {
								xtype : 'container',
								layout : 'anchor',
								flex : 1,
								padding : '4 7 4 7',
								defaults : {
									anchor : '100%',
									labelAlign : 'right'
								},
								defaultType : 'textfield',
								items : [{
									xtype : 'combobox',
									fieldLabel : "任务类型",
									emptyText : "请选择...",
									triggerAction : "all",
									forceSelection : true,
									padding : '16 7 16 7',
									editable : false,
									readOnly : true,
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
								},{
											fieldLabel : '任务组名称',
											padding : '4 7 4 7',
											allowBlank : false,
											name : 'jobGroup'
										}, {
											fieldLabel : '结束时间',
											xtype : 'datetimefield',
											padding : '4 7 4 7',
											name : 'endDate',
											format : 'Y-m-d H:i:s'
										}, {
											xtype : 'radiogroup',
											anchor : 'none',
											padding : '4 7 4 7',
											layout : {
												autoFlex : false
											},
											defaults:{
												name : 'isAllowConcurrent',
												style : 'margin-right:15px',// 按钮距离右边15像素
											},
											id : 'isAllowConcurrentId',
											items : [{
												inputValue : '1',
												boxLabel : '并行'
											}, {
												inputValue : '0',
												boxLabel : '串行',
												checked : true
											}]
										}, {
											fieldLabel : '读取超时(毫秒)',
											name : 'readTimeout',
											id : 'readTimeoutId',
											format : 'Y-m-d'
										}]
							}]
				}, {
					xtype : 'textfield',
					name : 'remoteUrl',
					id : 'remoteUrlId',
//					vtype : 'url',
					vtypeText : "不是有效的邮箱地址",
					value : 'http://',
					fieldLabel : '应用系统URL'
				}]
		}, {
			xtype : 'fieldset',
			autoScroll:true,
			autoShow:true,
			maxHeight:300,
			height:180,
			collapsible : true,// 可以收缩
			title : '参数列表',
			id : '_fieldSet'
		}];
		me.setField(me.jobId);
		me.callParent(arguments);
	},
	setField : function(jobId) {
		var id =jobId;
		Ext.Ajax.request({
					url : 'job/paramData.htm',
					params :{jobId:id},
					success : function(response, opts) {
						var fieldSetParam = Ext.getCmp('_fieldSet');
						var fieldSetAry = [];
						var paramData = Ext.decode(response.responseText).paramData;
						Ext.getCmp('idx').setValue(paramData.length);
							for (var index = 0; index < paramData.length; index++) {
							var fieldSets = Ext.create('Ext.form.FieldSet',{
									border : 0,
									id : 'FieldSetDown'+index,
									layout : {
										type : 'hbox'
									},
									items:[{
										xtype : 'textfield',
										fieldLabel : '参数名称',
										width:250,
										labelAlign : 'right',
										value : paramData[index].name,
										name : 'scheJobParamsList['+index+'].name'
									},{
										xtype : 'textfield',
										fieldLabel : '参数值',
										labelAlign : 'right',
										width:250,
										value : paramData[index].value,
										name : 'scheJobParamsList['+index+'].value'
									},{
										xtype : 'button',
										padding : '0 5 0 5',
										text : '删除'
									}]
								});
								fieldSetAry.push(fieldSets);
						}
								fieldSetParam.removeAll();
								fieldSetParam.add(fieldSetAry);
								var editForm = Ext.getCmp('editScheExecRecordFormId');
								editForm.doLayout();
					},
					failure : function(response, opts) {
						Ext.MessageBox.alert('提示', '添加失败');
					}
				});
		
	}
});