var treeJobData = [];

Ext.define('banggo.view.taskManager.WorkJobGrid', {
	extend : 'Ext.grid.Panel',
	alias : 'widget.workJobGrid',
	store : 'taskManager.JobStore',
	layout : 'fit',
	id : 'workJobGrid',
	region : 'center',
	columns : [
		{
			xtype : 'rownumberer',
			text : '序'
		}, {
			dataIndex : 'jobName',
			width : 150,
			align : 'left',
			text : '任务名'
		}, {
			dataIndex : 'alarmMethod',
			width : 200,
			align : 'left',
			text : '通知方式',
			renderer : function(v, metaData, record) {
				if (v) {
					var result = parseInt(v).toString(2); // 10进制转2进制
					
					var html = "";
					// 邮件
					var res = result & 1;
					if (res == 1) {
						html = "邮件";
					}
					// 短信全天
					res = result & 10;
					if (res > 1) {
						if (html.length > 0) {
							html += "/";
						} 
						html += "短信(0-24点)";
					}
					// 短信限时
					res = result & 100;
					if (res > 1) {
						if (html.length > 0)
							html += "/";
						html += "短信(8-22点)";
						
						/*var begin = record.get("acceptAlarmBegin");
						var end = record.get("acceptAlarmEnd");
						
						if (begin && end) {
							html += "[" + begin;
							html += "-" + end + "]";
						}*/
					}
					return html;
				}
			}
		}, {
			dataIndex : 'frequency',
			width : 140,
			align : 'left',
			text : '通知频率',
			renderer : function(v, metaData, record) {
				var unit = record.get("frequencyUnit");
				
				var temp = "";
				if (unit == 'd') {
					temp = "天";
				} else if (unit == 'h') {
					temp = "小时";
				}
				
				return v + "/" + temp;
			}
		}, {
			dataIndex : 'groupName',
			width : 140,
			align : 'left',
			text : '用户组'
		}, {
			dataIndex : 'status',
			align : 'left',
			text : '状态',
			renderer : function(v) {
				if (v == 0) {
					return '<font color=red>停止</font>';
				} else if (v == 1) {
					return '<font color=green>正常</font>';
				}
			}
		}
	],
	selType : 'checkboxmodel',// 设定选择模式
	simpleSelect : false,// false只能选择一行，true可以选择多行
	multiSelect : true,// 运行多选
	selModel:{
		xtype:'checkboxmodel',
		checkOnly:true
	},
	initComponent : function() {
		var me = this;
		
		me.store = Ext.create("banggo.store.taskManager.WorkJobStore");
		me.store.load();
		
		treeJobData = Ext.create("banggo.store.taskManager.AllJobStore");
		treeJobData.load({callback:function(){
			// 可以新增
			Ext.getCmp("addWorkJobGridBtnId").enable();
		}})
		
		me.dockedItems = [{
			xtype : 'toolbar',
			id : 'toolbarWorkJobGridId',
			items : [{
				xtype : 'button',
				text : '新增',
				disabled : true,
				iconCls : "icon-add",
				id : 'addWorkJobGridBtnId'
			},'-',{
				xtype : 'button',
				text : '修改',
				disabled : true,
				iconCls : "icon-cog-edit",
				id : 'updateWorkJobGridBtnId'
			},'-',{
				xtype : 'button',
				text : '运行',
				disabled : true,
				iconCls : "icon-accept",
				id : 'runWorkJobGridBtnId'
			},'-',{
				xtype : 'button',
				text : '停止',
				disabled : true,
				iconCls : "icon-reset",
				id : 'stopWorkJobGridBtnId'
			},'-', {
				xtype : 'button',
				iconCls : "icon-delete",
				id : 'deleteWorkJobGridBtnId',
				text : '删除'
			},'-', {
				xtype : 'button',
				iconCls : "icon-accept",
				id : 'joinWorkJobGridBtnId',
				text : '加载任务'
			}]
		}, {
			xtype : 'pagingtoolbar',
			store : me.store,
			dock : 'bottom',
			displayInfo : true,
			emptyMsg : '没有数据',
			displayInfo : true,
			displayMsg : '当前显示{0}-{1}条记录 / 共{2}条记录 ',
			beforePageText : '第',
			afterPageText : '页/共{0}页'
		}];
		
		me.callParent(arguments);
	}
});