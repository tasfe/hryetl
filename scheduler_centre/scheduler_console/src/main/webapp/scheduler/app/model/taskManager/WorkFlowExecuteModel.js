Ext.define('banggo.model.taskManager.WorkFlowExecuteModel', {
			extend : 'Ext.data.Model',
			fields : [
			        {
			          	name : 'scheChainId',type:'int'//任务链执行ID
			          },
			         {
						name : 'id',type:'int'//任务链ID
					},{
						name : 'scheChianExecuterId',type:'string'//任务链执行编号
					},{
						name : 'scheChainName',type:'string'//任务链名称前端
					},{
						name : 'chainName',type:'string'//任务链名称后台
					},{
						name:'execNo',type:'string'//任务链编号
					},{
						name:'beginTimeFrom',type:'int',convert:this.formatDate//开始时间 
					},{
						name:'beginTimeTo',type:'int',convert:this.formatDate//结束时间
					},{
						name:'beginTime',type:'int',convert:this.formatDate//开始时间 
					},{
						name:'endTime',type:'int',convert:this.formatDate//结束时间
					},{
						name:'status',type:'string'//执行状态
					},{
						name:'scheChainVersion',type:'string'//任务链版本
					},{
						name:'exception',type:'string'//异常信息
					},{
						name:'appName',type:'string'//应用名称
					},{
						name:'jobName',type:'string'//任务名称
					},{
						name:'jobGroup',type:'string'//任务组
					}
					]
		});