Ext.define('banggo.view.taskManager.JobGrid', {
			extend : 'Ext.grid.Panel',
			alias : 'widget.jobGrid',
			store : 'taskManager.JobStore',
			layout : 'fit',
			id : 'jobGrid',
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
			 multiSelect : true,// 运行多选
			 selModel:{
			 	xtype:'checkboxmodel',
			 	checkOnly:true
			 },
			initComponent : function() {
				var me = this;
				me.store = Ext.create("banggo.store.taskManager.JobStore");
				me.store.on("beforeload", function(store, options) {
					var params = {
						start : 0,
						limit : 15
					};
					// 传递搜索变量给数据源
					store.proxy.extraParams = params;
				});
				me.dockedItems = [{
							xtype : 'toolbar',
							id : 'toolbarJobGridId',
							items : [{
										xtype : 'button',
										text : '新增',
										iconCls : "icon-add",
										id : 'addJobGridBtnId'
									}, {
										xtype : 'button',
										text : '修改',
										disabled : true,
										iconCls : "icon-cog-edit",
										id : 'editJobGrid'
									}, {
										xtype : 'button',
										id : 'resumeJobGridBtnId',
										iconCls : "icon-accept",
										disabled : true,
										text : '恢复'
									}, {
										xtype : 'button',
										id : 'pauseJobGridBtnId',
										disabled : true,
										iconCls : "icon-accept",
										text : '暂停'
									}, {
										xtype : 'button',
										id : 'runOnceJobGridBtnId',
										iconCls : "icon-reset",
										text : '执行'
									}, {
										xtype : 'button',
										iconCls : "icon-delete",
										id : 'deleteJobGridBtnId',
										text : '删除'
									}, {
										xtype : 'button',
										id : 'runRecordJobGridBtnId',
										iconCls : 'icon-album',
										text : '执行记录'
									}, '-', {
										xtype : 'numberfield',
										labelWidth : 113,
										width : 200,
										value : 10,
										allowBlank : false,// 不能为空
										minValue : 5,
										allowNegative : false,
										allowDecimals : false,
										regex : /^\d*$/,
										vtypeText : '请输入大于5的正整数',
										id : 'textfieldJobGridId',
										name : 'refreshJobGridText',
										fieldLabel : '设置刷新时间(秒)'
									}, {
										xtype : 'label',
										id : 'myFieldLabelId',
										text : '默认10秒刷新一次数据',
										margin : '0 0 0 10'
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