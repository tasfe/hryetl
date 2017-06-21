Ext.define('banggo.controller.taskManager.UpdateKettleDateController', {
			extend : 'Ext.app.Controller',
			models : ['taskManager.UpdateKettleDateModel'],
			stores : ['taskManager.UpdateKettleDateStore'],
			views : ['content.UpdateKettleDatePanel',
					'taskManager.EditUpdateKettleDateForm',
					'taskManager.UpdateKettleDateGrid'],
			refs : [{
						ref : 'UpdateKettleDateGrid',
						selector : 'updateKettleDateGrid'
					}],
			init : function() {
				var me = this;
				me.control({
							'updateKettleDateGrid' : {
								itemdblclick : me.rowDoubleClick,//双击事件
								select: me.selectGridInfo,//选择一行
								deselect :me.deselectGridInfo//取消选择行
							}
							,'updateKettleDateGrid button[text=编辑]' : {
								click : me.editGridRecord
							}
							,'updateKettleDateGrid button[text=删除]' : {
								click : me.deleteForm
							}
							,'updateKettleDateGrid button[text=刷新]' : {
								click : me.refurbish
							}
							,'editUpdateKettleDateForm button[id=saveBtnId]' : {
								click : me.btnSaveUpdateKettleDate
							}
						});

				me.callParent(arguments);
			},
			selectGridInfo: function(checkbox, record, item, index, eOpts){
				var grid = checkbox.view.ownerCt;
				var items = grid.dockedItems.items[2].items.items;
				//编辑按钮
				var selectionModel = grid.getSelectionModel();
				var selectedKeys = selectionModel.getSelection();
				if (selectedKeys.length == 1) {
					var btnGridEdit = items[1];
					btnGridEdit.enable();
				}else{
					var btnGridEdit = items[1];
					btnGridEdit.disable();
				}
			},
			deselectGridInfo : function(checkbox, record, item, index, eOpts) {
				var grid = checkbox.view.ownerCt;
				var items = grid.dockedItems.items[2].items.items;

				var selectedKeys = grid.getSelectionModel().getSelection();
				if (selectedKeys.length == 1) {
					var btnGridEdit = items[1];
					btnGridEdit.enable();
				}else{
					var btnGridEdit = items[1];
					btnGridEdit.disable();
				}
			},
			rowDoubleClick : function(button, data, eOpts) {
				var win = Ext.create('banggo.view.taskManager.EditUpdateKettleDateWindow');
				win.show();
				win.items.items[0].loadRecord(data);
			},
			editGridRecord : function(btn, e, eOpts) {
				var win = Ext.create('banggo.view.taskManager.EditUpdateKettleDateWindow');
				win.show();
			},
			btnSaveUpdateKettleDate : function(button, e, eOpts) {
				var form = button.up('form').getForm();
				if (!form.isValid()) {  
		            return;  
				}
//				console.dir(form);
				form.submit({  
					method : 'post',
		            waitMsg:'正在保存，请稍后...',  
		            url:"date/update.htm",  
		            success: function (f, a) {
		                button.ownerCt.ownerCt.ownerCt.close();
		                Ext.MessageBox.alert("提示", "保存成功!", function(){
		                	var grid = Ext.getCmp("updateKettleDateGridId");
		    				grid.store.load();
		                }); 
		            },  
		            failure: function (f,a) {  
		            	/**var ret = eval('('+a.response.responseText+')');
		            	var failStr = '';
		            	if(ret && ret.info){
		            		failStr = ret.info;
		            	}**/
						Ext.Msg.alert("提示", "操作失败！"); 
		            }
		        }); 
			},
			deleteForm:function(btn, e, eOpts){
			},
			refurbish:function(btn, e, eOpts){
				var grid = Ext.getCmp("updateKettleDateGridId");
				grid.store.load();
			}
		});