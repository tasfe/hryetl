var vlen = 50;
var left = 150;
var top = 100;
Ext.define('banggo.controller.taskManager.WorkFlowController', {
	extend : 'Ext.app.Controller',
	alias : 'widget.workFlowController',
	models : ['taskManager.WorkFlowModel','taskManager.WorkFlowExecuteModel'],
	stores : ['taskManager.ComboboxScheAppNamesStore','taskManager.WorkFlowStore','taskManager.WorkFlowExecuteStore'],
	views : ['taskManager.WorkFlowForm','taskManager.WorkFlowGrid','taskManager.AddWorkFlowForm','taskManager.AddWorkFlowWindow','taskManager.WorkFlowJobWindow',
	         'taskManager.WorkFlowExecuteForm','taskManager.WorkFlowExecuteGrid','taskManager.WorkFlowExecuteInfoForm','taskManager.WorkFlowExecuteInfoWindow',
	         'taskManager.WorkFlowSelectNodeGrid','taskManager.WorkFlowSelectNodeForm','taskManager.WorkFlowPanel'],
	refs : [{
				ref : 'WorkFlowForm',
				selector : 'workFlowForm'
			}, {
				ref : 'WorkFlowPanel',
				selector : 'workFlowPanel'
			}, {
				ref : 'WorkFlowExecuteForm',
				selector : 'workFlowExecuteForm'
			}, {
				ref : 'WorkFlowExecuteGrid',
				selector : 'workFlowExecuteGrid'
			},{
				ref : 'WorkFlowGrid',
				selector : 'workFlowGrid'
			}, {
				ref : 'AddWorkFlowForm',
				selector : 'addWorkFlowForm'
			}, {
				ref : 'AddWorkFlowWindow',
				selector : 'addWorkFlowWindow'
			}, {
				ref : 'WorkFlowSelectNodeGrid',
				selector : 'workFlowSelectNodeGrid'
			}, {
				ref : 'WorkFlowSelectNodeForm',
				selector : 'workFlowSelectNodeForm'
			}, {
				ref : 'WorkFlowExecuteInfoForm',
				selector : 'workFlowExecuteInfoForm'
			}, {
				ref : 'WorkFlowExecuteInfoWindow',
				selector : 'workFlowExecuteInfoWindow'
			}, {
				ref : 'WorkFlowJobWindow',
				selector : 'workFlowJobWindow'
			}],
	init : function() {
		var me = this;		
		me.control({
					// 弹出详情界面
					'workFlowGrid' : {
						itemdblclick : me.rowclickGridInfo//双击事件
					},
					// 弹出详情界面
					'workFlowExecuteGrid' : {
						itemdblclick : me.rowclickExecuteGridInfo//双击事件
					},
					// 选择节点双击默认选中
					'workFlowSelectNodeGrid' : {
						itemdblclick : me.rowclickSelectNodeGrid//双击事件
					},
					// 新增流程
					'workFlowGrid button[id=addWorkFlowBtn]' : {
						click : me.addWorkFlow
					},
					// 编辑流程
					'workFlowGrid button[id=editWorkFlowBtn]' : {
						click : me.editGridInfo
					},
					// 编辑流程
					'workFlowExecuteGrid button[text=编辑]' : {
						click : me.editGridInfo
					},
					// 删除流程
					'workFlowGrid button[id=deleteWorkFlowBtn]' : {
						click : me.deleteGridInfo
					},
					// 重置表单
					'workFlowForm button[id=resetWorkFlowFormBtnId]' : {
						click : me.resetForm
					},
					// 查询表单
					'workFlowForm button[id=requeyWorkFlowFormBtnId]' : {
						click : me.queryForm
					},
					// 显示聚合
					'addWorkFlowForm button[id=showAddWorkFlowFormBtnId]' : {
						click : me.showtogetNode
					},
					// 聚合节点
					'addWorkFlowForm button[id=togetAddWorkFlowFormBtnId]' : {
						click : me.togetNode
					},
					// 保存节点
					'addWorkFlowForm button[id=saveAddWorkFlowFormBtnId]' : {
						click : me.saveNode
					},
					// 重置节点
//					'addWorkFlowForm button[id=resetAddWorkFlowFormBtnId]' : {
//						click : me.resetNode
//					},
					// 关闭窗口
					'addWorkFlowForm button[id=closeAddWorkFlowFormBtnId]' : {
						click : me.closeNodeWin
					},
					//选择节点
					'workFlowSelectNodeGrid button[id=selectJobGridBtnId]' : {
						click : me.selectJobGrid
					},
					// 查询选择节点条件
					'workFlowSelectNodeForm button[id=requeyWorkFlowSelectFormBtnId]' : {
						click : me.querySelectNodeForm
					}
					,
					// 重置选择节点条件
					'workFlowSelectNodeForm button[id=resetWorkFlowSelectFormBtnId]' : {
						click : me.resetQueryNode
					}
					,// 节点执行记录
					'workFlowExecuteGrid button[text=节点执行记录]' : {
						click : me.runRecordExecuteGrid
					},
					// 重置执行情况表单
					'workFlowExecuteForm button[id=resetWorkFlowExecuteFormBtnId]' : {
						click : me.resetForm
					},
					// 查询执行情况表单
					'workFlowExecuteForm button[id=requeyWorkFlowExecuteFormBtnId]' : {
						click : me.queryExecuteForm
					},
					// 关闭任务链执行详情窗口
					'workFlowExecuteInfoForm button[id=closeWorkFlowExecuteInfoBtnId]' : {
						click : me.closeWorkFlowExecuteInfo
					}
				});
		me.callParent(arguments);
	},
	
	/**
	 *  选择节点双击默认选中
	 * @param {} btn 查询按钮
	 * @param {} e
	 * @param {} eOpts
	 */
	rowclickSelectNodeGrid :  function(grid, record, item, index, e, eOpts) {
			var me = this;
			var win = me.getWorkFlowJobWindow();
			//如果有选择数据添加一个节点
		    if(win.jobId){
				Pointer.pointerAddNode(win.jobId,record.data.id,record.data.jobName);
			//如果有选择数据聚合2个节点到一个节点
			}else if(win.togetFlag){
			    var p = win.selectCheckNodes;
			    console.dir(p);
				var ps = p.split(',');
				var newPointer = new Pointer(null, record.data.jobName);
				newPointer.setDataValue('jobId',record.data.id);
				for(var i in ps) {
					var o = ps[i];
					newPointer.addMergeSub(Pointer.get(o));
				}
				Pointer.displayAll();
			}
			win.close();
	},
	/**
	 * 显示聚合节点
	 * @param {} btn
	 * @param {} e
	 * @param {} eOpts
	 */
	showtogetNode : function(btn, e, eOpts) {
		Pointer.showCheckBox();
	},
	/**
	 * 聚合节点
	 * @param {} btn
	 * @param {} e
	 * @param {} eOpts
	 */
	togetNode : function(btn, e, eOpts) {
		var p = Pointer.getSelectedCheckBoxes();
		if(p){
			var win = Ext.create('banggo.view.taskManager.WorkFlowJobWindow',{togetFlag:true,selectCheckNodes:p});
			win.show();
		}
	},
	/**
	 * 关闭form
	 * @param {} btn
	 * @param {} e
	 * @param {} eOpts
	 */
	closeWorkFlowExecuteInfo : function(btn, e, eOpts) {
		var me = this;
		me.getWorkFlowExecuteInfoWindow().close();
	},
	/**
	 * 任务链执行情况详情
	 * @param {} btn 查询按钮
	 * @param {} e
	 * @param {} eOpts
	 */
	rowclickExecuteGridInfo : function(button, data, eOpts) {
		var win = Ext.create('banggo.view.taskManager.WorkFlowExecuteInfoWindow');
		var me = this;
		var formPanel = me.getWorkFlowExecuteInfoForm();
		var form = formPanel.getForm();
		form.loadRecord(data);
//		Ext.TaskManager.stop(button.ownerCt.task);
		win.show();
	},
	/**
	 * 查询时间
	 * @param {} btn 查询按钮
	 * @param {} e
	 * @param {} eOpts
	 */
	queryExecuteForm : function(btn, e, eOpts) {
		var me = this;
		var form = me.getWorkFlowExecuteForm();//jobForm
		var values = form.getValues();
		var grid = me.getWorkFlowExecuteGrid();
		var store = grid.getStore();
		store.currentPage = 1;
		store.on('beforeload', function(store, options) {
					// 传递搜索变量给数据源
					store.proxy.extraParams = values;
				});
		store.load();
	},
	/**
	 * 执行记录查询事件
	 * @param {} btn
	 * @param {} e
	 * @param {} eOpts
	 */
	runRecordExecuteGrid : function(btn, e, eOpts) {
		var me = this;
		var grid = btn.ownerCt.ownerCt;
		var selectionModel = grid.getSelectionModel();
		var selectedKeys = selectionModel.getSelection();
		if (selectedKeys.length == 0) {
			Ext.MessageBox.alert('提示', '至少选择一条查看！');
		} else if (selectedKeys.length > 0) {
			var contentTab = Ext.getCmp('ContentTabId');
			Ext.Array.each(selectedKeys, function(data, index) {
				var n = Ext.getCmp('ScheExecRecordContentPanel_'+data.data.execNo);
				if (!n) {
					// 创建新的grid
					var scheExecRecordGrids = Ext.create(
							'banggo.view.taskManager.ScheExecRecordGrid', {
								id : 'ScheExecRecordGrid_' + data.data.execNo,
								scheChainExecuteId : data.data.id
							});
					var pannels = contentTab.add({
								id : 'ScheExecRecordContentPanel_'+ data.data.execNo ,
								title : data.data.execNo + '-明细',
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
	 * grid中选中删除按钮事件
	 * @param {} btn
	 * @param {} e
	 * @param {} eOpts
	 */
	deleteGridInfo:function(btn, e, eOpts) {
//		console.dir(jobId);
		var me = this;
//		console.dir(me);
		var grid = me.getWorkFlowGrid();
		var selectionModel = grid.getSelectionModel();
		var selectedKeys = selectionModel.getSelection();
		//如果没有选择数据
		if (selectedKeys.length <= 0) {
			Ext.MessageBox.alert('提示', '请选择一个任务！');
		//如果有选择数据
		} else{
			//请求选择中的数据
			var ids = [];
			Ext.Array.each(selectedKeys, function(record) {
//				console.dir(record.get("id"));
				ids.push(record.get("id"));
			});
			Ext.Ajax.request({
					url : 'chain/delete.htm',
					params : {
						scheChainId : ids.join(",")
					},
					success : function(response, opts) {
						Ext.MessageBox.alert("提示", "删除成功!");
						me.queryForm(btn,e,eOpts);
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
	 * grid中选中编辑按钮事件
	 * @param {} btn
	 * @param {} e
	 * @param {} eOpts
	 */
	editGridInfo:function(btn, e, eOpts) {
		var me = this;
		var grid = btn.ownerCt.ownerCt;
		var selectionModel = grid.getSelectionModel();
		var selectedKeys = selectionModel.getSelection();
		//如果没有选择数据
		if (selectedKeys.length != 1) {
			Ext.MessageBox.alert('提示', '请选择一个任务！');
		//如果有选择数据
		} else{
			//任务琏执行情况入口
			var scheChainId =  selectedKeys[0].data.scheChainId;
			var scheChainVersion = selectedKeys[0].data.scheChainVersion;
			//任务链管理入口
			if(!scheChainId){
				scheChainId =  selectedKeys[0].data.id;
				scheChainVersion = selectedKeys[0].data.version;
			}
			Pointer.clearAll();
			Pointer.setParameter({ vLen : vlen, left : left, top : 100});
			var win = Ext.create('banggo.view.taskManager.AddWorkFlowWindow',{editFlag:true});
			win.show();

			//添加滚动条样式
			var styleCss = document.getElementById("fieldSetFlowId").style.cssText;
			document.getElementById("fieldSetFlowId").style.cssText=styleCss+"overflow:auto;";
			
			//请求选择中的数据
			Ext.Ajax.request({
					url : 'chain/retrive.htm',
					params : {
						scheChainId : scheChainId,
						version : scheChainVersion
					},
					success : function(response, opts) {
						//构建表头
						var chainModel = Ext.decode(response.responseText);
//						console.dir(chainModel.scheChain);						
						var creFormModel = Ext.create(
								'banggo.model.taskManager.WorkFlowModel',
								chainModel.scheChain);
						var formPanel = me.getAddWorkFlowForm();
						var form = formPanel.getForm();
						form.loadRecord(creFormModel);
						//判断版本是否最新 最新的可以编辑 否则不可以编辑
						var showbtn = Ext.getCmp('showAddWorkFlowFormBtnId');
						var togetbtn = Ext.getCmp('togetAddWorkFlowFormBtnId');
						var savebtn = Ext.getCmp('saveAddWorkFlowFormBtnId');
//						var resetbtn = Ext.getCmp('resetAddWorkFlowFormBtnId');
						if(chainModel.scheChain.version!=scheChainVersion){
							showbtn.hide();
							togetbtn.hide();
							savebtn.hide();
							resetbtn.hide();
						}
						//构建树
						response = Ext.JSON.decode(response.responseText);  	
//						console.dir(Pointer.jsonToString(response.memberTree));
//						var tree = '{"name":"-999","type":"normal","data":{"jobId":"-999","terminateOnError": null},"info":"start","left": null,"right":{"name":"83","type":"barrier","data":{"jobId":"83","terminateOnError": null},"info":"job_stat_by_day_all_in_one:eye","left":{"name":"85","type":"barrier","data":{"jobId":"85","terminateOnError": null},"info":"job_flowrate_pvuv_ceshi:eye","left":{"name":"90","type":"barrier","data":{"jobId":"90","terminateOnError": null},"info":"testKzw:eye","left": null,"right": null},"right": null},"right": null}}';
						var	pointerTree = Pointer.createFromB_Tree(response.memberTree);
						pointerTree.displayAll();
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
	 * 查询时间
	 * @param {} btn 查询按钮
	 * @param {} e
	 * @param {} eOpts
	 */
	querySelectNodeForm : function(btn, e, eOpts) {
		var me = this;
		var form = btn.up('form').getForm();//jobForm
		var values = form.getValues();
		var jobGrid = me.getWorkFlowSelectNodeGrid();
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
	 * grid中选中按钮事件
	 * @param {} btn
	 * @param {} e
	 * @param {} eOpts
	 */
	selectJobGrid:function(btn, e, eOpts) {
		var me = this;
		var win = me.getWorkFlowJobWindow();
//		var jobId;
//		if(!Ext.isEmpty(win.jobId)){
//			jobId = win.jobId;
//		}
//	
		var grid = me.getWorkFlowSelectNodeGrid();
		var selectionModel = grid.getSelectionModel();
		var selectedKeys = selectionModel.getSelection();
		//如果没有选择数据
		if (selectedKeys.length <= 0) {
			Ext.MessageBox.alert('提示', '至少选择一个任务！');
		//如果有选择数据添加一个节点
		} else if(win.jobId){
			Pointer.pointerAddNode(win.jobId,selectedKeys[0].data.id,selectedKeys[0].data.jobName);
		//如果有选择数据聚合2个节点到一个节点
		}else if(win.togetFlag){
		    var p = win.selectCheckNodes;
//		    console.dir(p);
			var ps = p.split(',');
			var newPointer = new Pointer(null, selectedKeys[0].data.jobName);
			newPointer.setDataValue('jobId',selectedKeys[0].data.id);
			for(var i in ps) {
				var o = ps[i];
				newPointer.addMergeSub(Pointer.get(o));
			}
			Pointer.displayAll();
		}

		win.close();
	},
	/**
	 * 保存节点
	 * @param {} btn 查询按钮
	 * @param {} e
	 * @param {} eOpts
	 */
	saveNode : function(btn, e, eOpts) {
		var me = this;
		var formUrl;
		var msgSuccess;
		var form = btn.up('form').getForm();//jobForm
		var win = me.getAddWorkFlowWindow();
		if(win.editFlag){
			formUrl = 'chain/update.htm';
			msgSuccess = "更新成功！";
		}else{
			formUrl = 'chain/create.htm';
			msgSuccess = "添加成功！";
		}
		var values = form.getValues();
		if(values.chainName==''){
			Ext.MessageBox.alert("提示", "任务链名称不能为空!");
			return;
		}
		var tree = Pointer.getB_Tree();
		
//		console.dir(Pointer.jsonToString(tree));
		
		//请求选择中的数据
		form.submit({
			url : formUrl,
			method : 'POST',
			params : {
				scheChainName : values.chainName,
				memberTree:Pointer.jsonToString(tree),
				currentVersion : values.version,
				scheChainId : values.id
			},
			success : function(form, action) {
				Ext.MessageBox.alert('提示',msgSuccess );
			    me.getWorkFlowGrid().getStore().load();
				me.getAddWorkFlowWindow().close();
			},
			failure : function(response, opts) {
				var result = "";
				if (opts.result) {
					if (opts.result.errorMsg) {
						result = opts.result.errorMsg;
					}
				} else {
					result = "无法获取服务器响应信息！";
				}
				Ext.MessageBox.alert("提示", "编辑失败!<br>"+result);
			}

		});
	},
	/**
	 * 新增
	 * @param {} btn 新增
	 * @param {} e
	 * @param {} eOpts
	 */
	addWorkFlow : function(button, data, eOpts) {
		var win = Ext.create('banggo.view.taskManager.AddWorkFlowWindow');
		var me = this;
		win.show();
		Pointer.clearAll();
		Pointer.setParameter({ vLen : vlen, left : left, top : 100});
		var str_tree = "{name:'-999',type:'normal',data:{jobId:'-999'},info:'start',left:null,right:null}";
		var tree_json = Ext.decode(str_tree);
		var	pointerTree = Pointer.createFromB_Tree(tree_json);
		pointerTree.displayAll();
		
	},	
	/**
	 * 双击弹出详情页
	 * @param {} btn 双击弹出详情页
	 * @param {} e
	 * @param {} eOpts
	 */
	rowclickGridInfo : function(grid, record, item, index, e, eOpts) {
		var win = Ext.create('banggo.view.taskManager.AddWorkFlowWindow',{editFlag:true});
		var me = this;
		win.show();
		//添加滚动条样式
		var styleCss = document.getElementById("fieldSetFlowId").style.cssText;
		document.getElementById("fieldSetFlowId").style.cssText=styleCss+"overflow:auto;";
//		console.dir(record.data.id);
//		console.dir(record.data.version);
		//请求选择中的数据
		Ext.Ajax.request({
				url : 'chain/retrive.htm',
				params : {
					scheChainId : record.data.id,
					version:record.data.version
				},
				success : function(response, opts) {
					//构建表头
					var chainModel = Ext.decode(response.responseText);
//					console.dir(chainModel.scheChain);
					var creFormModel = Ext.create(
							'banggo.model.taskManager.WorkFlowModel',
							chainModel.scheChain);
					var formPanel = me.getAddWorkFlowForm();
					var form = formPanel.getForm();
					form.loadRecord(creFormModel);
					//构建树
					Pointer.clearAll();
					Pointer.setParameter({ vLen : vlen, left : left, top : 100});
					response = Ext.JSON.decode(response.responseText);  	
//					console.dir(Pointer.jsonToString(response.memberTree));
//					var tree = '{"name":"-999","type":"normal","data":{"jobId":"-999","terminateOnError": null},"info":"start","left": null,"right":{"name":"72","type":"barrier","data":{"jobId":"72","terminateOnError": null},"info":"hgjdfghss:5sdfgsd","left":{"name":"85","type":"barrier","data":{"jobId":"85","terminateOnError": null},"info":"job_flowrate_pvuv_ceshi:eye","left":{"name":"93","type":"barrier","data":{"jobId":"93","terminateOnError": null},"info":"chain:chain","left":{"name":"95","type":"barrier","data":{"jobId":"95","terminateOnError": null},"info":"MyOrderTask:eyes","left": null,"right": null},"right":{"name":"83","type":"barrier","data":{"jobId":"83","terminateOnError": null},"info":"job_stat_by_day_all_in_one:eye","left": null,"right": null}},"right": null},"right": null}}';
					var	pointerTree = Pointer.createFromB_Tree(response.memberTree);
					pointerTree.displayAll();
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
		var form = me.getWorkFlowForm();//jobForm
		var values = form.getValues();
		var grid = me.getWorkFlowGrid();
		var store = grid.getStore();
		store.currentPage = 1;
		store.on('beforeload', function(store, options) {
					// 传递搜索变量给数据源
					store.proxy.extraParams = values;
				});
		store.load();
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
	 * 清空form
	 * @param {} btn
	 * @param {} e
	 * @param {} eOpts
	 */
	resetNode : function(btn, e, eOpts) {
		var form = btn.up('form').getForm();
		form.reset();
	},
	/**
	 * 关闭form
	 * @param {} btn
	 * @param {} e
	 * @param {} eOpts
	 */
	closeNodeWin : function(btn, e, eOpts) {
		var me = this;
		me.getAddWorkFlowWindow().close();
	},
	/**
	 * 清空form
	 * @param {} btn
	 * @param {} e
	 * @param {} eOpts
	 */
	resetQueryNode : function(btn, e, eOpts) {
		var form = btn.up('form').getForm();
		form.reset();
	}
});

