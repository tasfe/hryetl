Ext.define('banggo.store.taskManager.ScheExceRecordStore', {
			extend : 'Ext.data.Store',
			model : 'banggo.model.taskManager.ScheExecRecordModel',
			storeId : 'ScheExecRecordStoreId',
			pageSize:20,
			proxy : {
				type : 'ajax',
				url : 'fired/query.htm',
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