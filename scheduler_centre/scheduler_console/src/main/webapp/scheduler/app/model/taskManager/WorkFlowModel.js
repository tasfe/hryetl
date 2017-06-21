Ext.define('banggo.model.taskManager.WorkFlowModel', {
			extend : 'Ext.data.Model',
			fields : [ 
			          {
						name : 'id',type:'int'//任务链ID
					},{
						name : 'chainName',type:'string'//任务链名称
					},{
						name:'isDelete',type:'string'//是否删除
					},{
						name:'createDate',type:'int',convert:this.formatDate//创建时间 
					},{
						name:'updateDate',type:'int',convert:this.formatDate//更新时间
					},{
						name:'createBy',type:'string'//创建人
					},{
						name:'updateBy',type:'string'//更新人
					},{
						name:'version',type:'int'//版本信息
					},
					{
						name:'queryVersion',type:'int'//查询条件版本号
					}
					]
		});