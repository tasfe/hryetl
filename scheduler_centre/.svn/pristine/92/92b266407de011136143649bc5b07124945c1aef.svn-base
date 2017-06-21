Ext.define('banggo.store.taskManager.TaskManagerStore', {
	extend : 'Ext.data.TreeStore',
	model : 'banggo.model.taskManager.TaskManagerModel',
	storeId : 'menuStoreId',
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