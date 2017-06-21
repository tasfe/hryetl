Ext.define('banggo.model.taskManager.ScheExecRecordModel', {
			extend : 'Ext.data.Model',
			fields : [{
						name : 'jobId',type:'int'//任务名称
					},{
						name : 'jobName',type:'string'//任务名称
					},{
						name : 'execId',type:'int'//隐藏主键
					},{
						name:'jobGroup',type:'string'//任务组名称
					},{
						name:'appName',type:'string'//应用名称
					},{
						name:'beginTime',type:'int',convert:this.formatDate//开始时间 
					},{
						name:'endTime',type:'int',convert:this.formatDate//结束时间
					},{
						name:'remoteExecBegin',type:'int',convert:this.formatDate//上次运行时间
					},{
						name:'remoteExecEnd',type:'int',convert:this.formatDate//下次运行时间
					},{
						name:'status',type:'string'//状态
					},{
						name:'execNo',type:'string'//执行编号
					},{
						name:'exception',type:'string'//异常信息
					},{
						name:'result',type:'string'//执行结果
					},
					{
						name:'remoteExecNo',type:'string'//应用执行编号
					},{
						name:'triggerType',type:'string'//人工标志
					}
					]
		});