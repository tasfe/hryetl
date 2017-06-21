Ext.define('banggo.model.menu.MenuModel', {
			extend : 'Ext.data.Model',
			fields : [{
						name : 'id',
						type : 'string'
					}, {
						name : 'expanded',
						type : 'boolean'
					}, {
						name : 'leaf',
						type : 'boolean'
					}, {
						name : 'text',
						type : 'string'
					}, {
						name : 'children',
						type : 'string'
					}, {
						name : 'description',
						type : 'string'
					}, {
						name : 'menuType',
						type : 'string'
					}, {
						name : 'checked',
						type : 'boolean',
						useNull :true//如果name为空不做转换处理
					}]
		});