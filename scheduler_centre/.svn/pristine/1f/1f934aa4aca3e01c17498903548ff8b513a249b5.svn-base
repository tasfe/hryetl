Ext.define('banggo.store.taskManager.UpdateKettleDateStore', {
			extend : 'Ext.data.Store',
			model : 'banggo.model.taskManager.UpdateKettleDateModel',
			storeId : 'UpdateKettleDateStoreId',
			pageSize:20,
			proxy : {
				type : 'ajax',
				url : 'date/query.htm',
				reader : {
					type : 'json',
					root : 'topics',
					totalProperty : 'total'
				},
				write : {
					type : 'json'
				}
			}
		});