Ext.define('banggo.store.taskManager.JobStore', {
	extend : 'Ext.data.Store',
	model : 'banggo.model.taskManager.JobModel',
	storeId : 'JobStoreId',
	pageSize:20,
	proxy : {
		type : 'ajax',
		url : 'job/query.htm',
		reader : {
			type : 'json',
			root : 'topics'
		}
	}
});