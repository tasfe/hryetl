Ext.define('banggo.model.taskManager.WorkJobModel', {
	extend : 'Ext.data.Model',
	fields : [
		{name:'id',type:'string'}, 
		{name:'scheJobId',type:'string'}, // 任务ID
		{name:'jobName',type:'string'}, // 任务名称
		{name:'jobGroup',type:'string'}, // 任务组
		{name:'appName',type:'string'}, // 应用名称
		{name:'frequency',type:'string'}, // 通知频率
		{name:'frequencyUnit',type:'string'}, // h 小时; d 天
		{name:'status',type:'int'}, // 1 正常 0 停止
		{name:'acceptAlarmBegin',type:'int',convert:this.formatDate}, // 接收通知的起始时间
		{name:'acceptAlarmEnd',type:'int',convert:this.formatDate}, // 接收通知的结束时间
		{name:'scheUserGroupId',type:'string'}, // 用户组
		{name:'groupName',type:'string'}, // 用户组名称
		{name:'alarmMethod',type:'int'} // 通知方式 1短信 2 email
	]
});
		