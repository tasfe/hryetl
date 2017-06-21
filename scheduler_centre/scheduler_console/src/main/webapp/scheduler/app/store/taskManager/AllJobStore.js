Ext.define('banggo.store.taskManager.AllJobStore', {
	extend : 'Ext.data.Store',
	model : 'banggo.model.taskManager.JobModel',
	storeId : 'AllJobStoreId',
	proxy : {
		type : 'ajax',
		url : 'workJob/query.htm',
		reader : {
			type : 'json',
			root : 'topics'
		}
	}
});