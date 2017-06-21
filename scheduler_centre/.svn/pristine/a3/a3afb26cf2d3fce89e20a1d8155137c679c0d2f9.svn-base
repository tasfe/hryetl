
var ds = Ext.create('Ext.data.ArrayStore', {
      data: [],
      fields: ['value','text'],
      sortInfo: {
          field: 'value',
          direction: 'ASC'
      }
});

Ext.define('banggo.view.taskManager.EditUserGroupForm', {
	extend : 'Ext.form.Panel',
	alias : 'widget.editUserGroupForm',
	border : 0,
	requires : [ 'Ext.ux.form.ItemSelector'],
	bodyStyle: 'padding:5px 5px 0',
	width: '100%',
	id:'editUserGroupFormId',
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
        	xtype: 'textfield',
         	fieldLabel: '用户组名称',
          	labelAlign:'right',
          	padding : '5 0 5 0',
     		name: 'name'
    	},{
        	xtype: 'textfield',
         	fieldLabel: '用户查询',
          	labelAlign:'right',
          	padding : '5 0 5 0',
     		name: 'userCode',
     		listeners : {
       			change : function(field,newValue,oldValue){
       				var obj = Ext.getCmp('userIds-field');
               		// 已经选过的值
               		var val = obj.getValue();
               		
               		var valString = "";
               		for (var i = 0; i < val.length; i++) {
               			valString += "," + val[i];
               		}
               		valString += ",";
               		
               		var leng = scheUserData.length;
               		var st = [];
               		for (var i = 0; i < leng; i++) {
               			var temp = scheUserData[i];
               			var tempStr = "," + temp[0] + ",";
               			
               			if (valString.contains(tempStr) || Ext.Array.contains(temp[1],newValue)) {
               				st.push(temp);
               			}
               		}
            		
            		var ddd = Ext.create('Ext.data.ArrayStore', {
				        	data: st,
				        	fields: ['value','text'],
				        	sortInfo: {
				            	field: 'value',
				            	direction: 'ASC'
				        	}
					});
            		
            		obj.bindStore(ddd);
            		obj.setValue(val);
      			}
			}
    	},{
			xtype: 'itemselector',
			padding : '5 0 5 0',
            name: 'userIds',
            id: 'userIds-field',
            anchor: '100%',
            height: 200,
            labelAlign:'right',
            fieldLabel: '用户',
            imagePath: '../ux/images/',
            store: ds,
            displayField: 'text',
            valueField: 'value',
            value: [],
            msgTarget: 'side',
            fromTitle: '可选择用户',
            toTitle: '已选择用户'
		}]
	}],
	buttons : [ {
		text : '新增用户',
		id : 'AddUserFormId'
	},{
		text : '修改用户',
		id : 'EditUserFormId'
	},{
		text : '保存',
		id : 'finishEditUserGroupFormId'
	},{
		text : '关闭',
		id : 'closeEditUserGroupFormBtnId'
	} ],
	initComponent : function() {
		
		var me = this;
		me.callParent(arguments);
	}
});