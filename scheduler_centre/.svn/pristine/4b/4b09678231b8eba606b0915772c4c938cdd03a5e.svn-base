Ext.define('banggo.store.taskManager.ScheUserStore', {
	extend : 'Ext.data.Store',
	model : 'banggo.model.taskManager.ScheUserModel',
	storeId : 'UserGroupStoreId',
	proxy : {
		type : 'ajax',
		url : 'scheUserGroup/queryAllUser.htm',
		reader : {
			type : 'json',
			root : 'topics'
		}
	}
});