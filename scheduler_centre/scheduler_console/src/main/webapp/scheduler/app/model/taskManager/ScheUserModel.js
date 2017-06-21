Ext.define('banggo.model.taskManager.ScheUserModel', {
	extend : 'Ext.data.Model',
	fields : [
		{name:'id',type:'int'}, 
		{name:'email',type:'string'}, // 邮箱
		{name:'mobile',type:'string'}, // 手机
		{name:'userName',type:'string'}, // 用户名
		{name:'name',type:'string'}, // 姓名
		{name:'createDate',type:'int',convert:this.formatDate}, // 创建时间
		{name:'createBy',type:'string'}, // 创建人
		{name:'updateDate',type:'int',convert:this.formatDate}, // 更新时间
		{name:'updateBy',type:'string'} // 更新人
	]
});
		