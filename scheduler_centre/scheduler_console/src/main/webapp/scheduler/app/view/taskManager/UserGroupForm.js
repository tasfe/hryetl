Ext.define('banggo.view.taskManager.UserGroupForm', {
	extend : 'Ext.form.Panel',
	alias : 'widget.userGroupForm',
	title : "查询条件",
	region : 'north',
	layout : 'column',
	border : false,
	frame : true,
	fieldDefaults : {
		labelWidth : 80,
		labelAlign : 'right'
	},
	items : [ {
		xtype : 'container',
		layout : 'anchor',
		flex : 1,
		defaults : {
			anchor : '100%',
			labelAlign : 'right'
		},
		defaultType : 'textfield',
		items : [
			{
				xtype : 'container',
				layout : 'anchor',
				flex : 1,
				defaults : {
					anchor : '100%',
					labelAlign : 'right'
				},
				defaultType : 'textfield',
				items : [ {
					xtype : 'textfield',
					fieldLabel : '用户组名',
					padding : '5 7 5 7',
					width : 240,
					name : 'userGroupName'
				} ]
		}]
	} ],
	buttons:[ 
		{text : '查询',id:'requeyUserGroupFormBtnId'}, {text:'重置',id:'resetUserGroupFormBtnId'} 
	],
	initComponent : function() {
		var me = this;
		me.callParent(arguments);
	}
});