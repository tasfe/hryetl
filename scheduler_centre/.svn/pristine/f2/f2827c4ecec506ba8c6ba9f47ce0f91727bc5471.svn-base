Ext.define('banggo.view.taskManager.ScheExecRecordGrid', {
			extend : 'Ext.grid.Panel',
			alias : 'widget.scheExecRecordGrid',
			title : '任务执行查询明细',
			layout : 'fit',// 布局
			// frame : true,// 面板渲染效果
			store : 'taskManager.WorkFlowExceRecordStore',
			// animCollapse : true,
			closeAction : 'destroy',
			 id : 'scheExecRecordGrid',
			// autoExpandMax : 300,
			region : 'center', // border布局，将页面分成东，南，西，北，中五部分
			columns : [{
						xtype : 'rownumberer',
						width : 40,
						text : '序'
					}, {
						header : '执行编号',
						dataIndex : 'execNo',
						align : "center",
						sortable : true,
						renderer : function(value,metaDate,record,rowIndex,colIndex,store,view) {
							if (record.data.triggerType == 'm') {
//								metaDate.style = "background-color:red;";  
								return getLeftFormate(value+'-人工');
							} else{
								return getLeftFormate(value);
							}
						}
					}, {
						header : '应用名称',
						dataIndex : 'appName',
						align : "center",
						sortable : true,
						renderer : function(value) {
							return getLeftFormate(value);
						}
					}, {
						header : '任务名称',
						dataIndex : 'jobName',
						align : "center",
						sortable : true,
						renderer : function(value) {
							return getLeftFormate(value);
						}
					}, {
						header : '任务组名称',
						dataIndex : 'jobGroup',
						align : "center",
						sortable : true,
						renderer : function(value) {
							return getLeftFormate(value);
						}
					}, {
						header : '开始执行时间',
						dataIndex : 'beginTime',
						width : 160,
						xtype : 'datecolumn',
						format : 'Y-m-d H:i:s',
						align : "center",
						sortable : true,
						renderer : function(value) {
							return getRightFormate(value);
						}
					}, {
						header : '结束执行时间',
						dataIndex : 'endTime',
						width : 160,
						xtype : 'datecolumn',
						format : 'Y-m-d H:i:s',
						align : "center",
						sortable : true,
						renderer : function(value) {
							return getRightFormate(value);
						}
					}, {
						header : '状态',
						dataIndex : 'status',
						align : "center",
						sortable : true,
						renderer : function(value) {
							if (value == 0) {
								return "<div style='text-align:left;'>初始</div>";
							} else if (value == 1) {
								return "<div style='text-align:left;'>执行中</div>";
							} else if (value == 2) {
								return "<div style='text-align:left;'>执行结束</div>";
							} else if (value == -1) {
								return "<div style='text-align:left;'>未知</div>";
							} else if (value == -2) {
								return "<div style='text-align:left;'>调度失败</div>";
							}
						}
					}, {
						header : '执行结果',
						dataIndex : 'result',
						align : "center",
						sortable : true,
						renderer : function(value) {
							return getLeftFormate(value);
						}
					}, {
						header : '异常信息',
						width : 150,
						dataIndex : 'exception',
						align : "center",
						sortable : true
					}],
			
			selType : 'checkboxmodel',// 设定选择模式
			multiSelect : true,// 运行多选
			simpleSelect : true,// false只能选择一行，true可以选择多行
			selModel:{
				 	xtype:'checkboxmodel',
				 	checkOnly:true
			},//单选行无效必须选择按钮框
			initComponent : function() {
				var me = this;
				if(me.scheChainExecuteId!=null){
					me.store = Ext.create("banggo.store.taskManager.WorkFlowExceRecordStore");
				}else{
					me.store = Ext.create("banggo.store.taskManager.ScheExceRecordStore");
				}
				me.store.on("beforeload", function(store, options) {
					var params = {
						start : 0,
						limit : 15,
						jobId : me.jobId,
						jobName : me.jobName,
						appName : me.appName,
						jobGroup : me.jobGroup,
						scheChainExecuteId : me.scheChainExecuteId
					};
					// 传递搜索变量给数据源
					store.proxy.extraParams = params;
				});
				me.store.load();
				var items = [{
					xtype : 'button',
					text : '编辑',
					disabled : true,
					name : 'editScheExecRecordGrid',
					iconCls : "icon-cog-edit"
				}, {
					xtype : 'button',
					iconCls : "icon-reset",
					disabled : true,
				    name : 'btnScheGridInfo',
					text : '详情'
				}, {
					xtype : 'button',
					iconCls : "icon-accept",
					disabled : true,
					name : 'btnTerminalScheGrid',
					text : '终止'

				}];
//				if(me.taskFlag != 1){
					items.push('-',{
						xtype : 'numberfield',
						labelWidth : 113,
						width : 200,
						value : 10,
						allowBlank : false,//不能为空
						minValue:5,
						allowNegative:false,
						allowDecimals:false,
						regex:/^\d*$/,
						vtypeText :'请输入大于5的正整数',
//						id : 'textfieldScheGridId',
						name : 'refreshScheGridText',
						fieldLabel : '设置刷新时间(秒)'
					},{
						xtype : 'label',
//						id : 'scheFieldLabelId',
						text : '默认10秒刷新一次数据',
						margin : '0 0 0 10'
					});
//				}
				me.dockedItems = [{
						xtype : 'toolbar',
						items : items
					}, {
						xtype : 'pagingtoolbar',
						store : me.store,
						dock : 'bottom',
						displayInfo : true,
						emptyMsg : '没有数据',
						displayInfo : true,
						displayMsg : '当前显示{0}-{1}条记录 / 共{2}条记录 ',
						beforePageText : '第',
						afterPageText : '页/共{0}页'

					}],
				this.callParent(arguments);
			}
		});