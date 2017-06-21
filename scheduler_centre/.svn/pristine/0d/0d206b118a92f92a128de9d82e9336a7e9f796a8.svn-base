Ext.define('banggo.controller.MenuController', {
	extend : 'Ext.app.Controller',
	alias : 'widget.menuController',
	models : ['menu.MenuModel'],
	stores : ['menu.MenuStore'],
	views : ['menu.MenuView', 'menu.ContentTab','menu.HeadPanel'],
	refs : [{
		ref : 'MenuView',
		selector : 'menuView'
	}, {
		ref : 'ContentTab',
		selector : 'contentTab'
	}, {
		ref : 'HeadPanel',
		selector : 'headPanel'
	}],
	init : function() {
		var me = this;
		me.control({
			'menuView' : {// 点击菜单动态生成grid panel
				itemclick : this.changePanel
			},
			'headPanel button[id=quitHeadPanelBtnId]' :{
				click : this.quitSystem
			}
		});
	},
	quitSystem: function(btn,eOpts){
		var redirect = authOutRealPath_PUB+'?returnUrl='+ encodeURIComponent(realPath_PUB);//全局变量from app.js
		window.location = redirect; 
	},
	changePanel : function(featurefinance, record, item, index, e, eOpts) {
		var me = this;
		me.content = {};
		var aid = record.data.id; // 应用id
		var leaf = record.data.leaf;
		var n = Ext.getCmp(aid);
		var content = me.getContentTab();
				
		if(leaf){
			if (!n) {
				var method = "banggo.view.content." + aid;
				n = content.add({
					id : record.data.id,
					title : record.data.text,
					closable : true,
					layout : 'fit',
					autoDestory: true,
					items:Ext.create(method)
				});
			}
			content.setActiveTab(n);
		}
	}
});