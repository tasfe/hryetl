Ext.define('banggo.model.taskManager.JobModel', {
			extend : 'Ext.data.Model',
			fields : [{
						name : 'id',type:'string'//任务名称
					},{
						name : 'jobName',type:'string'//任务名称
					},{
						name:'jobGroup',type:'string'//任务组名称
					},{
						name:'appName',type:'string'//应用名称
					},{
						name:'beginDate',type:'int',convert:this.formatDate//开始时间
					},{
						name:'endDate',type:'int',convert:this.formatDate//结束时间
					},{
						name:'previousFireTime',type:'int',convert:this.formatDate//上次运行时间
					},{
						name:'nextFireTime',type:'int',convert:this.formatDate//下次运行时间
					},{
						name:'status',type:'int'//状态
					},{
						name:'connectTimeout',type:'string'
					},{
						name:'readTimeout',type:'string'
					},{
						name:'cronExp',type:'string'
					},{
						name:'remoteUrl',type:'string'
					},{
						name:'isAllowConcurrent',type:'int'
					}
					,{
						name:'type',type:'int'//任务类型
					}
					]
						
		});
		