i = 0;
var task;
var cp = new Ext.state.CookieProvider();
Ext.state.Manager.setProvider(cp);
Ext.define('banggo.controller.taskManager.JobController', {
	extend : 'Ext.app.Controller',
	models : ['taskManager.JobModel'],
	stores : ['taskManager.JobStore', 'taskManager.TaskManagerStore',
			'taskManager.ComboboxScheAppNamesStore'],
	views : ['content.JobContentPanel', 'taskManager.JobForm',
			'taskManager.JobGrid', 'taskManager.AddJobForm',
			'taskManager.EditJobForm', 'taskManager.AddJobWindow',
			'taskManager.EditJobWindow', 'content.ScheExecRecordContentPanel',
			'taskManager.ScheExecRecordGrid', 'taskManager.ScheExecRecordForm'],
	refs : [{
				ref : 'AddJobForm',
				selector : 'addJobForm'
			}, {
				ref : 'EditJobForm',
				selector : 'editJobForm'
			}, {
				ref : 'EditJobWindow',
				selector : 'editJobWindow'
			}, {
				ref : 'JobGrid',
				selector : 'jobGrid'
			}, {
				ref : 'JobForm',
				selector : 'jobForm'
			}, {
				ref : 'AddJobWindow',
				selector : 'addJobWindow'
			}, {
				ref : 'JobContentPanel',
				selector : 'jobContentPanel'
			}, {
				ref : 'ScheExecRecordContentPanel',
				selector : 'scheExecRecordContentPanel'
			}, {
				ref : 'ScheExecRecordGrid',
				selector : 'scheExecRecordGrid'
			}, {
				ref : 'ScheExecRecordForm',
				selector : 'scheExecRecordForm'
			}],
	init : function() {
		var me = this;
		me.control({
					// 选择gird行触发事件
					'jobGrid' : {
						itemdblclick : me.twoEditWindows,//双击弹出编辑窗口
						select : me.rowclickJobGrid,//选择行
						deselect :me.deselect,//取消选择行
						afterrender : me.afterrenderJobGrid//开始渲染grid
					},
					// 恢复
					'jobGrid button[id=selectJobGridBtnId]' : {
						click : me.selectJobGrid
					},
					// 定时器值改变时
					'jobGrid textfield[id=textfieldJobGridId]' : {
						change : me.saveRefreshJobGrid
					},
					// 弹出添加界面
					'jobGrid button[id=addJobGridBtnId]' : {
						click : me.addWindows
					},
					// 添加事件
					'addJobForm button[id=finishAddJobFormId]' : {
						click : me.finishAdd
					},
					// addJobForm add param
					'addJobForm button[id=addParamAddJobFormBtnId]' : {
						click : me.addParamAddJobForm
					},
					// 添加页面的重置功能
					'addJobForm button[id=resetAddJobFormBtnId]' : {
						click : me.resetForm
					},
					// 弹出编辑界面
					'jobGrid button[id=editJobGrid]' : {
						click : me.editWindows
					},
					// 恢复
					'jobGrid button[id=resumeJobGridBtnId]' : {
						click : me.resumeJobGrid
					},
					// 暂停
					'jobGrid button[id=pauseJobGridBtnId]' : {
						click : me.pauseJobGrid
					},
					// 执行
					'jobGrid button[id=runOnceJobGridBtnId]' : {
						click : me.runOnceJobGrid
					},
					// 执行记录
					'jobGrid button[id=runRecordJobGridBtnId]' : {
						click : me.runRecordJobGrid
					},
					// jobGird delete
					'jobGrid button[id=deleteJobGridBtnId]' : {
						click : me.deleteJobGrid
					},
					// 根据条件查询
					'jobForm button[id=requeyJobFormBtnId]' : {
						click : me.queryForm
					},
					// 重置表单
					'jobForm button[id=resetJobFormBtnId]' : {
						click : me.resetForm
					},
					// 关闭窗口
					'addJobForm button[id=closeAddJobFormBtnId]' : {
						click : me.closeWindow
					},
					// 选择框任务类型改变事件
					'addJobForm combobox[id=type]' : {
						change : me.changeType
					},
					// 定时刷新
//					'jobForm' : {
//						beforerender : me.afterrenderJobGrid
//					},
					// 编辑之前渲染
					'editJobForm' : {
						afterrender : me.afterrenderEditForm
					},
					// 添加之前渲染
					'addJobForm' : {
						afterrender : me.afterrenderAddForm
					},
					// 删除
					'editJobForm button[text=删除]' : {
						click : me.deleteForm
					},
					// 重置
					'editJobForm button[id=resetEditJobFormBtnId]' : {
						click : me.resetForm
					},
					// 关闭窗口
					'editJobForm button[id=closeEditJobFormBtnId]' : {
						click : me.closeWindow
					},
					// editJobForm add param
					'editJobForm button[id=addParamEditJobFormBtnId]' : {
						click : me.addParamAddJobForm
					},
					// 完成编辑
					'editJobForm button[id=finishEditBtnId]' : {
						click : me.finishEdit
					},
					// 关闭编辑窗口
					'editJobWindow' : {
						close : me.closeEditWindow
					},
					// 关闭添加窗口
					'addJobWindow' : {
						close : me.closeAddWindow
					}
				});
		me.callParent(arguments);
	},
	/**
	 * 任务类型改变事件
	 * @param {} btn
	 * @param {} e
	 * @param {} eOpts
	 */
	changeType:function(field,newValue,oldValue,eOpts){
		var me = this;
		var isAllowConcurrent = Ext.getCmp('isAllowConcurrentId');
		var connectTimeout = Ext.getCmp('connectTimeoutId');
		var readTimeout = Ext.getCmp('readTimeoutId');
		var remoteUrl = Ext.getCmp('remoteUrlId');
		var fieldSet = Ext.getCmp('fieldSet');
		if(newValue==-1){
			fieldSet.removeAll();
			var _textfield = Ext.create('Ext.form.FieldSet', {
						border : 0,
						layout : 'hbox',
						margin : '-10 5 -10 5',
						height : 50,
						items : [{
									xtype : 'textfield',
									padding : '0 5 0 5',
									fieldLabel : '参数名称',
									labelAlign : 'right',
									allowBlank : false,
									value:'chainName',
									name : 'scheJobParamsList[' + i + '].name'
								}, {
									xtype : 'textfield',
									fieldLabel : '参数值',
									labelAlign : 'right',
									allowBlank : false,
									padding : '0 5 0 5',
									name : 'scheJobParamsList[' + i + '].value'
								}, {
									xtype : 'button',
									padding : '0 5 0 5',
									text : '删除',
									handler : function(btn) {
										var FieldSetDown = btn.ownerCt;
										var parentF = FieldSetDown.ownerCt;
										parentF.remove(FieldSetDown);
									}
								}]
					});
			i++;
			Ext.getCmp('fieldSet').add(_textfield);
//			isAllowConcurrent.setValue("1");
//			isAllowConcurrent.items.items[0].checked=true;
//			console.dir(isAllowConcurrent.items.items[0].checked);
			isAllowConcurrent.hide();
			connectTimeout.hide();
			readTimeout.hide();
			remoteUrl.hide();
		}else{
			fieldSet.removeAll();
			isAllowConcurrent.show();
			connectTimeout.show();
			readTimeout.show();
			remoteUrl.show();
		}
	},
	/**
	 * grid中选中按钮事件
	 * @param {} btn
	 * @param {} e
	 * @param {} eOpts
	 */
	selectJobGrid:function(btn, e, eOpts) {
		var jobId;
		if(!Ext.isEmpty(Ext.getCmp('workFlowJobWindow').jobId)){
			jobId = Ext.getCmp('workFlowJobWindow').jobId;
		}
//		console.dir(jobId);
		var me = this;
//		console.dir(me);
		var grid = me.getJobGrid();
		var selectionModel = grid.getSelectionModel();
		var selectedKeys = selectionModel.getSelection();
		//如果没有选择数据
		if (selectedKeys.length <= 0) {
			Ext.MessageBox.alert('提示', '至少选择一个任务！');
		//如果有选择数据
		} else{
			var resumeIds = [];
//			alert(selectedKeys[0].data.id);
			Pointer.pointerAddNode(jobId,selectedKeys[0].data.id);
			//遍历选择行的数据
			Ext.Array.each(selectedKeys,function(datas){
				//找出暂停状态的id，并添加的resumeIds中
//				if(datas.data.status == 0){
					resumeIds.push(datas.data.id);
//				}
			});
		}
//		console.dir(Ext.getCmp('workFlowJobWindow'));
		Ext.getCmp('workFlowJobWindow').close();
	},
	/**
	 * 关闭打开的窗口
	 * @param {} btn 
	 * @param {} eOpts
	 */
	closeWindow:function(btn,  eOpts ){
		var me = this;
		btn.ownerCt.ownerCt.ownerCt.close();
	},
	/**
	 * 关闭编辑的窗口
	 * @param {} panel
	 * @param {} eOpts
	 */
	closeEditWindow:function(panel,  eOpts ){
		Ext.TaskManager.start(task);
	},
	/**
	 * 关闭添加的窗口
	 * @param {} panel
	 * @param {} eOpts
	 */
	closeAddWindow:function(panel,  eOpts ){
		Ext.TaskManager.start(task);
	},
	/**
	 * 渲染jobGrid时的处理事件
	 * @param {} grid  jobGrid
	 * @param {} eObj
	 */
	afterrenderJobGrid : function(grid, eObj) {
		var me = this;
		// 拿到cookie 中的值
		var refreshJobGridText = cp.get('refreshJobGridText');
		//判断是否为空，如果为空默认设置为10秒
		if(Ext.isEmpty(refreshJobGridText)){
			refreshJobGridText = 10;
		}
		//定义定时器
		grid.task = {
			run:function(){
				gridStore.load();//重新load数据
			},
			interval:refreshJobGridText*1000,
			scope:this
		};
		task = grid.task;
		//启动定时器
		Ext.TaskManager.start(grid.task);
		//得到jobGrid的设置刷新时间的文本框
		var textfieldJobGrid = Ext.getCmp('textfieldJobGridId');
		//设置为cookie中的值
		textfieldJobGrid.setValue(refreshJobGridText);
		// 得到jobGrid的store
		var gridStore = me.getJobGrid().getStore();
	},
	/**
	 * 定时器值改变时 触发的事件
	 * @param {} textfield 定时器的文本框
	 * @param {} value 新设置的值
	 * @param {} oldValue 老的值
	 * @param {} eOpts
	 */
	saveRefreshJobGrid : function(textfield, value, oldValue, eOpts) {
		var me = this;
		//check 信设置的值不为空并且大于4
		if (!Ext.isEmpty(value) && value >= 5) {
			//把新值设置到cookie中，保存起来
			cp.set('refreshJobGridText', value);
			// 销毁定时器
//			Ext.TaskManager.destroy();
			var grid = me.getJobGrid();
			var gridStore = grid.getStore();
			//得到提示的label
			var myFieldLabel = Ext.getCmp('myFieldLabelId');
			//更改label的文字
			myFieldLabel.setText('每隔' + value + '秒刷新数据');
			//重新设置定时器的时间
			if(!Ext.isEmpty(grid.task)){
				grid.task.interval = (value * 1000);
				Ext.TaskManager.start(grid.task);
			}
		}
	},
	/**
	 * 在jobGrid中选择一行时触发的事件
	 * @param {} grid jobGrid
	 * @param {} record 当前行的record
	 * @param {} item
	 * @param {} index
	 * @param {} eOpts
	 */
	rowclickJobGrid : function(grid, record, item, index, eOpts) {
		var me = this;
		var selection = grid.getSelection();//选择行数
		
		//判断选择行数是否大于0
		if(selection.length>0){
			Ext.TaskManager.stop(grid.view.ownerCt.task);
			
			var editJobGrid = Ext.getCmp('editJobGrid');//编辑
			var resumeJobGridBtn = Ext.getCmp('resumeJobGridBtnId');// 恢复
			var pauseJobGridBtn = Ext.getCmp('pauseJobGridBtnId');// 暂停
			//遍历选择的行数
			Ext.Array.each(selection,function(datas){
				//如果选择行的状态为停止。
				if(datas.data.status== 0){
					//启动恢复按钮
					resumeJobGridBtn.enable();
				}
				//如果选择的行为恢复。
				if(datas.data.status== 1){
					//启动停止按钮
					pauseJobGridBtn.enable();
				}
			});
			//只要有选择行就启动编辑按钮
			editJobGrid.enable();
		}
	},
	/**
	 * 当取消选择时触发
	 * @param {} grid jobGrid
	 * @param {} record 当前取消的record
	 * @param {} item
	 * @param {} index
	 * @param {} eOpts
	 */
	deselect : function(grid, record, item, index, eOpts) {
		var me = this;
		var selection = grid.getSelection();//选择行数
		var editJobGrid = Ext.getCmp('editJobGrid');
		var resumeJobGridBtn = Ext.getCmp('resumeJobGridBtnId');// 恢复
		var pauseJobGridBtn = Ext.getCmp('pauseJobGridBtnId');// 暂停
		
		if(selection.length>0){
			//停止恢复按钮
			resumeJobGridBtn.disable();
			//停止暂停按钮
			pauseJobGridBtn.disable();
			Ext.Array.each(selection,function(datas){
				if(datas.data.status== 0){
					resumeJobGridBtn.enable();
				}
				if(datas.data.status== 1){
					pauseJobGridBtn.enable();
				}
			});
		}else{
			Ext.TaskManager.start(task);
			//如果全部都取消完了，恢复、暂停、编辑按钮都变灰，同时启动定时器
			resumeJobGridBtn.disable();
			pauseJobGridBtn.disable();
			editJobGrid.disable();
		}
	},
	/**
	 * 弹出添加界面事件
	 * @param {} btn 添加按钮
	 * @param {} e
	 * @param {} eOpts
	 */
	addWindows : function(btn, e, eOpts) {
		var me = this;
		var grid = me.getJobGrid();
		var selectionModel = grid.getSelectionModel();
		var selectedKeys = selectionModel.getSelection();
		//如果没有选择一行数据
		if (selectedKeys.length == 0) {
			var win = Ext.create('banggo.view.taskManager.AddJobWindow');
			Ext.TaskManager.stop(grid.task);
			win.show();
		//如果选择了一行数据，就把此行数据复制到添加form中
		} else if (selectedKeys.length == 1) {
			var id = selectedKeys[0].data.id;
			//请求选择中的数据
			Ext.Ajax.request({
					url : 'job/retrive.htm',
					params : {
						jobId : id
					},
					success : function(response, opts) {
						var win = Ext.create('banggo.view.taskManager.AddJobWindow');
						var jobModel = Ext.decode(response.responseText);
						var creJobModel = Ext.create(
								'banggo.model.taskManager.JobModel',
								jobModel.job);
						creJobModel.data.jobGroup = '';//清空任务组名
						creJobModel.data.jobName = '';//清空任务名
						var form = me.getAddJobForm().getForm();
						form.loadRecord(creJobModel);
						Ext.TaskManager.stop(grid.task);
						win.show();
					},
					failure : function(response, opts) {
						var result = "";
						if (opts.result) {
							if (opts.result.errorMsg) {
								result = opts.result.errorMsg;
							}
						} else if (opts.response.responseText) {
							result = opts.response.responseText;
						} else {
							result = "无法获取服务器响应信息！";
						}
						Ext.MessageBox.alert("提示", "编辑失败!<br>" + result);
					}
				});
		} 
		//如果选择多条数据
		else {
//			Ext.TaskManager.destroy();
			Ext.MessageBox.alert('提示', '只能选择一条记录！');
		}
	},
	/**
	 * 弹出编辑界面事件 和弹出添加框雷同
	 * @param {} btn 编辑按钮
	 * @param {} e
	 * @param {} eOpts
	 */
	editWindows : function(btn, e, eOpts) {
		var me = this;
		var grid = me.getJobGrid();
		var selectionModel = grid.getSelectionModel();
		var selectedKeys = selectionModel.getSelection();
		if (selectedKeys.length != 1) {
			Ext.MessageBox.alert('提示', '只能选择一条记录！');
		} else if (selectedKeys.length == 1) {
			var id = selectedKeys[0].data.id;
			Ext.Ajax.request({
						url : 'job/retrive.htm',
						params : {
							jobId : id
						},
						success : function(response, opts) {
							var win = Ext
									.create('banggo.view.taskManager.EditJobWindow');
							var jobModel = Ext.decode(response.responseText);
							var creJobModel = Ext.create(
									'banggo.model.taskManager.JobModel',
									jobModel.job);
							var formPanel = me.getEditJobForm();
							var form = formPanel.getForm();
							form.loadRecord(creJobModel);
							var isAllowConcurrent = Ext.getCmp('isAllowConcurrentId');
							var connectTimeout = Ext.getCmp('connectTimeoutId');
							var readTimeout = Ext.getCmp('readTimeoutId');
							var remoteUrl = Ext.getCmp('remoteUrlId');
							var type = Ext.getCmp('type');
							if(type.value==-1){
								isAllowConcurrent.hide();
								connectTimeout.hide();
								readTimeout.hide();
								remoteUrl.hide();
							}
							win.show();
						},
						failure : function(response, opts) {
							var result = "";
							if (opts.result) {
								if (opts.result.errorMsg) {
									result = opts.result.errorMsg;
								}
							} else if (opts.response.responseText) {
								result = opts.response.responseText;
							} else {
								result = "无法获取服务器响应信息！";
							}
							Ext.MessageBox.alert("提示", "编辑失败!<br>" + result);
						}
					});
		}
	},
	/**
	 * 双击grid弹出编辑框 雷同楼上
	 * @param {} grid jobGrid
	 * @param {} record 双击的record
	 * @param {} item
	 * @param {} index
	 * @param {} e
	 * @param {} eOpts
	 */
	twoEditWindows : function(grid, record, item, index, e, eOpts) {
		var me = this;
		var id = record.data.id;
		Ext.Ajax.request({
					url : 'job/retrive.htm',
					params : {
						jobId : id
					},
					success : function(response, opts) {
						var editGrid = Ext.create('banggo.view.taskManager.EditJobForm',{jobId:id});
						var win = Ext.create('banggo.view.taskManager.EditJobWindow',{items : [editGrid]});
						var jobModel = Ext.decode(response.responseText);
						var creJobModel = Ext.create(
								'banggo.model.taskManager.JobModel',
								jobModel.job);
						var formPanel = me.getEditJobForm();
						var form = formPanel.getForm();
						form.loadRecord(creJobModel);
						//如果是任务链则隐藏这些域
						var isAllowConcurrent = Ext.getCmp('isAllowConcurrentId');
						var connectTimeout = Ext.getCmp('connectTimeoutId');
						var readTimeout = Ext.getCmp('readTimeoutId');
						var remoteUrl = Ext.getCmp('remoteUrlId');
						var type = Ext.getCmp('type');
						if(type.value==-1){
							isAllowConcurrent.hide();
							connectTimeout.hide();
							readTimeout.hide();
							remoteUrl.hide();
						}
						Ext.TaskManager.stop(grid.ownerCt.task);
						win.show();
					},
					failure : function(response, opts) {
						var result = "";
						if (opts.result) {
							if (opts.result.errorMsg) {
								result = opts.result.errorMsg;
							}
						} else if (opts.response.responseText) {
							result = opts.response.responseText;
						} else {
							result = "无法获取服务器响应信息！";
						}
						Ext.MessageBox.alert("提示", "编辑失败!<br>" + result);
					}
				});
	},
	/**
	 * 查询时间
	 * @param {} btn 查询按钮
	 * @param {} e
	 * @param {} eOpts
	 */
	queryForm : function(btn, e, eOpts) {
		var me = this;
		var form = btn.up('form').getForm();//jobForm
		var values = form.getValues();
		var jobGrid = me.getJobGrid();
		var gridStore = jobGrid.getStore();
		//更改当前页
		gridStore.currentPage = 1;
		gridStore.on('beforeload', function(store, options) {
					// 传递搜索变量给数据源
					gridStore.proxy.extraParams = values;
				});
		gridStore.load();
	},
	/**
	 * 清空form
	 * @param {} btn
	 * @param {} e
	 * @param {} eOpts
	 */
	resetForm : function(btn, e, eOpts) {
		var form = btn.up('form').getForm();
		form.reset();
	},
	/**
	 * jobForm中的添加触发事件
	 * @param {} btn
	 * @param {} e
	 * @param {} eOpts
	 */
	finishAdd : function(btn, e, eOpts) {
		var me = this;
		var form = btn.up('form').getForm();
		var formValues = form.getValues();
		if (form.isValid()) {
			form.submit({
				url : 'job/create.htm',
				method : 'POST',
				params : formValues,
				success : function(form, action) {
	//				console.dir(action.response.responseText);
					Ext.MessageBox.alert('提示', '添加成功');
					var jobGrid = me.getJobGrid().getStore().load();
					me.getAddJobWindow().close();
				},
				failure : function(form, action) {
					var ret = eval("("+action.response.responseText+")");
					Ext.MessageBox.alert('提示', ret.errorMsg);
				}
			});
		} else {
			//Ext.MessageBox.alert('提示', "请输入");
		}
	},
	/**
	 * 完成编辑触发的事件
	 * @param {} btn
	 * @param {} e
	 * @param {} eOpts
	 */
	finishEdit : function(btn, e, eOpts) {
		var me = this;
		var jobId;
		if(!Ext.isEmpty(Ext.getCmp('jobGrid').getSelectionModel().getSelection()[0])){
			jobId = Ext.getCmp('jobGrid').getSelectionModel().getSelection()[0].data.id;
		}
		if(!Ext.isEmpty(Ext.getCmp('editJobFormId').jobId)){
			jobId = Ext.getCmp('editJobFormId').jobId;
		}
		var form = btn.up('form').getForm();
		var values = form.getValues();
		values.id = jobId;
		form.submit({
					url : 'job/update.htm',
					method : 'POST',
					params : values,
					success : function(form, action) {
						Ext.MessageBox.alert('提示', '编辑成功');
						me.getJobGrid().getStore().load();
						me.getEditJobWindow().close();
					},
					failure : function(form, action) {
						var ret = eval("("+action.response.responseText+")");
						Ext.MessageBox.alert('提示', '编辑失败!<br>'+ret.errorMsg);
					}
				});
	},
	/**
	 * 删除参数事件
	 * @param {} btn jobform 中的删除参数按钮
	 * @param {} e
	 * @param {} eOpts
	 */
	deleteForm : function(btn, e, eOpts) {
		var _fieldSet = Ext.getCmp('fieldSet');
		var btnPr = btn.ownerCt;
		_fieldSet.remove(btnPr);
	},
	/**
	 * 删除grid的数据
	 * @param {} btn grid中的删除按钮
	 * @param {} e
	 * @param {} eOpts
	 */
	deleteJobGrid : function(btn, e, eOpts) {
		var me = this;
		var grid = me.getJobGrid();
		var selectionModel = grid.getSelectionModel();
		var selectedKeys = selectionModel.getSelection();
		if (selectedKeys.length == 0) {
			Ext.MessageBox.alert('提示', '至少选择一条数据！');
		} else {
			Ext.MessageBox.confirm("确认删除", "是否真的要删除", function(btn, text) {
						if (btn == 'yes') {
							var ids = [];
							Ext.Array.each(selectedKeys, function(record) {
								ids.push(record.get("id"));
							});
							Ext.Ajax.request({
										url : 'job/delete.htm',
										method : 'GET',
										params : {
											jobId : ids.join(",")
										},
										success : function(response, opts) {
											var resMsg = Ext.decode(response.responseText);
											if(resMsg.success){
												Ext.MessageBox.alert("提示", "删除成功!");
											}else{
												Ext.MessageBox.alert("提示", "删除失败!<br>"+resMsg.errorMsg);
											}
											grid.getStore().load();
										},
										failure : function(response, opts) {
											var result = "";
											if (opts.result) {
												if (opts.result.errorMsg) {
													result = opts.result.errorMsg;
												}
											} else if (opts.response.responseText) {
												result = opts.response.responseText;
											} else {
												result = "无法获取服务器响应信息！";
											}
											Ext.MessageBox.alert("提示", "删除失败!<br>" + result);
										}
									});
						}
					});
		}
	},
	
	/**
	 * grid中恢复按钮事件
	 * @param {} btn
	 * @param {} e
	 * @param {} eOpts
	 */
	resumeJobGrid : function(btn, e, eOpts) {
		var me = this;
		var grid = me.getJobGrid();
		var selectionModel = grid.getSelectionModel();
		var selectedKeys = selectionModel.getSelection();
		//如果没有选择数据
		if (selectedKeys.length <= 0) {
			Ext.MessageBox.alert('提示', '至少选择一个要暂停的任务！');
		//如果有选择数据
		} else{
			var resumeIds = [];
			//遍历选择行的数据
			Ext.Array.each(selectedKeys,function(datas){
				//找出暂停状态的id，并添加的resumeIds中
				if(datas.data.status == 0){
					resumeIds.push(datas.data.id);
				}
			});
			Ext.MessageBox.confirm("确定恢复","有"+resumeIds.length+"个是可恢复状态，是否要全部恢复？",function(btn,text){
				if(btn == 'yes'){
					var sucIndex =0;
					var failIndex =0;
					var _strs = '';
					//遍历resumeids
					Ext.Array.each(resumeIds,function(resumeId,index){
						//请求恢复接口
						Ext.Ajax.request({
							url:'job/resume.htm',
							method:'GET',
							params:{jobId:resumeId},
							callback :function(options ,success ,response ){
								var results = Ext.decode(response.responseText);
								//如果成功
								if(results.success == 'true'){
									sucIndex ++;
									Ext.MessageBox.alert('提示',"有"+sucIndex+"个任务成功");
									grid.getStore().load();
								//如果失败
								}else{
									_strs += results.errorMsg + "。<br/>";
									failIndex ++ ;
									Ext.MessageBox.alert('提示',"有"+failIndex+"个任务失败,<br/> "+_strs);
								}
							}
						});
					});
				}
			});
		}
	},
	/**
	 * 暂停按钮事件 雷同恢复事件
	 * @param {} btn grid中暂停按钮
	 * @param {} e
	 * @param {} eOpts
	 */
	pauseJobGrid : function(btn, e, eOpts) {
		var me = this;
		var grid = me.getJobGrid();
		var selectedKeys = grid.getSelectionModel().getSelection();
		if (selectedKeys.length <= 0) {
			Ext.MessageBox.alert('提示', '至少选择一个要暂停的任务！');
		}else{
			var pauseIds = [];
			Ext.Array.each(selectedKeys,function(datas){
				if(datas.data.status == 1){
					pauseIds.push(datas.data.id);
				}
			});
			sucIndex =0;
			var failIndex =0;
			var _strs = '';
			Ext.MessageBox.confirm("确定暂停","有"+pauseIds.length+"个是可暂停状态，是否要全部暂停？",function(btn,text){
				if(btn == 'yes'){
					Ext.Array.each(pauseIds,function(pauseId,index){
						Ext.Ajax.request({
							url:'job/pause.htm',
							method:'GET',
							params:{jobId:pauseId},
							callback :function(options ,success ,response ){
								var results = Ext.decode(response.responseText);
								if(results.success == 'true'){
									sucIndex ++;
									Ext.MessageBox.alert('提示',"有"+sucIndex+"个任务成功");
									grid.getStore().load();
								}else{
									_strs += results.errorMsg + "。<br/>";
									failIndex ++ ;
									Ext.MessageBox.alert('提示',"有"+failIndex+"个任务失败,<br/> "+_strs);
								}
							}
						});
//						console.dir(_strs);
					});
				}
			})
		}
	},
	/**
	 * 执行事件
	 * @param {} btn
	 * @param {} e
	 * @param {} eOpts
	 */
	runOnceJobGrid : function(btn, e, eOpts) {
		var me = this;
		var grid = me.getJobGrid();
		var selectionModel = grid.getSelectionModel();
		var selectedKeys = selectionModel.getSelection();
		if (selectedKeys.length != 1) {
			Ext.MessageBox.alert('提示', '只能选择一条记录！');
		} else if (selectedKeys.length == 1) {
			var ignoreConcurrent = false;
			var data = selectedKeys[0].data;
			var id = data.id;
			Ext.MessageBox.confirm("确认立即执行任务", "确认立即执行任务:" + data.jobName
							+ " ?", function(btn, text) {
						if (btn == 'yes') {
							//如果是并行，
							if (!Ext.isEmpty(data.isAllowConcurrent)
									&& data.isAllowConcurrent == 1) {
								Ext.Ajax.request({
											url : 'job/runOnce.htm',
											method : 'GET',
											params : {
												jobId : id
											},
											success : function(response, opts) {
												var resMsg = Ext.decode(response.responseText);
												if(resMsg.success){
													Ext.MessageBox.alert("提示", "执行成功!");
												}else{
													Ext.MessageBox.alert("提示", "执行失败!<br>"+resMsg.errorMsg);
												}
												grid.getStore().load();
											},
											failure : function(response, opts) {
												var result = "";
												if (opts.result) {
													if (opts.result.errorMsg) {
														result = opts.result.errorMsg;
													}
												} else if (opts.response.responseText) {
													result = opts.response.responseText;
												} else {
													result = "无法获取服务器响应信息！";
												}
												Ext.MessageBox.alert("提示", "执行失败!<br>" + result);
											}
										});
							//如果是串行
							} else {
								Ext.MessageBox.confirm("确认立即执行任务", "任务:"
												+ data.jobName + " 是否需要强制执行?",
										function(btn, text) {
											if (btn == 'yes') {
												ignoreConcurrent = true;
											}else{
												ignoreConcurrent = false;
												return;
											}
											Ext.Ajax.request({
													url : 'job/runOnce.htm',
													method : 'GET',
													params : {
														jobId : id,
														ignoreConcurrent : ignoreConcurrent
													},
													success : function(
															response, opts) {
														Ext.MessageBox.alert(
																'提示', '执行成功');
														grid.getStore().load();
													},
													failure : function(
															response, opts) {
														var result = "";
														if (opts.result) {
															if (opts.result.errorMsg) {
																result = opts.result.errorMsg;
															}
														} else if (opts.response.responseText) {
															result = opts.response.responseText;
														} else {
															result = "无法获取服务器响应信息！";
														}
														Ext.MessageBox.alert("提示", "执行失败!<br>" + result);
													}
												});
										});
							}
						}
					});
		}
	},
	/**
	 * 执行记录查询事件
	 * @param {} btn
	 * @param {} e
	 * @param {} eOpts
	 */
	runRecordJobGrid : function(btn, e, eOpts) {
		var me = this;
		var grid = me.getJobGrid();
		var selectionModel = grid.getSelectionModel();
		var selectedKeys = selectionModel.getSelection();
		if (selectedKeys.length == 0) {
			Ext.MessageBox.alert('提示', '至少选择一条查看！');
		} else if (selectedKeys.length > 0) {
			var contentTab = Ext.getCmp('ContentTabId');
			Ext.Array.each(selectedKeys, function(data, index) {
				var scheType = data.data.type;
				var n = Ext.getCmp('ScheExecRecordContentPanel_'+data.data.id);
				var scheExecRecordGrids;
					if (!n) {
						//任务类型为任务连
						if(scheType==-1){
							// 创建新的grid
							scheExecRecordGrids = Ext.create(
									'banggo.view.taskManager.WorkFlowExecuteGrid', {
										id : 'WorkFlowExecuteGrid_' + data.data.id,
										jobId : data.data.id,
//										jobName : data.data.jobName,
//										appName : data.data.appName,
//										jobGroup : data.data.jobGroup,
//										taskFlag:1,
//										task:task
									});
							//任务类型为远程调用
						}else if(scheType==1){
							scheExecRecordGrids = Ext.create(
									'banggo.view.taskManager.ScheExecRecordGrid', {
										id : 'ScheExecRecordGrid_' + data.data.id,
										jobId : data.data.id,
										jobName : data.data.jobName,
										appName : data.data.appName,
										jobGroup : data.data.jobGroup,
//										taskFlag:1,
//										task:task
									});
						}
						var pannels = contentTab.add({
									id : 'ScheExecRecordContentPanel_'+ data.data.id ,
									title : data.data.jobName + '-明细',
									closable : true,
									layout : 'fit',
									items : scheExecRecordGrids
								});
						contentTab.setActiveTab(pannels);
					} else {
						contentTab.setActiveTab(n);
					}
			});
		}
	},
	/**
	 * 添加参数事件
	 * @param {} btn
	 * @param {} e
	 * @param {} eOpts
	 */
	addParamAddJobForm : function(btn, e, eOpts) {
		var me = this;
		var _textfield = Ext.create('Ext.form.FieldSet', {
					border : 0,
					layout : 'hbox',
					margin : '-10 5 -10 5',
					height : 50,
					items : [{
								xtype : 'textfield',
								padding : '0 5 0 5',
								fieldLabel : '参数名称',
								labelAlign : 'right',
								allowBlank : false,
//								value:'chainName',
								name : 'scheJobParamsList[' + i + '].name'
							}, {
								xtype : 'textfield',
								fieldLabel : '参数值',
								labelAlign : 'right',
								allowBlank : false,
								padding : '0 5 0 5',
								name : 'scheJobParamsList[' + i + '].value'
							}, {
								xtype : 'button',
								padding : '0 5 0 5',
								text : '删除',
								handler : function(btn) {
									var FieldSetDown = btn.ownerCt;
									var parentF = FieldSetDown.ownerCt;
									parentF.remove(FieldSetDown);
								}
							}]
				});
		i++;
		Ext.getCmp('fieldSet').add(_textfield);
	},
	/**
	 * 编辑form渲染事件
	 * @param {} editGrid
	 * @param {} eOpts
	 */
	afterrenderEditForm : function(editGrid, eOpts) {
		var jobId;
		if(!Ext.isEmpty(Ext.getCmp('jobGrid').getSelectionModel().getSelection()[0])){
			jobId = Ext.getCmp('jobGrid').getSelectionModel().getSelection()[0].data.id;
		}
		if(!Ext.isEmpty(editGrid.jobId)){
			jobId = editGrid.jobId;
		}
		Ext.Ajax.request({
					url : 'job/paramData.htm',
					params : {
						jobId : jobId
					},
					success : function(response, opts) {
						var fieldSetAry = [];
						var paramData = Ext.decode(response.responseText).paramData;
						for (var index = 0; index < paramData.length; index++) {
							var fieldSets = Ext.create('Ext.form.FieldSet', {
										border : 0,
										layout : 'hbox',
										items : [{
											xtype : 'textfield',
											fieldLabel : '参数名称',
											labelAlign : 'right',
											value : paramData[index].name,
											name : 'scheJobParamsList[' + index
													+ '].name'
										}, {
											xtype : 'textfield',
											fieldLabel : '参数值',
											labelAlign : 'right',
											value : paramData[index].value,
											name : 'scheJobParamsList[' + index
													+ '].value'
										}, {
											xtype : 'button',
											padding : '0 5 0 5',
											text : '删除'
										}]
									});
							fieldSetAry.push(fieldSets);
						}
						//设置参数的初始序列号
						if(paramData.length>0){
							i = paramData.length;
						}
						Ext.getCmp('fieldSet').removeAll();
						Ext.getCmp('fieldSet').add(fieldSetAry);
					},
					failure : function(response, opts) {
						var result = "";
						if (opts.result) {
							if (opts.result.errorMsg) {
								result = opts.result.errorMsg;
							}
						} else if (opts.response.responseText) {
							result = opts.response.responseText;
						} else {
							result = "无法获取服务器响应信息！";
						}
						Ext.MessageBox.alert("提示", "添加失败!<br>" + result);
					}
				});
	},
	/**
	 * 添加form渲染事件
	 * @param {} addGrid
	 * @param {} eOpts
	 */
	afterrenderAddForm : function(addGrid, eOpts) {
		var jobId;
		if(!Ext.isEmpty(Ext.getCmp('jobGrid').getSelectionModel().getSelection()[0])){
			jobId = Ext.getCmp('jobGrid').getSelectionModel().getSelection()[0].data.id;
		}else{
			return;
		}
		Ext.Ajax.request({
					url : 'job/paramData.htm',
					params : {
						jobId : jobId
					},
					success : function(response, opts) {
						var fieldSetAry = [];
						var paramData = Ext.decode(response.responseText).paramData;
						for (var index = 0; index < paramData.length; index++) {
							var fieldSets = Ext.create('Ext.form.FieldSet', {
										border : 0,
										layout : 'hbox',
										items : [{
											xtype : 'textfield',
											fieldLabel : '参数名称',
											labelAlign : 'right',
											value : paramData[index].name,
											name : 'scheJobParamsList[' + index
													+ '].name'
										}, {
											xtype : 'textfield',
											fieldLabel : '参数值',
											labelAlign : 'right',
											value : paramData[index].value,
											name : 'scheJobParamsList[' + index
													+ '].value'
										}, {
											xtype : 'button',
											padding : '0 5 0 5',
											text : '删除'
										}]
									});
							fieldSetAry.push(fieldSets);
						}
						//设置参数的初始序列号
						if(paramData.length>0){
							i = paramData.length;
						}
						Ext.getCmp('fieldSet').removeAll();
						Ext.getCmp('fieldSet').add(fieldSetAry);
					},
					failure : function(response, opts) {
						var result = "";
						if (opts.result) {
							if (opts.result.errorMsg) {
								result = opts.result.errorMsg;
							}
						} else if (opts.response.responseText) {
							result = opts.response.responseText;
						} else {
							result = "无法获取服务器响应信息！";
						}
						Ext.MessageBox.alert("提示", "添加失败!<br>" + result);
					}
				});
	}
});