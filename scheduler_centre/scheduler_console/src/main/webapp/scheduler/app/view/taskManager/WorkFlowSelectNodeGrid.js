Ext.define('banggo.view.taskManager.WorkFlowSelectNodeGrid', {
			extend : 'Ext.grid.Panel',
			alias : 'widget.workFlowSelectNodeGrid',
			store : 'taskManager.JobStore',
			layout : 'fit',
			id : 'workFlowSelectNodeGrid',
			region : 'center',
			columns : [{
						xtype : 'rownumberer',
						text : '序'
					}, {
						dataIndex : 'jobName',
						width : 150,
						align : 'left',
						text : '任务名称'
					}, {
						dataIndex : 'jobGroup',
						width : 140,
						align : 'left',
						text : '任务组名称'
					}, {
						dataIndex : 'previousFireTime',
						width : 140,
						align : 'left',
						text : '上次运行时间'
					}, {
						dataIndex : 'nextFireTime',
						width : 140,
						align : 'left',
						text : '下次运行时间'
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
					}, {
						dataIndex : 'appName',
						width : 140,
						align : 'left',
						text : '应用名称'
					}, {
						dataIndex : 'beginDate',
						width : 140,
						align : 'left',
						text : '开始时间'
					}, {
						dataIndex : 'endDate',
						width : 140,
						align : 'left',
						text : '结束时间'
					}, {
						dataIndex : 'remoteUrl',
						hidden : true
					}, {
						dataIndex : 'isAllowConcurrent',
						hidden : true
					}],
			 selType : 'checkboxmodel',// 设定选择模式
			 simpleSelect : false,// false只能选择一行，true可以选择多行
			 multiSelect : false,// 运行多选
			 selModel:{
			 	xtype:'checkboxmodel'
			 },
			initComponent : function() {
				var me = this;
				me.store = Ext.create("banggo.store.taskManager.JobStore");
				me.store.on("beforeload", function(store, options) {
							var params = {
								start : 0,
								limit : 15,
								type:1
							};
							// 传递搜索变量给数据源
							store.proxy.extraParams = params;
						});
				me.store.load();
				me.dockedItems = [{
							xtype : 'toolbar',
							id : 'toolbarSelectNodeGridId',
							items : [{
										xtype : 'button',
										text : '确定',
										iconCls : "icon-add",
										id : 'selectJobGridBtnId'
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