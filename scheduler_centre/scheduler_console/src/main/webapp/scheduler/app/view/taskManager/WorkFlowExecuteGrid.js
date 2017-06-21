Ext.define('banggo.view.taskManager.WorkFlowExecuteGrid', {
			extend : 'Ext.grid.Panel',
			alias : 'widget.workFlowExecuteGrid',
			title : '任务链执行情况',
			layout : 'fit',// 布局
			// frame : true,// 面板渲染效果
			store : 'taskManager.WorkFlowExecuteStore',
			// animCollapse : true,
			closeAction : 'destroy',
			 id : 'workFlowExecuteGrid',
			// autoExpandMax : 300,
			region : 'center', // border布局，将页面分成东，南，西，北，中五部分
			columns : [{
						xtype : 'rownumberer',
						width : 40,
						text : '序'
					},  {
						header : '执行编号',
						dataIndex : 'execNo',
						align : "center",
						sortable : true,
						renderer : function(value) {
							return getLeftFormate(value);
						}
					},{
						header : '任务链名称',
						dataIndex : 'chainName',
						align : "center",
						sortable : true,
						renderer : function(value) {
							return getLeftFormate(value);
						}
					},{
						header : '开始时间',
						dataIndex : 'beginTime',
						width : 160,
						xtype : 'datecolumn',
						format : 'Y-m-d H:i:s',
						align : "center",
						sortable : true,
						renderer : function(value) {
							return getRightFormate(value);
						}
					}, {
						header : '结束时间',
						dataIndex : 'endTime',
						width : 160,
						xtype : 'datecolumn',
						format : 'Y-m-d H:i:s',
						align : "center",
						sortable : true,
						renderer : function(value) {
							return getRightFormate(value);
						}
					}, {
						header : '执行状态',
						dataIndex : 'status',
						align : "center",
						sortable : true,
						renderer : function(value) {
							 if (value == 1) {
								return "<div style='text-align:left;'>执行中</div>";
							} else if (value == 2) {
								return "<div style='text-align:left;'>执行结束</div>";
							}
						}
					} ,{
						header : '执行版本',
						dataIndex : 'scheChainVersion',
						align : "center",
						sortable : true,
						renderer : function(value) {
							return getLeftFormate(value);
						}
					},{
						header : '异常信息',
						dataIndex : 'exception',
						align : "center",
						width : 260,
						sortable : true,
						renderer : function(value) {
							return getLeftFormate(value);
						}
					}],
//			columnLines: true,
			selType : 'checkboxmodel',// 设定选择模式
			multiSelect : true,// 运行多选
			simpleSelect : false,// false只能选择一行，true可以选择多行
			selModel:{
				 	xtype:'checkboxmodel',
				 	checkOnly:false
			},//单选行无效必须选择按钮框
			initComponent : function() {
				var me = this;
				me.store = Ext
						.create("banggo.store.taskManager.WorkFlowExecuteStore");
				me.store.on("beforeload", function(store, options) {
							var params = {
								start : 0,
								limit : 20,
								jobId : me.jobId,
								jobName : me.jobName,
								appName : me.appName,
								jobGroup : me.jobGroup,
								scheChainExecuteId : me.scheChainExecuteId
							};
							// 传递搜索变量给数据源
							store.proxy.extraParams = params;
						});
				me.store.load();
				var items = [{
					xtype : 'button',
					text : '编辑',
					name : 'editWorkFlowBtn',
					iconCls : "icon-cog-edit"
				},{
					xtype : 'button',
					name : 'runRecordExecuteGridBtnId',
					iconCls : 'icon-album',
					text : '节点执行记录'
				}];
				me.dockedItems = [{
						xtype : 'toolbar',
						items : items
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

					}],
				this.callParent(arguments);
			}
		});