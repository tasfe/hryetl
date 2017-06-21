Ext.define('banggo.view.Viewport', {
	extend : 'Ext.container.Viewport',
	layout : 'border',
	items : [ {
		region : 'north',
////		html: '<h1 class="x-panel-header">系统当前时间：</h1>',
//		html:"<iframe width='100%' height='100%' src='showtime.html'></iframe>",
		xtype : "headPanel",
//		id:'titlePanelId',
//		title : "欢迎使用任务调度系统",
//		autoHeight : true,
//		border : false,
//		margins : '0 0 5 0'
	}, {
		region : 'west',
		width : 200,
		xtype : 'menuView',
		title : '导航',
		animCollapse : true,
		minWidth : 150,
		maxWidth : 400,
		split : true
	// 中间的是否收起
	}, {
		region : "center",
		xtype : "contentTab"
	},
//	{
//        region: 'south',
//        title: '底部',
//        collapsible: true,          // 允许折叠
//        html: '这里放置版权信息',
//        split: true,
//        height: 23,
//        minHeight: 100
//    } 
	],
	initComponent : function() {
		var me = this;
		me.callParent(arguments);
	}
});