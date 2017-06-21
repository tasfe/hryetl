var allScheUserData = [];

Ext.define('banggo.view.taskManager.UserGroupGrid', {
	extend : 'Ext.grid.Panel',
	alias : 'widget.userGroupGrid',
	store : 'taskManager.UserGroupStroe',
	layout : 'fit',
	id : 'userGroupGrid',
	region : 'center',
	columns : [
		{
			xtype : 'rownumberer',
			text : '序'
		}, {
			dataIndex : 'name',
			width : 150,
			align : 'left',
			text : '用户组'
		},{
			dataIndex : 'createDate',
			width : 140,
			align : 'left',
			text : '创建时间'
		}, {
			dataIndex : 'createBy',
			width : 150,
			align : 'left',
			text : '创建人'
		}, {
			dataIndex : 'updateDate',
			width : 140,
			align : 'left',
			text : '更新时间'
		}, {
			dataIndex : 'updateBy',
			width : 140,
			align : 'left',
			text : '更新人'
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
		// 用户
		allScheUserData = Ext.create("banggo.store.taskManager.ScheUserStore");
		
		allScheUserData.load({callback:function(){
			// 可以新增
			Ext.getCmp("addUserGroupGridBtnId").enable();
		}})
		
		me.store = Ext.create("banggo.store.taskManager.UserGroupStore");
		me.store.load();
		
		me.dockedItems = [{
			xtype : 'toolbar',
			id : 'toolbarUserGroupbGridId',
			items : [{
				xtype : 'button',
				text : '新增',
				disabled : true,
				iconCls : "icon-add",
				id : 'addUserGroupGridBtnId'
			},'-',{
				xtype : 'button',
				text : '修改',
				disabled : true,
				iconCls : "icon-cog-edit",
				id : 'updateUserGroupGridBtnId'
			},'-',{
				xtype : 'button',
				text : '删除',
				iconCls : "icon-delete",
				id : 'deleteUserGroupGridBtnId'
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