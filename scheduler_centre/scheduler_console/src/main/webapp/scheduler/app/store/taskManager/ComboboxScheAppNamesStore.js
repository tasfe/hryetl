Ext.define('banggo.store.taskManager.ComboboxScheAppNamesStore', {
	extend : 'Ext.data.Store',
	model:'banggo.model.taskManager.ComboboxScheAppNamesModel',
	storeId : 'comboboxScheAppNamesStoreId',
	proxy : {
		type : 'ajax',
		url : 'job/prepareData.htm',
		reader : {
			type:'json',
			root:'scheAppNames'
		}
	}
});