Ext.define('banggo.controller.taskManager.WorkController', {
	extend : 'Ext.app.Controller',
	models : ['taskManager.WorkJobModel'],
	stores : ['taskManager.JobStore', 'taskManager.TaskManagerStore',
			'taskManager.ComboboxScheAppNamesStore',
			'taskManager.AllJobStore'],
	views : ['content.WorkContentPanel', 'taskManager.WorkJobForm',
			'taskManager.WorkJobGrid','taskManager.AddWorkJobForm',
			'taskManager.AddWorkJobWindow','taskManager.EditWorkJobWindow',
			'taskManager.EditWorkJobForm'],
	refs : [{
				ref : 'WorkJobGrid',
				selector : 'workJobGrid'
			},{
				ref : 'WorkJobForm',
				selector : 'workJobForm'
			},{
				ref : 'AddWorkJobForm',
				selector : 'addWorkJobForm'
			},{
				ref : 'AddWorkJobWindow',
				selector : 'addWorkJobWindow'
			},{
				ref : 'EditWorkJobForm',
				selector : 'editWorkJobForm'
			},{
				ref : 'EditWorkJobWindow',
				selector : 'editWorkJobWindow'
			},{
				ref : 'WorkContentPanel',
				selector : 'workContentPanel'
			}],
	init : function() {
		var me = this;
		me.control({
			// 弹出添加界面
			'workJobGrid button[id=addWorkJobGridBtnId]' : {
				click : me.addWindows
			},
			// 关闭添加窗口
			'addJobWindow' : {
				close : me.closeAddWindow
			},
			// 关闭窗口
			'addWorkJobForm button[id=closeAddWorkJobFormBtnId]' : {
				click : me.closeWindow
			},
			// 关闭修改窗口
			'editJobWindow' : {
				close : me.closeAddWindow
			},
			// 关闭修改窗口
			'editWorkJobForm button[id=closeEditWorkJobFormBtnId]' : {
				click : me.closeWindow
			},
			// 添加事件
			'addWorkJobForm button[id=finishAddWorkJobFormId]' : {
				click : me.finishAdd
			},
			// 修改事件
			'editWorkJobForm button[id=finishEditWorkJobFormId]' : {
				click : me.finishEdit
			},
			// 删除事件
			'workJobGrid button[id=deleteWorkJobGridBtnId]' : {
				click : me.deleteJobGrid
			},
			// 修改 
			'workJobGrid button[id=updateWorkJobGridBtnId]' : {
				click : me.editWindows
			},
			// 运行
			'workJobGrid button[id=runWorkJobGridBtnId]' : {
				click : me.runWorkJobGrid
			},
			// 停止
			'workJobGrid button[id=stopWorkJobGridBtnId]' : {
				click : me.stopWorkJobGrid
			},
			// 加载任务
			'workJobGrid button[id=joinWorkJobGridBtnId]' : {
				click : me.joinWorkJobGrid
			},
			// 选择gird行触发事件
			'workJobGrid' : {
				itemdblclick : me.twoEditWindows,//双击弹出编辑窗口
				select : me.rowclickJobGrid,//选择行
				deselect :me.deselect,//取消选择行
				afterrender : me.afterrenderJobGrid//开始渲染grid
			},
			// 根据条件查询
			'workJobForm button[id=requeyWorkJobFormBtnId]' : {
				click : me.queryForm
			},
			// 重置表单
			'workJobForm button[id=resetWorkJobFormBtnId]' : {
				click : me.resetForm
			},
			// 重置新增表单
			'addWorkJobForm button[id=resetAddWorkJobFormBtnId]' : {
				click : me.resetForm
			}
		});
		me.callParent(arguments);
	},
	joinWorkJobGrid : function() {
		Ext.getCmp("addWorkJobGridBtnId").disable();
		treeJobData.load({callback:function(){
			// 可以新增
			Ext.getCmp("addWorkJobGridBtnId").enable();
		}})
	},
	// 获取用户组信息|任务信息
	getUserGroupData : function() {
		userGroupTree2 = null;
		userGroupTreeStore = null;
		
		if (userGroupTreeStore == null) {
			// ajax请求
			Ext.Ajax.request({
				url : 'scheUserGroup/queryAllUserGroup.htm',
				//params : {},
				success : function(response, opts) {
					var json = Ext.decode(response.responseText);
					var jsonData = json.topics;
					
					var storeData = [];
					for (var i = 0; i < jsonData.length; i++) {
						var temp = jsonData[i];
						// 用户组
						var record = {};
						record.id = temp.id;
						record.text = temp.name;
						record.expanded = false;
						
						var userRecord = [];
						var userData = temp.scheUserGroupMemberList;
						
						for (var j = 0; j < userData.length; j++) {
							// 用户
							var tempUser = userData[j];
							var uRecord = {};
							
							var name = tempUser.scheUserName;
							var userName = tempUser.userName;
							
							if (name && userName) {
								uRecord.text = name + "-" + userName;
								uRecord.leaf = true;
								userRecord.push(uRecord);
							}
						}
						record.children = userRecord;
						storeData.push(record);
					}
					// 数据记录
					userGroupTreeStore = Ext.create('Ext.data.TreeStore', {
						isLocalMode:true,
						root: {
							expanded: true, 
							children: storeData
						}
					});
				},
				failure : function(response, opts) {
					var result = "无法获取服务器响应信息！";
					Ext.MessageBox.alert("提示", result);
				}
			});
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
		var win = Ext.create('banggo.view.taskManager.AddWorkJobWindow');
		me.getUserGroupData();
		win.show();
	},
	/**
	 * 关闭添加的窗口
	 * @param {} panel
	 * @param {} eOpts
	 */
	closeAddWindow:function(panel,  eOpts ){
		
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
	 * 查询
	 * @param {} btn 查询按钮
	 * @param {} e
	 * @param {} eOpts
	 */
	queryForm : function(btn, e, eOpts) {
		var me = this;
		var form = btn.up('form').getForm();//jobForm
		var values = form.getValues();
		var workJobGrid = me.getWorkJobGrid();
		var gridStore = workJobGrid.getStore();
		//更改当前页
		gridStore.currentPage = 1;
		gridStore.on('beforeload', function(store, options) {
			// 传递搜索变量给数据源
			gridStore.proxy.extraParams = values;
		});
		gridStore.load();
		me.afterrenderJobGrid();
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
	
	getAlarmMethod : function (form) {
	
		var html = "";
		// 判断
		var scheJobId = form.findField("scheJobId").getValue();
		if (!scheJobId) {
			html += "请选择任务名称!";
		}
		var scheUserGroupId = form.findField("scheUserGroupId").getValue();
		if (!scheUserGroupId) {
			if (html)
				html += "<br/>";
			html += "请选择用户组!";
		}
		var noticeType1 = form.findField("noticeType1").getValue();
		var noticeType2 = form.findField("noticeType2").getValue();
		var noticeDate = form.findField("noticeDate").getValue();
		
		if (!noticeType1 && !noticeType2) {
			if (html)
				html += "<br/>";
			html += "请选择通知方式!";
		}
		
		if (noticeType1 && !noticeDate) {
			if (html)
				html += "<br/>";
			html += "请选择短信通知的时间!";
		}
		
		var alarmMethod = "0";
		
		if (noticeType2) {
			// 邮件
			alarmMethod = "1";
		}
		
		if (noticeType1) {
			// 短信
			// 全天
			if (noticeDate == 1) {
				alarmMethod = "1" + alarmMethod;
			} else if (noticeDate == 2) {
				// 时间段
				alarmMethod = "10" + alarmMethod;
			}
		}
		if (alarmMethod) {
			var i = parseInt(alarmMethod, 2); 
			form.findField("alarmMethod").setValue(i);
		}
		
		var frequencyUnit = form.findField("frequencyUnit").getValue();
		var frequency = form.findField("frequency").getValue();
		
		if (!frequencyUnit) {
			if (html)
				html += "<br/>";
			html += "请选择通知频率!";
		}
		if (!frequency) {
			if (html)
				html += "<br/>";
			html += "请输入通知次数!";
		} else {
			if (!checkIsNum(frequency)) {
				if (html)
					html += "<br/>";
				html += "请输入正确的通知次数!";
			}
		}
		
		if (html) {
			Ext.MessageBox.alert('提示', html);
			return false;
		}
		return true;
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
		
		var result = me.getAlarmMethod(form);
		
		if (!result) {
			return result;
		}
		
		// 设置通知方式
		
		var formValues = form.getValues();
		
		form.submit({
			url : 'alarm/create.htm',
			method : 'POST',
			params : formValues,
			success : function(form, action) {
				Ext.MessageBox.alert('提示', '添加成功');
				var jobGrid = me.getWorkJobGrid().getStore().load();
				me.getAddWorkJobWindow().close();
				me.afterrenderJobGrid();
			},
			failure : function(form, action) {
				var ret = eval("("+action.response.responseText+")");
				Ext.MessageBox.alert('提示', ret.errorMsg);
			}
		});
	},
	/**
	 * 完成编辑触发的事件
	 * @param {} btn
	 * @param {} e
	 * @param {} eOpts
	 */
	finishEdit : function(btn, e, eOpts) {
		var me = this;
		var scheAlarmId = 0;
		// 选择了单行修改
		if(!Ext.isEmpty(Ext.getCmp('workJobGrid').getSelectionModel().getSelection()[0])){
			scheAlarmId = Ext.getCmp('workJobGrid').getSelectionModel().getSelection()[0].data.id;
		}
		
		// 获取双击修改
		if(!Ext.isEmpty(Ext.getCmp('editWorkJobFormId').scheAlarmId)){
			scheAlarmId = Ext.getCmp('editWorkJobFormId').scheAlarmId;
		}
		var form = btn.up('form').getForm();
		var result = me.getAlarmMethod(form);
		
		if (!result) {
			return result;
		}
		var values = form.getValues();
		values.id = scheAlarmId;
		form.submit({
			url : 'alarm/update.htm',
			method : 'POST',
			params : values,
			success : function(form, action) {
				Ext.MessageBox.alert('提示', '修改成功');
				me.getWorkJobGrid().getStore().load();
				me.getEditWorkJobWindow().close();
				me.afterrenderJobGrid();
			},
			failure : function(form, action) {
				var ret = eval("("+action.response.responseText+")");
				Ext.MessageBox.alert('提示', '修改失败!<br>'+ret.errorMsg);
			}
		});
	},
	/**
	 * 删除grid的数据
	 * @param {} btn grid中的删除按钮
	 * @param {} e
	 * @param {} eOpts
	 */
	deleteJobGrid : function(btn, e, eOpts) {
		var me = this;
		var grid = me.getWorkJobGrid();
		var selectionModel = grid.getSelectionModel();
		var selectedKeys = selectionModel.getSelection();
		if (selectedKeys.length == 0) {
			Ext.MessageBox.alert('提示', '至少选择一条记录！');
		} else {
			Ext.MessageBox.confirm("确认删除", "是否真的要删除", function(btn, text) {
				if (btn == 'yes') {
					var ids = [];
					Ext.Array.each(selectedKeys, function(record) {
						ids.push(record.get("id"));
					});
					Ext.Ajax.request({
						url : 'alarm/delete.htm',
						method : 'GET',
						params : {
							scheAlarmId : ids.join(",")
						},
						success : function(response, opts) {
							var resMsg = Ext.decode(response.responseText);
							if(resMsg.success){
								Ext.MessageBox.alert("提示", "删除成功!");
							}else{
								Ext.MessageBox.alert("提示", "删除失败!<br>"+resMsg.errorMsg);
							}
							grid.getStore().load();
							me.afterrenderJobGrid();
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
	// 状态更新方法
	statusWorkJobGrid : function(me, flag) {
		
		var grid = me.getWorkJobGrid();
		var selectionModel = grid.getSelectionModel();
		var selectedKeys = selectionModel.getSelection();
		//如果没有选择数据
		if (selectedKeys.length <= 0) {
			Ext.MessageBox.alert('提示', '至少选择一条记录！');
		} else{
			//如果有选择数据
			var runIds = [];
			
			var st = flag == 0 ? 1 : 0;
			//遍历选择行的数据
			Ext.Array.each(selectedKeys,function(datas){
				//找出状态的id，并添加的runIds中
				if(datas.data.status == st){
					runIds.push(datas.data.id);
				}
			});
			
			var leng = runIds.length;
			
			if (leng < 1) {
				Ext.MessageBox.alert('提示', '无可以操作的记录,请重新选择！');
				return false;
			}
			
			Ext.MessageBox.confirm("确定恢复","有"+leng+"条记录可以操作，是否要全部操作？",function(btn,text){
				if(btn == 'yes'){
					
					Ext.Ajax.request({
						url : 'alarm/updateStatus.htm',
						method : 'GET',
						params : {
							scheAlarmId:runIds.join(","),
							flag:flag
						},
						success : function(response, opts) {
							var resMsg = Ext.decode(response.responseText);
							if(resMsg.success){
								Ext.MessageBox.alert("提示", "操作成功!");
							}else{
								Ext.MessageBox.alert("提示", "操作失败!<br>"+resMsg.errorMsg);
							}
							grid.getStore().load();
							me.afterrenderJobGrid();
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
							Ext.MessageBox.alert("提示", "操作失败!<br>" + result);
						}
					});
				}
			});
		}
	},
	/**
	 * grid中运行按钮事件
	 * @param {} btn
	 * @param {} e
	 * @param {} eOpts
	 */
	runWorkJobGrid : function(btn, e, eOpts) {
		var me = this;
		me.statusWorkJobGrid(me, 1);
	},
	/**
	 * grid中停止按钮事件
	 * @param {} btn
	 * @param {} e
	 * @param {} eOpts
	 */
	stopWorkJobGrid : function(btn, e, eOpts) {
		var me = this;
		me.statusWorkJobGrid(me, 0);
	},
	/**
	 * 渲染jobGrid时的处理事件
	 * @param {} grid  jobGrid
	 * @param {} eObj
	 */
	afterrenderJobGrid : function(grid, eObj) {
		var editJobGrid = Ext.getCmp('updateWorkJobGridBtnId');//修改
		var runWorkJobGridBtn = Ext.getCmp('runWorkJobGridBtnId');// 运行
		var stopWorkJobGridBtn = Ext.getCmp('stopWorkJobGridBtnId');// 停止
		runWorkJobGridBtn.disable();
		stopWorkJobGridBtn.disable();
		editJobGrid.disable();
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
		
		var editJobGrid = Ext.getCmp('updateWorkJobGridBtnId');//修改
		var runWorkJobGridBtn = Ext.getCmp('runWorkJobGridBtnId');// 运行
		var stopWorkJobGridBtn = Ext.getCmp('stopWorkJobGridBtnId');// 停止
		
		//判断选择行数是否大于0
		if(selection.length>0){
			
			//遍历选择的行数
			Ext.Array.each(selection,function(datas){
				//如果选择行的状态为停止。
				if(datas.data.status== 0){
					//启动恢复按钮
					runWorkJobGridBtn.enable();
				}
				//如果选择的行为恢复。
				if(datas.data.status== 1){
					//启动停止按钮
					stopWorkJobGridBtn.enable();
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
		var editJobGrid = Ext.getCmp('updateWorkJobGridBtnId'); // 修改
		var runWorkJobGridBtn = Ext.getCmp('runWorkJobGridBtnId');// 运行
		var stopWorkJobGridBtn = Ext.getCmp('stopWorkJobGridBtnId');// 停止
		//停止恢复按钮
		runWorkJobGridBtn.disable();
		//停止暂停按钮
		stopWorkJobGridBtn.disable();
		if(selection.length>0){
			Ext.Array.each(selection,function(datas){
				if(datas.data.status== 0){
					runWorkJobGridBtn.enable();
				}
				if(datas.data.status== 1){
					stopWorkJobGridBtn.enable();
				}
			});
		}else{
			//如果全部都取消完了，恢复、暂停、编辑按钮都变灰，同时启动定时器
			runWorkJobGridBtn.disable();
			stopWorkJobGridBtn.disable();
			editJobGrid.disable();
		}
	},
	/**
	 * 弹出编辑界面事件
	 * @param {} btn 编辑按钮
	 * @param {} e
	 * @param {} eOpts
	 */
	editWindows : function(btn, e, eOpts) {
		var me = this;
		var grid = me.getWorkJobGrid();
		var selectionModel = grid.getSelectionModel();
		var selectedKeys = selectionModel.getSelection();
		if (selectedKeys.length != 1) {
			Ext.MessageBox.alert('提示', '只能选择一条记录！');
		} else if (selectedKeys.length == 1) {
			me.commonEditWindows(selectedKeys[0]);
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
		me.commonEditWindows(record);
	},
	// 编辑框
	commonEditWindows : function(record) {
		var me = this;
		var id = record.data.id;
		me.getUserGroupData();
		Ext.Ajax.request({
			url : 'alarm/retrive.htm',
			params : {
				scheAlarmId : id
			},
			success : function(response, opts) {
				var editGrid = Ext.create('banggo.view.taskManager.EditWorkJobForm',{scheAlarmId:id});
				var win = Ext.create('banggo.view.taskManager.EditWorkJobWindow',{items : [editGrid]});
				var workJobModel = Ext.decode(response.responseText);
				var creWorkJobModel = Ext.create('banggo.model.taskManager.WorkJobModel',workJobModel.scheAlarm);
				var formPanel = me.getEditWorkJobForm();
				var form = formPanel.getForm();
				form.loadRecord(creWorkJobModel);
				// 任务名
				form.findField("scheJobName").setValue(record.data.jobName);
				// 用户组
				form.findField("userGroupTreeName").setValue(record.data.groupName);
				// 通知方式
				var alarmMethod = record.data.alarmMethod;
				
				if (alarmMethod) {
					var result = parseInt(alarmMethod).toString(2); // 10进制转2进制
					
					// 邮件
					var res = result & 1;
					if (res == 1) {
						form.findField("noticeType2").setValue(true);
						var noticDate = form.findField("noticeDate");
						noticDate.disable();
					}
					// 短信全天
					res = result & 10;
					if (res > 1) {
						form.findField("noticeType1").setValue(true);
						var noticDate = form.findField("noticeDate");
						noticDate.enable();
						noticDate.setValue("1");
					}
					// 短信限时
					res = result & 100;
					if (res > 1) {
						form.findField("noticeType1").setValue(true);
						var noticDate = form.findField("noticeDate");
						noticDate.enable();
						noticDate.setValue("2");
					}
				} else {
					var noticDate = form.findField("noticeDate");
					noticDate.disable();
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
});