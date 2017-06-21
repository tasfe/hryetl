Ext.define('banggo.store.taskManager.WorkFlowExecuteStore', {
			extend : 'Ext.data.Store',
			model : 'banggo.model.taskManager.WorkFlowExecuteModel',
			storeId : 'WorkFlowExecuteStoreId',
			pageSize:20,
			proxy : {
				type : 'ajax',
				url : 'chainfired/query.htm',
				reader : {
					type : 'json',
					root : 'scheChainExecuterList',
					totalProperty : 'total'
				},
				write : {
					type : 'json'
				}
			}
		});