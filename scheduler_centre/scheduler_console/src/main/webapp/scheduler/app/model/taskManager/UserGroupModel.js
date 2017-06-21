Ext.define('banggo.model.taskManager.UserGroupModel', {
	extend : 'Ext.data.Model',
	fields : [
		{name:'id',type:'string'}, 
		{name:'name',type:'string'}, // 用户组名称
		{name:'createDate',type:'int',convert:this.formatDate}, // 创建时间
		{name:'createBy',type:'string'}, // 创建人
		{name:'updateDate',type:'int',convert:this.formatDate}, // 更新时间
		{name:'updateBy',type:'string'} // 更新人
	]
});
		