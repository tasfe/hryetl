var jobTree2 = null;
var jobTreeStore = null;

var userGroupTree2 = null;
var userGroupTreeStore = null;

Ext.define('banggo.view.taskManager.AddWorkJobForm', {
	extend : 'Ext.form.Panel',
	alias : 'widget.addWorkJobForm',
	border : 0,
	bodyStyle: 'padding:5px 5px 0',
    width: '100%',
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
  			xtype : 'combobox',
			store:new Ext.data.SimpleStore({fields:[],data:[[]]}),
			editable:false,
			id:"jobTree",
			fieldLabel : "任务名称",
			queryMode : 'local',
			triggerAction:'all',
			selectedClass:'',
			onSelect:Ext.emptyFn,
			padding : '5 0 5 0',
			width:400,
		    tpl: '<tpl for="."><div id="jobTreeDiv"></div></tpl>',
		    onCollapse : function() {
		    	
		    },
			onExpand:function() {
				if (jobTree2==null) {
					jobTree2=Ext.create('Ext.tree.TreePanel', {
			    		height: 250,
			            renderTo:'jobTreeDiv',
			            store: store,
			            rootVisible: false,
			            listeners:{'itemclick':function(node,event)  
				        {  
				        	var id = event.data.id;
				        	var jobName = Ext.getCmp('jobTree');
				        	if (id) {
				        		var text = event.data.text;
					    		jobName.setRawValue(text); 
					    		Ext.getCmp('scheJobId').setValue(id);
					    		// 隐藏
					    		jobTree2.hide();
					    	} 
					    	if (!jobName.getValue()) {
					    		Ext.getCmp('scheJobId').setValue("");
					    	}
				        }},
			            visible:true
		 			});
				}
				jobTree2.show();
			}
		},
		{
	   		xtype: 'hiddenfield',
	   		id:'scheJobId',
	    	name: 'scheJobId',
	    	padding : '5 0 5 0',
	    	value: ''
	    },
	    {xtype : 'combobox',
			store:new Ext.data.SimpleStore({fields:[],data:[[]]}),
			editable:false,
			id:"userGroupTree",
			fieldLabel : "用户组",
			queryMode : 'local',
			triggerAction:'all',
			selectedClass:'',
			onSelect:Ext.emptyFn,
			padding : '5 0 5 0',
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
		},
		{
	   		xtype: 'hiddenfield',
	   		id:'scheUserGroupId',
	    	name: 'scheUserGroupId',
	    	padding : '5 0 5 0',
	    	value: ''
	    },
  		{
			xtype: 'checkboxgroup',
            fieldLabel: '通知方式',
            padding : '5 0 5 0',
            columns: 3,
            items: [
                {
                	boxLabel: '短信', 
                	name: 'noticeType1', 
                	checked: true,
                	handler: function(me, checked) {
		        		var comObj = Ext.getCmp('noticeDate');
		        		var flag = false;
		        		if (!checked) {
		        			flag = true;
		        		}
		        		comObj.setDisabled(flag);
		        	}
                },
                {boxLabel: 'email', name: 'noticeType2'}
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
			padding : '5 0 5 0',
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
			id : 'noticeDate',
			name : 'noticeDate'
		},
    	{
        	xtype: 'container',
       		layout: 'hbox',
       		padding : '5 0 5 0',
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
			padding : '5 0 5 0',
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
			id : 'status',
			name : 'status'
		}]
	}],
	buttons : [ {
		text : '保存',
		id : 'finishAddWorkJobFormId'
	}, {
		text : '重置',
		id : 'resetAddWorkJobFormBtnId'
	}, {
		text : '关闭',
		id : 'closeAddWorkJobFormBtnId'
	} ],
	initComponent : function() {
		var me = this;
		me.callParent(arguments);
		
		jobTree2 = null;
		if (jobTreeStore == null) {
			
			var appData = [];
			var appJson = {};
			var jobGroupJson = {};
			
			var dataCount = treeJobData.getCount();
			for (var i = 0; i < dataCount; i++) {
				var temp = treeJobData.getAt(i);
				var appName = temp.get("appName");
				
				if (!Ext.Array.contains(appData, appName)) {
					appData.push(appName);
				}
				
				var tempJson = appJson[appName];
				if (!tempJson) {
					tempJson = [];
				}
				
				var groupName = temp.get("jobGroup");
				if (!Ext.Array.contains(tempJson, groupName)) {
					tempJson.push(groupName);
					appJson[appName] = tempJson;
				}
				
				var jobName = appName + "||" + groupName;
				var tempJob = jobGroupJson[jobName];
				if (!tempJob) {
					tempJob = [];
				}
				tempJob.push(temp);
				jobGroupJson[jobName] = tempJob;
			}
			var storeData = [];
			for (var i = 0; i < appData.length; i++) {
				var record = {};
				record.text = appData[i];
				record.expanded = false;
				
				var groupRecord = [];
				
				var groupData = appJson[appData[i]];
				
				for (var j = 0; j < groupData.length; j++) {
					var gRecord = {};
					var groupName = groupData[j];
					gRecord.text = groupName;
					gRecord.expanded = false;
					
					var jobRecord = [];
					var tempGroupName = appData[i] + "||" + groupName;
					var jobData = jobGroupJson[tempGroupName];
					if (jobData) {
						for (var x = 0; x < jobData.length; x++) {
							var temp = jobData[x];
							var jRecord = {};
							jRecord.text = temp.get("jobName");
							jRecord.id = temp.get("id");
							jRecord.leaf = true;
							jobRecord.push(jRecord);
						}
					}
					gRecord.children = jobRecord;
					groupRecord.push(gRecord);
				}
				record.children = groupRecord;
				storeData.push(record);
			}
			store = Ext.create('Ext.data.TreeStore', {
				isLocalMode:true,
				root: {
					expanded: true, 
					children: storeData
				}
			});
		}
	}
});