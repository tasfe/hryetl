Ext.define('banggo.view.taskManager.UpdateKettleDateGrid', {
			extend : 'Ext.grid.Panel',
			alias : 'widget.updateKettleDateGrid',
			title : '更新时间',
			layout : 'fit',
			id:'updateKettleDateGridId',
			frame : true,
			store : 'taskManager.UpdateKettleDateStore',
			animCollapse : true,
			columnsWidth:"150",
			columns : [{
						header : '应用编号',
						dataIndex : 'appId',
						align : "center",
						sortable : true,
						renderer : function(value) {
							return getLeftFormate(value);
						}
					}, {
						dataIndex : 'lastTime',
						xtype : 'datecolumn',
						width : 250,
						align : "center",
						format : 'Y-m-d H:i:s',
						text : '最后时间',
						renderer : function(value) {
							return getLeftFormate(value);
						}
					}, {
						header : '摘要',
						dataIndex : 'summary',
						width : 250,
						align : "center",
						sortable : true,
						renderer : function(value) {
							return getLeftFormate(value);
						}
					}, {
						header : '更改时间',
						xtype : 'datecolumn',
						format : 'Y-m-d H:i:s',
						dataIndex : 'modifyTime',
						width : 250,
						align : "center",
						sortable : true,
						renderer : function(value) {
							return getLeftFormate(value);
						}
					}],
			
			selType : 'checkboxmodel',// 设定选择模式
			multiSelect : true,// 运行多选
			simpleSelect : true,// false只能选择一行，true可以选择多行
			selModel:{
				 	xtype:'checkboxmodel',
				 	checkOnly:true
			},//单选行无效必须选择按钮框
			initComponent : function() {
				var me = this;
				me.store = Ext
						.create("banggo.store.taskManager.UpdateKettleDateStore");
				me.store.load();
				var items = [ {
					xtype : 'button',
					iconCls : "icon-add",
					disabled : true,
				    name : 'btnGridAdd',
					text : '添加'
				},{
					xtype : 'button',
					text : '编辑',
					disabled : true,
					name : 'btnGridEdit',
					iconCls : "icon-cog-edit"
				}, {
					xtype : 'button',
					iconCls : "icon-delete",
					disabled : true,
					name : 'btnGridDel',
					text : '删除'

				}, {
					xtype : 'button',
					iconCls : "icon-refresh",
					disabled : false,
					name : 'btnRefurbish',
					text : '刷新'

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