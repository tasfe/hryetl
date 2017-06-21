Ext.define('banggo.store.taskManager.ComboxStatusStore', {
			extend : 'Ext.data.Store',
			model : 'banggo.model.taskManager.ComboxStatusModel',
			proxy : {
				type : 'ajax',
				api : {
					read : 'scheduler/resources/data/taskManager/combox.json'
				},
				reader : {
					type : 'json',
					root : 'topics_Status'
				},
				write : {
					type : 'json'
				}
			}
		});