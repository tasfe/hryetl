Ext.define('banggo.controller.taskManager.UserGroupController', {
	extend : 'Ext.app.Controller',
	models : ['taskManager.UserGroupModel','taskManager.ScheUserModel'],
	stores : ['taskManager.UserGroupStore','taskManager.ScheUserStore'],
	views : ['content.UserGroupContentPanel', 'taskManager.UserGroupForm',
			'taskManager.UserGroupGrid','taskManager.AddUserGroupForm',
			'taskManager.AddUserGroupWindow','taskManager.EditUserGroupWindow',
			'taskManager.EditUserGroupForm','taskManager.AddUserForm',
			'taskManager.AddUserWindow','taskManager.SearchUserForm',
			'taskManager.SearchUserWindow'],
	refs : [{
				ref : 'UserGroupGrid',
				selector : 'userGroupGrid'
			},{
				ref : 'UserGroupForm',
				selector : 'userGroupForm'
			},{
				ref : 'UserGroupContentPanel',
				selector : 'userGroupContentPanel'
			},{
				ref : 'AddUserGroupForm',
				selector : 'addUserGroupForm'
			},{
				ref : 'AddUserGroupWindow',
				selector : 'addUserGroupWindow'
			},{
				ref : 'EditUserGroupForm',
				selector : 'editUserGroupForm'
			},{
				ref : 'EditUserGroupWindow',
				selector : 'editUserGroupWindow'
			},{
				ref : 'AddUserForm',
				selector : 'addUserForm'
			},{
				ref : 'AddUserWindow',
				selector : 'addUserWindow'
			},{
				ref : 'SearchUserForm',
				selector : 'searchUserForm'
			},{
				ref : 'SearchUserWindow',
				selector : 'searchUserWindow'
			}],
	init : function() {
		var me = this;
		me.control({
			// 根据条件查询
			'userGroupForm button[id=requeyUserGroupFormBtnId]' : {
				click : me.queryForm
			},
			// 添加事件
			'addUserGroupForm button[id=finishAddUserGroupFormId]' : {
				click : me.finishAdd
			},
			// 获取选中查询用户事件
			'searchUserForm button[id=finishSearchUserFormId]' : {
				click : me.finishSearchUserAdd
			},
			// 新增用户事件
			'addUserForm button[id=finishAddUserFormId]' : {
				click : me.finishUserAdd
			},
			// 新增用户事件
			'editUserForm button[id=finishEditUserFormId]' : {
				click : me.editUserAdd
			},
			// 弹出新增用界面户
			'addUserGroupForm button[id=AddUserFormId]' : {
				click : me.addUserWindows
			},
			// 弹出修改用界面户
			'addUserGroupForm button[id=EditUserFormId]' : {
				click : me.editUserWindows
			},
			// 弹出新增用界面户
			'editUserGroupForm button[id=AddUserFormId]' : {
				click : me.addUserWindows
			},
			// 弹出修改用界面户
			'editUserGroupForm button[id=EditUserFormId]' : {
				click : me.editUserWindows
			},
			// 弹出查询用户界面
			'addUserForm button[id=searchAddUserFormId]' : {
				click : me.searchAuthUser
			},
			// 弹出添加界面
			'userGroupGrid button[id=addUserGroupGridBtnId]' : {
				click : me.addWindows
			},
			// 修改事件
			'userGroupGrid button[id=updateUserGroupGridBtnId]' : {
				click : me.editWindows
			},
			// 删除事件
			'userGroupGrid button[id=deleteUserGroupGridBtnId]' : {
				click : me.deleteGrid
			},
			// 选择gird行触发事件
			'userGroupGrid' : {
				itemdblclick : me.twoEditWindows,//双击弹出编辑窗口
				select : me.rowclickJobGrid,//选择行
				deselect :me.deselect,//取消选择行
				afterrender : me.afterrenderJobGrid//开始渲染grid
			},
			// 修改事件
			'editUserGroupForm button[id=finishEditUserGroupFormId]' : {
				click : me.finishEdit
			},
			// 重置表单
			'userGroupForm button[id=resetUserGroupFormBtnId]' : {
				click : me.resetForm
			},
			// 重置新增表单
			'addUserGroupForm button[id=resetAddUserGroupFormBtnId]' : {
				click : me.resetForm
			},// 重置新增用户表单
			'addUserForm button[id=resetAddUserFormBtnId]' : {
				click : me.resetForm
			},
			// 关闭添加窗口
			'addUserGroupWindow' : {
				close : me.closeAddWindow
			},
			// 关闭窗口
			'addUserGroupForm button[id=closeAddUserGroupFormBtnId]' : {
				click : me.closeWindow
			},
			// 关闭修改窗口
			'editUserGroupWindow' : {
				close : me.closeAddWindow
			},
			// 关闭修改窗口
			'editUserGroupForm button[id=closeEditUserGroupFormBtnId]' : {
				click : me.closeWindow
			},
			// 关闭新增用户窗口
			'addUserForm button[id=closeAddUserFormBtnId]' : {
				click : me.closeWindow
			},
			// 关闭修改用户窗口
			'editUserForm button[id=closeEditUserFormBtnId]' : {
				click : me.closeWindow
			},
			// 关闭查询用户窗口
			'searchUserForm button[id=closeSearchUserFormBtnId]' : {
				click : me.closeWindow
			}
		});
		me.callParent(arguments);
	},
	/**
	 * 选中用户
	 * @param {} btn
	 * @param {} e
	 * @param {} eOpts
	 */
	finishSearchUserAdd : function(btn, e, eOpts) {
		var me = this;
		var form = btn.up('form').getForm();
		var record = form.findField("users").getValue();
		
		if (!record && record.length < 1) {
			Ext.MessageBox.alert('提示', '请选择一个用户或者关闭窗口');
		} else if (record.length > 1) {
			Ext.MessageBox.alert('提示', '只能选择一个用户');
		} else {
			var data = record[0];
			// 设置值
			var formPanel = me.getAddUserForm();
			var userform = formPanel.getForm();
			userform.findField("userName").setValue(data.userName);
			userform.findField("name").setValue(data.name);
			userform.findField("email").setValue(data.email);
			userform.findField("mobile").setValue(data.mobile);
			me.getSearchUserWindow().close();
		}
	},
	/**
	 * addUserGroupForm中的添加触发事件
	 * @param {} btn
	 * @param {} e
	 * @param {} eOpts
	 */
	finishAdd : function(btn, e, eOpts) {
		var me = this;
		var form = btn.up('form').getForm();
		
		var result = me.getFormParam(form);
		
		if (!result) {
			return result;
		}
		
		// 设置通知方式
		var formValues = form.getValues();
		
		form.submit({
			url : 'scheUserGroup/create.htm',
			method : 'POST',
			params : formValues,
			success : function(form, action) {
				Ext.MessageBox.alert('提示', '添加成功');
				me.getUserGroupGrid().getStore().load();
				me.getAddUserGroupWindow().close();
				me.afterrenderJobGrid();
			},
			failure : function(form, action) {
				var ret = eval("("+action.response.responseText+")");
				Ext.MessageBox.alert('提示', ret.errorMsg);
			}
		});
	},
	/**
	 * 保存用户
	 * @param {} btn
	 * @param {} e
	 * @param {} eOpts
	 */
	finishUserAdd : function(btn, e, eOpts) {
		var me = this;
		var form = btn.up('form').getForm();
		
		var result = me.getFormUserParam(form);
			
		if (!result) {
			return result;
		}
		
		// 设置通知方式
		var formValues = form.getValues();
		
		form.submit({
			url : 'scheUserGroup/createUser.htm',
			method : 'POST',
			params : formValues,
			success : function(form, action) {
				Ext.MessageBox.alert('提示', '添加成功');
				allScheUserData.load({callback:function(){
					scheUserData = [];
					var formPanel = me.getAddUserGroupForm();
					if (!formPanel) {
						formPanel = me.getEditUserGroupForm();
					}
					var form = formPanel.getForm();
					me.getUserData(form);
					me.getAddUserWindow().close();
				}})
			},
			failure : function(form, action) {
				var ret = eval("("+action.response.responseText+")");
				Ext.MessageBox.alert('提示', ret.errorMsg);
			}
		});
	},
	/**
	 * 修改用户
	 * @param {} btn
	 * @param {} e
	 * @param {} eOpts
	 */
	editUserAdd : function(btn, e, eOpts) {
		var me = this;
		var form = btn.up('form').getForm();
		
		var result = me.getFormUserParam(form);
			
		if (!result) {
			return result;
		}
		
		// 设置通知方式
		var formValues = form.getValues();
		
		form.submit({
			url : 'scheUserGroup/updateUser.htm',
			method : 'POST',
			params : formValues,
			success : function(form, action) {
				Ext.MessageBox.alert('提示', '修改成功');
				allScheUserData.load({callback:function(){
					scheUserData = [];
					var formPanel = me.getAddUserGroupForm();
					if (!formPanel) {
						formPanel = me.getEditUserGroupForm();
					}
					var form = formPanel.getForm();
					me.getUserData(form);
					Ext.getCmp('editUserWindowId').close();
				}})
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
		
		var scheUserGroupId = 0;
		// 选择了单行修改
		if(!Ext.isEmpty(Ext.getCmp('userGroupGrid').getSelectionModel().getSelection()[0])){
			scheUserGroupId = Ext.getCmp('userGroupGrid').getSelectionModel().getSelection()[0].data.id;
		}
		
		// 获取双击修改
		if(!Ext.isEmpty(Ext.getCmp('editUserGroupFormId').scheUserGroupId)){
			scheUserGroupId = Ext.getCmp('editUserGroupFormId').scheUserGroupId;
		}
				
		var form = btn.up('form').getForm();
		var result = me.getFormParam(form);
		
		if (!result) {
			Ext.MessageBox.alert('提示', '用户组ID丢失');
			return result;
		}
		
		if (scheUserGroupId == 0) {
			return false;
		}
		
		
		var values = form.getValues();
		values.id = scheUserGroupId;
		form.submit({
			url : 'scheUserGroup/update.htm',
			method : 'POST',
			params : values,
			success : function(form, action) {
				Ext.MessageBox.alert('提示', '修改成功');
				me.getUserGroupGrid().getStore().load();
				me.getEditUserGroupWindow().close();
				me.afterrenderJobGrid();
			},
			failure : function(form, action) {
				var ret = eval("("+action.response.responseText+")");
				Ext.MessageBox.alert('提示', '修改失败!<br>'+ret.errorMsg);
			}
		});
	},
	getFormParam : function (form) {
		var html = "";
		// 判断
		var name = form.findField("name").getValue();
		if (!name) {
			html += "请输入用户组名称!";
		}
		// 选择用户
		var user = form.findField("userIds-field").getValue();
		if (!user) {
			if (html)
				html += "<br/>";
			html += "请选择用户!";
		}
		if (html) {
			Ext.MessageBox.alert('提示', html);
			return false;
		}
		
		return true;
	},
	getFormUserParam : function (form) {
		var html = "";
		// 判断
		var name = form.findField("name").getValue();
		if (!name) {
			html += "请输入用户名!";
		}
		// 选择用户
		var user = form.findField("userName").getValue();
		if (!user) {
			if (html)
				html += "<br/>";
			html += "请输入用户姓名!";
		}
		// 选择手机
		var user = form.findField("mobile").getValue();
		if (!user) {
			if (html)
				html += "<br/>";
			html += "请输入手机号码!";
		} else {
			if (!checkIsNum(user) || user.length != 11) {
				if (html)
					html += "<br/>";
				html += "请输入正确的手机号码!";
			} 
		}
		
		// 选择邮件
		var user = form.findField("email").getValue();
		if (!user) {
			if (html)
				html += "<br/>";
			html += "请输入邮箱!";
		} else {
			if (!checkEmail(user)) {
				if (html)
					html += "<br/>";
				html += "请输入正确的邮箱地址!";
			}
		}
		if (html) {
			Ext.MessageBox.alert('提示', html);
			return false;
		}
		
		return true;
	},
	/**
	 * 删除grid的数据
	 * @param {} btn grid中的删除按钮
	 * @param {} e
	 * @param {} eOpts
	 */
	deleteGrid : function(btn, e, eOpts) {
		var me = this;
		var grid = me.getUserGroupGrid();
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
						url : 'scheUserGroup/delete.htm',
						method : 'GET',
						params : {
							scheUserGroupId : ids.join(",")
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
	/**
	 * 弹出添加界面事件
	 * @param {} btn 添加按钮
	 * @param {} e
	 * @param {} eOpts
	 */
	addWindows : function(btn, e, eOpts) {
		var me = this;
		var win = Ext.create('banggo.view.taskManager.AddUserGroupWindow');
		var formPanel = me.getAddUserGroupForm();
		var form = formPanel.getForm();
		me.getUserData(form);
		win.show();
	},
	/**
	 * 弹出添加用户界面事件
	 * @param {} btn 添加按钮
	 * @param {} e
	 * @param {} eOpts
	 */
	addUserWindows : function(btn, e, eOpts) {
		var me = this;
		var win = Ext.create('banggo.view.taskManager.AddUserWindow');
		win.show();
	},
	/**
	 * 弹出修改用户界面事件
	 * @param {} btn 添加按钮
	 * @param {} e
	 * @param {} eOpts
	 */
	editUserWindows : function(btn, e, eOpts) {
		var me = this;
		var form = btn.up('form').getForm();
		var obj = form.findField("userIds");
		
		var fromList = obj.fromField.boundList;
		var selected = obj.getSelections(fromList);
		
		var leng = selected.length;
		
		if (leng < 1) {
			Ext.MessageBox.alert('提示', '请在可选择用户中选择一个用户！');
		} else if (leng == 1) {
			var win = Ext.create('banggo.view.taskManager.EditUserWindow');
			var editUserForm = Ext.getCmp('editUserFormId').getForm();
			var data = selected[0];
			
			editUserForm.findField("id").setValue(data.get("value"));
			editUserForm.findField("userName").setValue(data.get("userName"));
			editUserForm.findField("name").setValue(data.get("name"));
			editUserForm.findField("mobile").setValue(data.get("mobile"));
			editUserForm.findField("email").setValue(data.get("email"));
			win.show();
		} else if (leng > 1) {
			Ext.MessageBox.alert('提示', '只能选择一个用户！');
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
		var grid = me.getUserGroupGrid();
		var selectionModel = grid.getSelectionModel();
		var selectedKeys = selectionModel.getSelection();
		if (selectedKeys.length != 1) {
			Ext.MessageBox.alert('提示', '只能选择一条记录！');
		} else if (selectedKeys.length == 1) {
			me.commonEditWindows(selectedKeys[0]);
		}
		
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
		var form = btn.up('form').getForm();
		var values = form.getValues();
		var grid = me.getUserGroupGrid();
		var gridStore = grid.getStore();
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
	/**
	 * 渲染jobGrid时的处理事件
	 * @param {} grid  jobGrid
	 * @param {} eObj
	 */
	afterrenderJobGrid : function(grid, eObj) {
		var updateGridBtn = Ext.getCmp('updateUserGroupGridBtnId');//修改
		updateGridBtn.disable();
	},
	
	/**
	 * 选择一行时触发的事件
	 * @param {} grid jobGrid
	 * @param {} record 当前行的record
	 * @param {} item
	 * @param {} index
	 * @param {} eOpts
	 */
	rowclickJobGrid : function(grid, record, item, index, eOpts) {
		var me = this;
		var selection = grid.getSelection();//选择行数
		
		var updateGridBtn = Ext.getCmp('updateUserGroupGridBtnId');//修改
		
		//判断选择行数是否大于0
		if(selection.length>0){
			//只要有选择行就启动编辑按钮
			updateGridBtn.enable();
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
		var updateGridBtn = Ext.getCmp('updateUserGroupGridBtnId');//修改
	
		if(selection.length < 1){
			updateGridBtn.disable();
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
	// 获取任务用户信息
	getUserData : function (form) {
		if (scheUserData.length == 0) {
			var leng = allScheUserData.getCount();
			for (var i = 0; i < leng; i++) {
				var temp = allScheUserData.getAt(i);
				var id = temp.get("id");
				var name = temp.get("name");
				var userName = temp.get("userName");
				
				var tempData = [];
				tempData.push(id);
				tempData.push(name + "-" + userName);
				tempData.push(name);
				tempData.push(userName);
				tempData.push(temp.get("mobile"));
				tempData.push(temp.get("email"));
				
				scheUserData.push(tempData);
			}
		}
		
		ds = Ext.create('Ext.data.ArrayStore', {
	    	data: scheUserData,
	      	fields: ['value','text','name','userName','mobile','email'],
	      	sortInfo: {
	          	field: 'value',
	          	direction: 'ASC'
	      	}
	  	});
		
       	var obj = form.findField("userIds");
		var val = obj.getValue();		
  		obj.bindStore(ds);
  		obj.setValue(val);
	},
	// 编辑框
	commonEditWindows : function(record) {
		var me = this;
		var id = record.data.id;
		Ext.Ajax.request({
			url : 'scheUserGroup/retrive.htm',
			params : {
				scheUserGroupId : id
			},
			success : function(response, opts) {
				
				var userGroupModel = Ext.decode(response.responseText);
				var creUserGroupModel = Ext.create('banggo.model.taskManager.UserGroupModel',userGroupModel.scheUserGroup);
				
				var editForm = Ext.create('banggo.view.taskManager.EditUserGroupForm',{scheUserGroupId:userGroupModel.scheUserGroup.id});
				var win = Ext.create('banggo.view.taskManager.EditUserGroupWindow',{items : [editForm]});
				
				var formPanel = me.getEditUserGroupForm();
				var form = formPanel.getForm();
				form.loadRecord(creUserGroupModel);
				
				me.getUserData(form);
				
				// 获取已经选择的用户
				var memberList = userGroupModel.scheUserGroup.scheUserGroupMemberList;
				
				var userids = [];
				var length = memberList.length;
				for (var i = 0; i < length; i++) {
					var tempJson = memberList[i];
					userids.push(tempJson.scheUserId);
				}
				var obj = form.findField("userIds");
				obj.setValue(userids);
				
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
	// 查询用户
	searchAuthUser :function(btn, e, eOpts) {
		var me = this;
		var form = btn.up('form').getForm();
		
		var query = null;
		// 用户名或者姓名
		var userName = form.findField("userName").getValue();
		if (userName) {
			query = userName;
		} else {
			var name = form.findField("name").getValue();
			if (name) {
				query = name;
			} else {
				Ext.MessageBox.alert("提示", "请输入用户名或者姓名");
				return false;
			}
		}
		
		Ext.Ajax.request({
			url : 'scheUserGroup/queryUserFromAuthCenter.htm',
			params : {queryStr : query},
			success : function(response, opts) {
				
				var json = Ext.decode(response.responseText);
				var jsonData = json.topics;
				
				var length = jsonData ? jsonData.length : 0;
				
				if (length > 0) {
					if (length == 1) {
						var record = jsonData[0];
						form.findField("userName").setValue(record.userName);
						form.findField("name").setValue(record.name);
						form.findField("email").setValue(record.email);
						form.findField("mobile").setValue(record.mobile);
					} else {
						var userData = [];
						for (var i = 0; i < length; i++) {
							var temp = jsonData[i];
							
							var name = temp.name;
							var userName = temp.userName;
							
							var tempData = [];
							tempData.push(temp);
							tempData.push(name + "-" + userName);
							userData.push(tempData);
						}
						ds = Ext.create('Ext.data.ArrayStore', {
					    	data: userData,
					      	fields: ['value','text'],
					      	sortInfo: {
					          	field: 'value',
					          	direction: 'ASC'
					      	}
					  	});
					  	
					  	var win = Ext.create('banggo.view.taskManager.SearchUserWindow');
						var formPanel = me.getSearchUserForm();
						var searchform = formPanel.getForm();
				    	var obj = searchform.findField("users");
				  		obj.bindStore(ds);
						win.show();
					}
				} else {
					Ext.MessageBox.alert("提示", "没有查询到对应的记录！");
				}
			},
			failure : function(response, opts) {
				var result = "无法获取服务器响应信息！";
				Ext.MessageBox.alert("提示", result);
			}
		});
	}
});