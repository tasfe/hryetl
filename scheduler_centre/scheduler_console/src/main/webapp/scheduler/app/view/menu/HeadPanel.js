Ext.define('banggo.view.menu.HeadPanel', {
			extend : 'Ext.panel.Panel',
			alias : 'widget.headPanel',
			id:'headPanelId',
			collapsible : true,
			autoHeight : true,
			autoScroll : true,
			title : "欢迎使用任务调度系统",
			border : false,
			initComponent : function() {
				var me = this;
				var currentTime = new Date();
				var aWeek=['星期天','星期一','星期二','星期三','星期四','星期五','星期六'];
				Ext.Ajax.request({
					url : 'sche/dbtime.htm',
					success : function(response, opts) {
						 currentTime = Ext.decode(response.responseText).currentTime;
						 currentTime = new Date(currentTime);
					},
					failure : function(response, opts) {
						Ext.MessageBox.alert("提示", "无法获取服务器响应信息！");
					}
				});
				var clock = new Ext.toolbar.TextItem(Ext.Date.format(currentTime, 'Y-m-d G:i:s A')+'  '+aWeek[currentTime.getDay()]);
				me.tbar = [
				 { xtype: 'tbfill' }
				,{
					xtype : 'tbtext',
					id: 'userNameHeadPanelId',
					text : userName_PUB
				},{
					xtype: "tbseparator"
				},{
					xtype : 'container',
					height: 15,
					width:200,
					items :clock
				},{
					xtype: "tbseparator"
				},{
					xtype : "button",
					text : "退出",
					id : 'quitHeadPanelBtnId',
					iconCls : "icon-delete"
				},{
					xtype: "tbseparator"
				}];
				//定期更新时间
				Ext.TaskManager.start({
				  run: function(){
				        Ext.fly(clock.getEl()).update(Ext.Date.format(currentTime, 'Y-m-d G:i:s A')+'  '+aWeek[currentTime.getDay()]);
				        currentTime = Ext.Date.add(currentTime, Ext.Date.SECOND,1);
				  },
				  interval: 1000
				});
				me.callParent(arguments);
			}
		});