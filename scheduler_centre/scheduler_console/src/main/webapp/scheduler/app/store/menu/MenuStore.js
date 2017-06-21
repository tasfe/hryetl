Ext.define('banggo.store.menu.MenuStore', {
	extend : 'Ext.data.TreeStore',
	storeId : 'menuStoreId',
	model : 'banggo.model.menu.MenuModel',
	proxy : {
		type : 'ajax',
		url : 'scheduler/resources/data/menu.json',
		reader : 'json'
	},
	root : {
		expanded : true,
		text:'调度管理',
		id:'task'
	}
});