Ext.define('banggo.view.menu.ContentTab', {
	extend : 'Ext.tab.Panel',
	id:'ContentTabId',
	alias : 'widget.contentTab',
//			requires:['banggo.view.content.ScheTaskContentPanel'],
	activeTab : 0,
	border:0,
	margin : '0 5 0 5',
	enbaleTabScroll : true,
	defaults : {
		closable : true,
		autoDestory:true
	},
	plain : true,
	items : [{
//						xtype : 'scheTaskContentPanel',
	title:'首页',
	html : '首页'
	}],
	initComponent : function() {
		var me = this;
		me.callParent(arguments);
	}
});