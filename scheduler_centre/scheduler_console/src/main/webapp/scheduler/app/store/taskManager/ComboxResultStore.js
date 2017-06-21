Ext.define('banggo.store.taskManager.ComboxResultStore', {
			extend : 'Ext.data.Store',
			model : 'banggo.model.taskManager.ComboxResultModel',
			proxy : {
				type : 'ajax',
				url : 'scheduler/resources/data/taskManager/combox.json',
				reader : {
						type:'json',
						root:'topics_result'
					},
					write : {
						type : 'json'
					}
			}
		});