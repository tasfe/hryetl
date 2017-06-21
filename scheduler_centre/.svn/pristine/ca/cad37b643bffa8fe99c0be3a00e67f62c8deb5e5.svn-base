Ext.define('banggo.store.taskManager.UserGroupStore', {
	extend : 'Ext.data.Store',
	model : 'banggo.model.taskManager.UserGroupModel',
	storeId : 'UserGroupStoreId',
	proxy : {
		type : 'ajax',
		url : 'scheUserGroup/query.htm',
  		actionMethods:{read:'post'},
		reader : {
			type : 'json',
			root : 'topics'
		}
	}
});