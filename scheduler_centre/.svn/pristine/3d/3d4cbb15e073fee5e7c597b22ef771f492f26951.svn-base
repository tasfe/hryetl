/**
 * 带时分秒的日期控件
 * @author linzhichao
 */
Ext.define('banggo.util.DateTime', {
    extend:'Ext.form.field.Date',
    alias: 'widget.datetimefield',
    requires: ['banggo.util.DateTimePicker'],
    trigger1Cls: Ext.baseCSSPrefix + 'form-clear-trigger',
    trigger2Cls: Ext.baseCSSPrefix + 'form-date-trigger',
    editable : false,
    format : 'Y-m-d H:i:s',
    /**
     * 添加清除按钮
     */
    initComponent: function() {  	
    	var me = this;
		me.onTrigger2Click = Ext.clone(me.onTrigger1Click);
		me.onTrigger1Click = function(){
			me.reset();
		}
		
		me.callParent(arguments);
    },
    /**
     * 创建时间选择器
     * @return {}
     */
    createPicker: function() {
        var me = this,
            format = Ext.String.format;
        return new banggo.util.DateTimePicker({
            pickerField: me,
            ownerCt: me.ownerCt,
            renderTo: document.body,
            floating: true,
            hidden: true,
            focusOnShow: true,
            minDate: me.minValue,
            maxDate: me.maxValue,
            disabledDatesRE: me.disabledDatesRE,
            disabledDatesText: me.disabledDatesText,
            disabledDays: me.disabledDays,
            disabledDaysText: me.disabledDaysText,
            format: me.format,
            showToday: me.showToday,
            startDay: me.startDay,
            minText: format(me.minText, me.formatDate(me.minValue)),
            maxText: format(me.maxText, me.formatDate(me.maxValue)),
            listeners: {
                scope: me,
                select: me.onSelect
            },
            keyNavConfig: {
                esc: function() {
                    me.collapse();
                }
            }
        });
    },
    /**
     * 控制按钮的显隐
     */
    afterRender: function(){
        this.callParent();
        if(this.hideTrigger1){//隐藏清除按钮
        	this.triggerCell.item(0).setDisplayed(false);
        }
        if(this.hideTrigger2){//隐藏选择按钮
        	this.triggerCell.item(1).setDisplayed(false);
        }
    },

    /**
     * @private
     * 设置选择器的值
     */
    onExpand: function() {
        var me = this,
            value = me.getValue() instanceof Date ? me.getValue() : new Date();
        me.picker.setValue(value);
        
        me.picker.hour.setValue(value.getHours());
        me.picker.minute.setValue(value.getMinutes());
        me.picker.second.setValue(value.getSeconds());
    }
});
