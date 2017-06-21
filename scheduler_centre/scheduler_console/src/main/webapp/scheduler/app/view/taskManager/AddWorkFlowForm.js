Ext.define('banggo.view.taskManager.AddWorkFlowForm', {
	extend : 'Ext.form.Panel',
	alias : 'widget.addWorkFlowForm',
	border : 0,
	region : 'center',
	layout : 'border',
	requires : [ 'banggo.util.DateTime', 'banggo.util.DateTimePicker' ],
	padding : '6 7 6 7',
	items : [ {
		xtype : 'fieldset',
		layout : 'fit',
		region : 'north',
		title : '基本信息',
		defaultType : 'textfield',
		defaults : {
			labelAlign : 'right'
		},
		collapsible : true,
		items : [ {
			xtype : 'container',
			layout : 'hbox',
			// region : 'north',
			// padding : '1 7 1 7',
			items : [ {
				xtype : 'container',
				layout : 'anchor',
				flex : 1,
				// padding : '6 7 6 7',
				defaults : {
					anchor : '50%',
					labelAlign : 'right'
				},
				defaultType : 'textfield',
				items : [ {
					fieldLabel : '任务链名称',
					// padding : '16 7 16 7',
					allowBlank : false,
					name : 'chainName'
				} ]
			}, {
				xtype : 'hidden',
				name : 'version'
			}, {
				xtype : 'hidden',
				name : 'id'
			} ]
		} ]
	}, {
		xtype : 'fieldset',
		layout : 'anchor',
		region : 'center',
		autoScroll : true,
		collapsible : true,// 可以收缩
		title : '任务链流程图',
		id : 'fieldSetFlowId'
	} ],
	dockedItems : [ {
		xtype : 'toolbar',
		dock : 'bottom',
		ui : 'footer',
		layout : {
			pack : 'center'
		},
		items : [{
			text : '选择节点',
			minWidth : 80,
			id : 'showAddWorkFlowFormBtnId'
		}, {
			text : '聚合',
			minWidth : 80,
			id : 'togetAddWorkFlowFormBtnId'
		}, {
			text : '保存',
			minWidth : 80,
			id : 'saveAddWorkFlowFormBtnId'
		}
//		,{
//			text : '重置',
//			minWidth : 80,
//			id : 'resetAddWorkFlowFormBtnId'
//		}
		, {
			text : '关闭',
			minWidth : 80,
			id : 'closeAddWorkFlowFormBtnId'
		} ]
	}

	],
	initComponent : function() {
		var me = this;
		me.callParent(arguments);
	}
});