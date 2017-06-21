Ext.define('banggo.controller.taskManager.ScheExecRecordController', {
			extend : 'Ext.app.Controller',
			models : ['taskManager.ScheExecRecordModel'],
			stores : ['taskManager.ScheExceRecordStore', 'taskManager.TaskManagerStore',
					'taskManager.ComboboxScheAppNamesStore','taskManager.ComboxResultStore','taskManager.ComboxStatusStore'],
			views : ['content.ScheExecRecordContentPanel', 'taskManager.ScheExecRecordForm',
			         'taskManager.ScheExecRecordInfoWindow','taskManager.ScheExecRecordInfoForm',
					'taskManager.ScheExecRecordGrid','taskManager.EditScheExecRecordWindow','taskManager.EditScheExecRecordForm'
					,'banggo.view.menu.ContentTab'],
			refs : [{
						ref : 'ScheExecRecordGrid',
						selector : 'scheExecRecordGrid'
					},{
						ref : 'ScheExecRecordForm',
						selector : 'scheExecRecordForm'
					}, {
						ref : 'EditScheExecRecordForm',
						selector : 'editScheExecRecordForm'
					}, {
						ref : 'ScheExecRecordInfoForm',
						selector : 'scheExecRecordInfoForm'
					},{
						ref : 'ScheExecRecordInfoWindow',
						selector : 'scheExecRecordInfoWindow'
					},{
						ref : 'EditScheExecRecordWindow',
						selector : 'editScheExecRecordWindow'
					},{
						ref : 'ContentTab',
						selector : 'contentTab'
					}],
			init : function() {
				var me = this;
				i = 0;
				me.control(
							{
							// 弹出详情界面
							'scheExecRecordGrid' : {
								itemdblclick : me.rowclickGridInfo,//双击事件
								select: me.selectGridInfo,//选择一行
								deselect :me.deselectGridInfo,//取消选择行
								afterrender : me.beforerenderScheGrid//渲染之前
							},
							// 定时器值改变时
							'scheExecRecordGrid textfield[name=refreshScheGridText]' : {
								change : me.saveRefreshScheGrid
							},
							'scheExecRecordForm button[id=queryScheExecRecordId]' : {
								click : me.queryScheExecRecord
							}
							,'scheExecRecordForm button[id=resetBtnId]' : {
								click : me.resetClick
							}
							,'scheExecRecordGrid button[text = 编辑]' : {
								click : me.editScheExecRecord
							}
							,'scheExecRecordGrid button[text=详情]' : {
								click : me.jobGridInfo
							}
							,'scheExecRecordGrid button[text=终止]' : {
								click : me.terminalJobGrid
							}
							,'scheExecRecordInfoForm button[text=关闭]' : {
								click : me.btnSERIClose
							},
							'editScheExecRecordForm button[text=删除]' : {
								click : me.deleteForm
							},
							// 关闭编辑窗口
							'editScheExecRecordWindow' : {
								close : me.closeEditWindow
							},
							// 关闭详情窗口
							'scheExecRecordInfoWindow' : {
								close : me.closeInfoWindow
							},
							// 切换tab
							'contentTab' : {
								tabchange : me.tabchangeContent
							}
						});

				me.callParent(arguments);
			},
			tabchangeContent:function(tabPanel,  newCard, oldCard, eOpts){
				var value = 10;
				//定时器刷新控制
				if(!Ext.isEmpty(newCard.items.items[0]) && !Ext.isEmpty(newCard.items.items[0].items.items[1])){
					var task = newCard.items.items[0].items.items[1].task;
				}else if(!Ext.isEmpty(newCard.items.items[0]) && !Ext.isEmpty(newCard.items.items[0].items.items[0].ownerCt)){
					var task = newCard.items.items[0].items.items[0].ownerCt.task;
				}
//				console.dir(oldCard);
				if(!Ext.isEmpty(oldCard) && !Ext.isEmpty(oldCard.items.items[0]) && !Ext.isEmpty(oldCard.items.items[0].items.items[1])){
					 var oldtask = oldCard.items.items[0].items.items[1].task;
				}else if(!Ext.isEmpty(oldCard) && !Ext.isEmpty(oldCard.items.items[0]) && !Ext.isEmpty(oldCard.items.items[0].items.items[0].ownerCt)){
					 var oldtask = oldCard.items.items[0].items.items[0].ownerCt.task;
				}
//				console.dir(oldtask);
				if(!Ext.isEmpty(task)){
					Ext.TaskManager.start(task);
				}
				if(!Ext.isEmpty(oldtask)){
					Ext.TaskManager.stop(oldtask);
				}
				if(!Ext.isEmpty(newCard.query('[name=refreshScheGridText]'))){
					var refreshScheGridText = newCard.query('[name=refreshScheGridText]')[0];
					var refreshJobGridText = cp.get('refreshScheGridText');
					if(Ext.isEmpty(refreshJobGridText)){
						refreshJobGridText = value ;
					}
					refreshScheGridText.setValue(refreshJobGridText);
				}
				
			},
			closeEditWindow:function(panel,  eOpts ){
				var me = this;
				Ext.TaskManager.start(panel.task);
			},
			closeInfoWindow:function(panel,  eOpts ){
				Ext.TaskManager.start(panel.task);
			},
			selectGridInfo: function(checkbox, record, item, index, eOpts){
				var me = this;
				var grid = checkbox.view.ownerCt;
				var items = grid.dockedItems.items[2].items.items;
				//编辑按钮
				var editBtn = items[0];
				editBtn.enable();
				//详情按钮
				var btnScheGridInfo = items[1];
				btnScheGridInfo.enable();
				//终止按钮
				var btnTerminalScheGrid = items[2];
				btnTerminalScheGrid.enable();
				Ext.TaskManager.stop(grid.task);
			},
			deselectGridInfo : function(checkbox, record, item, index, eOpts) {
				var me = this;
				var grid = checkbox.view.ownerCt;
				var selection = checkbox.getSelection();//选择行数
				if(selection.length==0){
				var items = grid.dockedItems.items[2].items.items;
				//编辑按钮
				var editBtn = items[0];
				editBtn.disable();
				//详情按钮
				var btnScheGridInfo = items[1];
				btnScheGridInfo.disable();
				//终止按钮
				var btnTerminalScheGrid = items[2];
				btnTerminalScheGrid.disable();
				Ext.TaskManager.start(grid.task);
				}
			},
			beforerenderScheGrid : function(grid, eObj) {
				var me = this;
				var value = 10;
					// 拿到cookie
					var refreshJobGridText = cp.get('refreshScheGridText');
					if(Ext.isEmpty(refreshJobGridText)){
						refreshJobGridText = value;
					}
					// 定义任务
					var gridStore = grid.getStore();
					grid.task = {
							run : function() {
								gridStore.load();
							},
							interval : refreshJobGridText * 1000,
							scope : this
					};
					// 定时执行任务
//					Ext.TaskManager.start(grid.task);	
			},
			//定时器刷新
			saveRefreshScheGrid : function(textfield, newValue, oldValue, eOpts) {
				var me = this;
				if (!Ext.isEmpty(newValue) && newValue >= 5) {
					cp.set('refreshScheGridText', newValue);
					// 定义任务
					var myFieldLabel = textfield.ownerCt.items.items[5];
					var grid = textfield.ownerCt.ownerCt;
					myFieldLabel.setText('每隔' + newValue + '秒刷新数据');
					if(!Ext.isEmpty(grid.task)){
						grid.task.interval = (newValue * 1000);
					}
					Ext.TaskManager.start(grid.task);
				}
			},
			editScheExecRecord : function(btn, e, eOpts) {
				var me = this;
				var grid = btn.ownerCt.ownerCt;
				var selectionModel = grid.getSelectionModel();
				var storeSlect= selectionModel.getStore();
				var selectedKeys = selectionModel.getSelection();
				if (selectedKeys.length != 1) {
					Ext.MessageBox.alert('提示', '只能选择一条记录！');
				} else if (selectedKeys.length == 1) {
					var id = selectedKeys[0].data.jobId;
//					if(selectedKeys[0].data.status==0 || selectedKeys[0].data.status==1){
//						Ext.MessageBox.alert("提示","任务正在执行中！");
//						return ;
//					}
					Ext.Ajax.request({
						url:'job/retrive.htm',
						params:{jobId:id},
						success : function(response, opts) {
							var formPanel = Ext.create('banggo.view.taskManager.EditScheExecRecordForm',{jobId:id});
//							var formPanel = me.getEditScheExecRecordForm();
							var form = formPanel.getForm();
							var resposeArray=Ext.decode(response.responseText); 
							var jobModel = Ext.create('banggo.model.taskManager.JobModel',resposeArray.job);
							form.loadRecord(jobModel);
							var win = Ext.create('banggo.view.taskManager.EditScheExecRecordWindow',{
								id:'editScheExecRecordWindowId_'+id,
								items:formPanel,
								task:grid.task
							});
							Ext.TaskManager.stop(grid.task);
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
							Ext.MessageBox.alert('提示', '编辑失败');
						}
					});
				}
			},
			resetClick : function(button, e, eOpts) {
				var form = button.up('form').getForm();
				form.reset();
			},
			queryScheExecRecord : function(button, e, eOpts) {
				var me = this;
				var form = button.up('form').getForm();// 拿到表单
				var values = form.getValues();// 拿到表单的值
				var grid = Ext.getCmp("scheExecRecordGrid");
				var gridStore = grid.getStore();
				//更改当前页
				gridStore.currentPage = 1;
				gridStore.on('beforeload', function(store, options) {
							// 传递搜索变量给数据源
							gridStore.proxy.extraParams = values;
						});
				gridStore.load();
			},
			rowclickGridInfo : function(button, data, eOpts) {
//				if(data.data.status==0 || data.data.status==1){
//					Ext.MessageBox.alert("提示","任务正在执行中！");
//					return ;
//				}
				var win = Ext.create('banggo.view.taskManager.ScheExecRecordInfoWindow',{
					task:button.ownerCt.task
				});
				var me = this;
				var formPanel = me.getScheExecRecordInfoForm();
				var form = formPanel.getForm();
				form.loadRecord(data);
				Ext.TaskManager.stop(button.ownerCt.task);
				win.show();
			},
			jobGridInfo : function(button, e, eOpts) {
				var me = this;
				var grid = button.ownerCt.ownerCt;
				var selectionModel = grid.getSelectionModel();
				var selItems = selectionModel.selected;
				if(selItems.items.length != 1){
					Ext.MessageBox.alert("提示","只能选择一条记录！");
					return ;
				}
				var datas = selectionModel.selected.items[0];
//				if(datas.data.status==0 || datas.data.status==1){
//					Ext.MessageBox.alert("提示","任务正在执行中！");
//					return ;
//				}
				var win = Ext.create('banggo.view.taskManager.ScheExecRecordInfoWindow',{
					task:grid.task				
				});
				var formPanel = me.getScheExecRecordInfoForm();
				var form = formPanel.getForm();
				form.loadRecord(datas);
				Ext.TaskManager.stop(grid.task);
				win.show();
			},
			terminalJobGrid: function(btn, e, eOpts) {
				var form = Ext.create('Ext.form.Panel'); 
				var grid = btn.ownerCt.ownerCt;
				var selectionModel = grid.getSelectionModel();
				var selItems = selectionModel.selected;
				if(selItems.items.length != 1){
					Ext.MessageBox.alert("提示","请选择一行再进行操作！");
					return ;
				}else{
				var para = selItems.items[0].data.execId;
				form.submit({  
					method : 'get',
		            waitMsg:"正在终止，请稍后...",  
		            params:{
		            	execId : para
	            	},
		            url:"/scheduler_console/fired/interrupt.htm",  
		            success: function (f, a) {  
		                Ext.MessageBox.alert("提示", "终止成功！"); 
		                btn.textAlign = "已终止";
		            },  
		            failure: function (f,a) {  
		            	var result="";
		            	if(a.result){
		            		if(a.result.errorMsg){
		            			result = a.result.errorMsg;
		            		}
		            	}else if(a.response.responseText){
		            		result = a.response.responseText;
		            	}else{
		            		result = "无法获取服务器响应信息！";
		            	}
		                Ext.MessageBox.alert("提示","终止失败!<br>" + result);  
		                btn.textAlign = "终止";
		            }  
		        });
				}
			},
			btnSERIClose : function(btn, e, eOpts){
				Ext.TaskManager.start(btn.ownerCt.ownerCt.ownerCt.task)
				btn.ownerCt.ownerCt.ownerCt.close();
			},
			deleteForm:function(btn, e, eOpts){
				var _fieldSet = Ext.getCmp('_fieldSet');
				var btnPr =  btn.ownerCt;
				_fieldSet.remove(btnPr);
			}
		});