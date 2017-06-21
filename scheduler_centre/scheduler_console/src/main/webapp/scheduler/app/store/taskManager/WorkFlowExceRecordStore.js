Ext.define('banggo.store.taskManager.WorkFlowExceRecordStore', {
			extend : 'Ext.data.Store',
			model : 'banggo.model.taskManager.ScheExecRecordModel',
			storeId : 'WorkFlowExecRecordStoreId',
			pageSize:20,
			proxy : {
				type : 'ajax',
				url : 'chainfired/detail.htm',
				reader : {
					type : 'json',
					root : 'scheExecRecordROList',
					totalProperty : 'total'
				},
				write : {
					type : 'json'
				}
			}
		});