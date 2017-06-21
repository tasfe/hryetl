Ext.define('banggo.view.taskManager.EditUpdateKettleDateForm', {
	extend : 'Ext.form.Panel',
	alias : 'widget.editUpdateKettleDateForm',
	frame : true,
	id : 'editUpdateKettleDateFormId',
	height : 200,
	border : 8,
	padding : '4 7 4 7',
	buttons : [		
		    	{
					text : '保存',
					id : 'saveBtnId',
					formBind: true,
					disabled: true
				}, {
					text : '重置',
					handler: function() {
						var form = Ext.getCmp("editUpdateKettleDateFormId").getForm();
						try{
							var formId = form.findField('appId').getValue();
							var data = Ext.getCmp("updateKettleDateGridId").getStore().data;
							data.each(function(record) {   
								var gridData = record.data;
								if(gridData && formId == gridData.appId){
									form.findField('summary').setValue(gridData.summary);
									form.findField('lastTime').setValue(gridData.lastTime);
								}
							});  
						}catch(e){
//							console.dir(e);
							form.findField('summary').setValue('');
							form.findField('lastTime').setValue('');
						}
					}
				}, {
					text : '关闭',
					handler: function() {
						var windows = Ext.getCmp("editUpdateKettleDateWindowId");
						windows.close();
					}
				}],
	initComponent : function() {
		var me = this;
		var grid = Ext.getCmp("updateKettleDateGridId");
		var selectedKeys = grid.getSelectionModel().getSelection();
		var datas = (selectedKeys.length == 1) ? selectedKeys[0].data : null;
		var id = datas ? datas.id : '';
		var appId = datas ? datas.appId : '';
		var summary = datas ? datas.summary : '';
		var lastTime = datas ? datas.lastTime : '';
		var modifyTime = datas ? datas.modifyTime : '';

		me.items = [{
			xtype: 'container',
			layout : 'anchor',
			items : [{
					xtype : 'container',
					layout : 'anchor',
					flex: 1,
					defaultType : 'textfield',
					items : [{
								width: 350,		
								readOnly : true,
								padding : '10 0 0 0', 
								fieldLabel : '应用编号',
								xtype : 'textfield',
								style:'background:#E6E6E6;padding-top:15px',
								name : 'appId',
								value : appId
							}, {
								width: 350,	 
								allowBlank : false,
								editable: true,
								padding : '10 0 0 0',
							    xtype: 'datetimefield',
								fieldLabel : '最后时间',
								format: 'Y-m-d H:i:s',
								renderer:Ext.util.Format.dateRenderer('Y-m-d H:i:s'),
								name : 'lastTime',
								value : lastTime
							}, {
								width: 350,	 
								allowBlank : false,
								padding : '10 0 0 0',
								fieldLabel : '摘要',
								name : 'summary',
								value : summary
							}, {
								width: 350,	 
								readOnly : true,
								padding : '10 0 0 0',
								xtype: 'datetimefield',
								fieldLabel : '更改时间',
								format: 'Y-m-d H:i:s',
								renderer:Ext.util.Format.dateRenderer('Y-m-d H:i:s'),
								style:'background:#E6E6E6',
								name : 'modifyTime',
								value : modifyTime
							}]
				}]
	}];
		me.callParent(arguments);
	}
});