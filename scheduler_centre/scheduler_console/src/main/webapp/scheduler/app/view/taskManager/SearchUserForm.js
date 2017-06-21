Ext.define('banggo.view.taskManager.SearchUserForm', {
	extend : 'Ext.form.Panel',
	alias : 'widget.searchUserForm',
	border : 0,
	requires : ['Ext.ux.form.MultiSelect','Ext.ux.form.ItemSelector'],
	bodyStyle: 'padding:5px 5px 0',
	width: '100%',
	id:'searchUserFormId',
    defaults: {
        border: false,
        xtype: 'panel',
        flex: 1,
        layout: 'anchor'
    },
    layout : 'hbox',
	items: [{
  		items: [
  		{
       		anchor: '100%',
        	xtype: 'multiselect',
         	msgTarget: 'side',
            fieldLabel: '用户',
            labelAlign:'right',
            name: 'users',
            id: 'users-field',
            allowBlank: false,
            store: Ext.create('Ext.data.ArrayStore', {
	      		data: [],
	      		fields: ['value','text'],
	      		sortInfo: {
	          		field: 'value',
	          		direction: 'ASC'
	      		}
			}),
            valueField: 'value',
            displayField: 'text',
            value: [],
            height:200,
            maxSelections:1,
            //singleSelect: true,
            ddReorder: true
        }]
	}],
	buttons : [{
		text : '确定',
		id : 'finishSearchUserFormId'
	}, {
		text : '关闭',
		id : 'closeSearchUserFormBtnId'
	} ],
	initComponent : function() {
		
		var me = this;
		me.callParent(arguments);
	}
});