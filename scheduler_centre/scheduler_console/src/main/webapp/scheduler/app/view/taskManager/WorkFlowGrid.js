Ext.define('banggo.view.taskManager.WorkFlowGrid', {
			extend : 'Ext.grid.Panel',
			alias : 'widget.workFlowGrid',
			title : '任务编排查询明细',
			layout : 'fit',// 布局
			// frame : true,// 面板渲染效果
			store : 'taskManager.WorkFlowStore',
			// animCollapse : true,
			closeAction : 'destroy',
			 id : 'workFlowGrid',
			// autoExpandMax : 300,
			region : 'center', // border布局，将页面分成东，南，西，北，中五部分
			columns : [{
						xtype : 'rownumberer',
						width : 40,
						text : '序'
					},{
						header : '任务链名称',
						dataIndex : 'chainName',
						align : "center",
						sortable : true,
						renderer : function(value) {
							return getLeftFormate(value);
						}
					},{
						header : '创建时间',
						dataIndex : 'createDate',
						width : 160,
						xtype : 'datecolumn',
						format : 'Y-m-d H:i:s',
						align : "center",
						sortable : true,
						renderer : function(value) {
							return getRightFormate(value);
						}
					}, {
						header : '更新时间',
						dataIndex : 'updateDate',
						width : 160,
						xtype : 'datecolumn',
						format : 'Y-m-d H:i:s',
						align : "center",
						sortable : true,
						renderer : function(value) {
							return getRightFormate(value);
						}
					}, {
						header : '当前版本',
						dataIndex : 'version',
						align : "center",
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
						.create("banggo.store.taskManager.WorkFlowStore");
				me.store.on("beforeload", function(store, options) {
							var params = {
								start : 0,
								limit : 20,
								chainName : me.chainName,
								version : me.version,
								appName : me.appName,
								jobName : me.jobName,
								jobGroup : me.jobGroup
							};
							// 传递搜索变量给数据源
							store.proxy.extraParams = params;
						});
				me.store.load();
				var items = [{
					xtype : 'button',
					text : '新增',
//					disabled : true,
					id : 'addWorkFlowBtn',
					iconCls : "icon-add"
				},{
					xtype : 'button',
					text : '编辑',
//					disabled : true,
					id : 'editWorkFlowBtn',
					iconCls : "icon-cog-edit"
				}, {
					xtype : 'button',
					iconCls : "icon-delete",
//					disabled : true,
				    id : 'deleteWorkFlowBtn',
					text : '删除'
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