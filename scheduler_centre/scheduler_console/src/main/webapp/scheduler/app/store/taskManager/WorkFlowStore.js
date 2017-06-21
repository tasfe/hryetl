Ext.define('banggo.store.taskManager.WorkFlowStore', {
			extend : 'Ext.data.Store',
			model : 'banggo.model.taskManager.WorkFlowModel',
			storeId : 'WorkFlowStoreId',
			pageSize:20,
			proxy : {
				type : 'ajax',
				url : 'chain/query.htm',
				reader : {
					type : 'json',
					root : 'scheChainList',
					totalProperty : 'total'
				},
				write : {
					type : 'json'
				}
			}
		});