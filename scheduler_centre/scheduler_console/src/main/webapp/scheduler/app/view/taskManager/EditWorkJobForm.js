
Ext.define('banggo.view.taskManager.EditWorkJobForm', {
	extend : 'Ext.form.Panel',
	alias : 'widget.editWorkJobForm',
	border : 0,
	bodyStyle: 'padding:5px 5px 0',
	width: '100%',
	id:'editWorkJobFormId',
	labelAlign : 'right',
    defaults: {
        border: false,
        xtype: 'panel',
        flex: 1,
        layout: 'anchor'
    },
	items: [{
		padding : '5 7 5 7',
  		items: [
  		{
  			xtype: 'textfield',
          	fieldLabel: '任务名称',
        	readOnly:true,
        	width:400,
        	padding : '5 0 5 0',
       		name: 'scheJobName'
		},{
	   		xtype: 'hiddenfield',
	   		id:'scheJobId',
	    	name: 'scheJobId',
	    	padding : '5 0 5 0',
	    	value: ''
	    },{xtype : 'combobox',
			store:new Ext.data.SimpleStore({fields:[],data:[[]]}),
			editable:false,
			id:"userGroupTree",
			padding : '5 0 5 0',
			name: 'userGroupTreeName',
			fieldLabel : "用户组",
			queryMode : 'local',
			triggerAction:'all',
			selectedClass:'',
			onSelect:Ext.emptyFn,
			width:400,
		    tpl: '<tpl for="."><div id="userGroupTreediv"></div></tpl>',
			onExpand:function() {
				if (userGroupTree2==null) {
					userGroupTree2=Ext.create('Ext.tree.TreePanel', {
			    		height: 150,
			            renderTo:'userGroupTreediv',
			            store: userGroupTreeStore,
			            rootVisible: false,
			            listeners:{'itemclick':function(node,event)  
				        {  
				        	var id = event.data.id;
				        	
				        	var userGroupName = Ext.getCmp('userGroupTree');
				        	if (id) {
				        		var text = event.data.text;
					    		userGroupName.setRawValue(text); 
					    		Ext.getCmp('scheUserGroupId').setValue(id);
					    		// 隐藏
					    		userGroupTree2.hide();
					    	} 
					    	if (!userGroupName.getValue()) {
					    		Ext.get('scheUserGroupId').setValue("");
					    	}
				        }},
			            visible:true
		 			});
				}
				userGroupTree2.show();
			}
		},{
	   		xtype: 'hiddenfield',
	   		id:'scheUserGroupId',
	    	name: 'scheUserGroupId',
	  		padding : '5 0 5 0',
	    	value: ''
	    },{
			xtype: 'checkboxgroup',
            fieldLabel: '通知方式',
            padding : '5 0 5 0',
            columns: 4,
            items: [
                {
                	boxLabel: '短信', 
                	name: 'noticeType1', 
                	width:80,
                	handler: function(me, checked) {
		        		var comObj = Ext.getCmp('noticeDate');
		        		var flag = false;
		        		if (!checked) {
		        			flag = true;
		        		}
		        		comObj.setDisabled(flag);
		        	}
                },
                {boxLabel: 'email', name: 'noticeType2',width:80}
            ]
    	},
    	{
	   		xtype: 'hiddenfield',
	   		id:'alarmMethod',
	    	name: 'alarmMethod',
	    	padding : '5 0 5 0',
	    	value: ''
	    }, 
    	{
			xtype : 'combobox',
			fieldLabel : "短信通知时间",
			emptyText : "请选择...",
			triggerAction : "all",
			forceSelection : true,
			editable : false,
			value:1,
			store : Ext.create("Ext.data.Store", {
				fields : ["name", "value"],
				data : [ 
					{name:"请选择",value:""}, 
					{name:"0-24点",value:"1"}, 
					{name:"8-22点",value:"2"}]
			}),
			mode : "local",
			forceSelection : true,
			displayField : "name",
			valueField : "value",
			queryMode : "local",
			width : 260,
			padding : '5 0 5 0',
			id : 'noticeDate',
			name : 'noticeDate'
		},
    	{
        	xtype: 'container',
        	padding : '5 0 5 0',
       		layout: 'hbox',
       		items: [{
                	xtype : 'combobox',
					fieldLabel : "通知频率",
					emptyText : "请选择...",
					triggerAction : "all",
					forceSelection : true,
					editable : false,
					value:1,
					store : Ext.create("Ext.data.Store", {
						fields : ["name", "value"],
						data : [ 
							{name:"请选择",value:""},
							{name:"天",value:"d"}, 
							{name:"小时",value:"h"}]
					}),
					mode : "local",
					forceSelection : true,
					displayField : "name",
					valueField : "value",
					queryMode : "local",
					name:'frequencyUnit',
					width : 200
          		}, {
               		xtype: 'textfield',
               		fieldLabel: '次数',
                  	labelWidth: 30,
                  	labelAlign:'right',
                  	name: 'frequency',
                	width: 100
       		}]
   		},{
			xtype : 'combobox',
			fieldLabel : "状态",
			emptyText : "请选择...",
			triggerAction : "all",
			forceSelection : true,
			editable : false,
			value:1,
			store : Ext.create("Ext.data.Store", {
				fields : ["name", "value"],
				data : [ 
					{name:"运行",value:1}, 
					{name:"停止",value:0}]
			}),
			mode : "local",
			forceSelection : true,
			displayField : "name",
			valueField : "value",
			queryMode : "local",
			width : 260,
			padding : '5 0 5 0',
			id : 'status',
			name : 'status'
		}]
	}],
	buttons : [ {
		text : '修改',
		id : 'finishEditWorkJobFormId'
	}, {
		text : '关闭',
		id : 'closeEditWorkJobFormBtnId'
	} ],
	initComponent : function() {
		var me = this;
		me.callParent(arguments);
	}
});