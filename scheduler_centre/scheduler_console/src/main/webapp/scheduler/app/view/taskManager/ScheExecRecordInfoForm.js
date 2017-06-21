Ext.define('banggo.view.taskManager.ScheExecRecordInfoForm', {
	extend : 'Ext.form.Panel',
	alias : 'widget.scheExecRecordInfoForm',
	border : 0,
	region : 'center',
	layout:'fit',
	autoScroll:true,
	fieldDefaults : {
		labelAlign : 'right'// label位于field的位置（left,top,right）
//		labelWidth : 130
	},
	buttons : [{
				text : '关闭'
			}],
	initComponent : function() {
		var me = this;
		//创建模板
		var noWrapTextAreaTpl = new Ext.XTemplate(
			        '<textarea id="{id}" ',
			            '<tpl if="name">name="{name}" </tpl>',
			            '<tpl if="rows">rows="{rows}" </tpl>',
			            '<tpl if="cols">cols="{cols}" </tpl>',
			            '<tpl if="tabIdx">tabIndex="{tabIdx}" </tpl>',
			            'class="{fieldCls} {typeCls}" ',
			            'autocomplete="off" spellcheck="off" wrap="off">',
			        '</textarea>',
			        {
			            compiled: true,
			            disableFormats: true
			        }
			    );
		me.items = [{
			layout:'border',
			items:[{
			xtype : 'container',
			layout : 'hbox',
			region : 'north',
			extend : 'Ext.form.Panel',
			alias : 'widget.scheExecRecordInfoForm',
			frame : true,// 面板渲染效果
//			id : 'scheExecRecordInfoForm',
			border : 0,
			collapsible : true,
			items : [{
				xtype : 'container',
//				layout : 'fit',
				flex : 1,
				items : [{
							xtype: 'displayfield',
					        fieldLabel: '执行编号',
					        name: 'execNo',
					        value: ''
						}, {
							xtype: 'displayfield',
					        fieldLabel: '任务名称',
					        name: 'jobName',
					        value: ''
						}, {
							xtype: 'displayfield',
					        fieldLabel: '开始执行时间',
					        name: 'beginTime',
					        value: ''
						}
						, {
							xtype: 'displayfield',
					        fieldLabel: '状态',
					        name: 'status',
					        value: '',
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
						}]
			}, {
				xtype : 'container',
				layout : 'fit',
				flex : 1,
				defaultType : 'textfield',
				items : [{
							xtype: 'displayfield',
					        fieldLabel: '应用执行编号',
					        name: 'remoteExecNo',
					        value: ''
						}, {
							xtype: 'displayfield',
					        fieldLabel: '任务组名称',
					        name: 'jobGroup',
					        value: ''
						}, {
							xtype: 'displayfield',
					        fieldLabel: '结束执行时间',
					        name: 'endTime',
					        value: ''
						}
						, {
							xtype: 'displayfield',
					        fieldLabel: '执行结果',
					        name: 'result',
					        value: ''
						}]
			}]}, {
				xtype: 'textareafield',
		        fieldLabel: '异常信息',
//		        fieldSubTpl: noWrapTextAreaTpl,
		        name: 'exception',
		        layout:'anchor',
		        region : 'center',
		        autoCreate: {
                    tag: 'textarea',
                    spellcheck: 'false',
                    wrap: 'off'
                },
				autoScroll:true
//				wordWrap:false,
//				autoShow:false,
//		    	value: ''
			}]
		}];
		me.callParent(arguments);
	}
});