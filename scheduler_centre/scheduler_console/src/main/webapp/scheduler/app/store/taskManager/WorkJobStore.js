Ext.define('banggo.store.taskManager.WorkJobStore', {
	extend : 'Ext.data.Store',
	model : 'banggo.model.taskManager.WorkJobModel',
	storeId : 'WorkJobStoreId',
	pageSize:20,
	proxy : {
		type : 'ajax',
		url : 'alarm/query.htm',
		reader : {
			type : 'json',
			root : 'topics'
		}
	}
});