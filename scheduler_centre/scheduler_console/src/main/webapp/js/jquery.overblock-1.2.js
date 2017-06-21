/**
 * 弹出层
 * 可以同时存在多个弹出层，每次处于遮罩层以上的只能有一个
 * @author  	wujian
 * @date		2011-02-10
 * @version		1.2
 */
(function(jQuery){ 
	
	//默认浮层参数
	var defaults = {
		blockStyle:{
			color:'black',			//遮罩层默认颜色
			opacity:0.5				//遮罩层默认透明度（0：透明，1：不透明）
		},
		closeable:true,				//点击遮罩层是否可关闭弹出层，true:可关闭，false:不可关闭
		fadeTime:0,					//弹出层渐变时间
		marginLeft : -1,
		marginTop:-1,				//弹出层距离顶部高度，默认居中
		single:false,				//是否只显示一个浮层；true：此浮层只会单独显示，显示时隐藏其他浮层
		scroll:false,				//浮层是否和页面一起滚动；true：浮层随页面一起滚动，false：浮层固定
		blockView:true				//是否显示遮罩层；true：显示（默认）
	}
	
	var init_index = 0;					//初始化序号
	var scrollTop = 0;				//滚动高度
	var scrollLeft = 0;				//滚动横向变量
	var zIndex = 1000;				//遮罩层最低zIndex
	
	//绑定到jQuery对象上的索引key，e.g.:$().data(key,value)
	//绑定到遮罩层的可视浮层选选择器字符串
	var dataKey_TOP_POP = 'dataKey_TOP_POP' + new Date().getTime();
	
	//绑定到浮层对象上的   浮层、遮罩层样式对象
	var dataKey_STYLE_OPTION = 'dataKey_STYLE_OPTION' + new Date().getTime();
	
	//绑定到遮罩层上的对象：最后一次初始化的浮层选择器
	var dataKey_CURRENT_POP = 'dataKey_CURRENT_POP' + new Date().getTime();
	
	//绑定到遮罩层上的对象：最后一次初始化的浮层序号（序号递增）
	var dataKey_INIT_INDEX = 'dataKey_INIT_INDEX' + new Date().getTime();
	
	jQuery.fn.extend({
		
		/***
		* 显示浮层
		* @opts:	浮层参数
		*			当opts类型为object时：1、空对象{}，则用默认样式覆盖浮层原样式；2、设置了属性（非空），对原样式或默认样式进行覆盖
		*			当opts为数值型，则覆盖样式的fadeTime属性值
		**/
		showPop : function(opts){
			
			//深度复制参数，为用户未指定的参数赋默认值
			var options = null;
			options = copyPrototypes(defaults, jQuery(this).data(dataKey_STYLE_OPTION), opts);
			
			//是否有新的浮层参数
			var isNewStyle = false;
			
			//如果传入浮层参数，不是object类型，则认为是数值
			if(opts && !(typeof opts == 'object')){
				
				var time = isNaN(opts) == false ? opts : 0;
				
				//当未指定新样式时，如果该浮层存在样式参数，则获取参数
				if(jQuery(this).data(dataKey_STYLE_OPTION) != null){
					options = jQuery(this).data(dataKey_STYLE_OPTION);
				}
				
				//重设fadeTime参数
				options.fadeTime = time;
				
				//认为设置样式参数
				isNewStyle = true;
				
			}else if(opts && typeof opts == 'object'){
				
				isNewStyle = true;
				
			}else{
				
				//当未指定新样式时，如果该浮层存在样式参数，则获取参数
				if(jQuery(this).data(dataKey_STYLE_OPTION) != null){
					
					isNewStyle = true;
					
					options = jQuery(this).data(dataKey_STYLE_OPTION);
					
				}
			}
			
			//保存当前浮层参数并返回
			var newOpt = params(this, options, isNewStyle);
			
			//初始化浮层以前一律隐藏
			//设置其可见度为 可见（visible）
			jQuery(this).css({'display':'none','visibility':'visible'});
			
			//获取页面元素最大z-index，如果最大的z-index小于指定数值，则取指定数值
			zIndex = maxIndex(zIndex) + 2;
			
			//初始化遮罩层并返回jQuery对象
			var overObj = initOverBlock(this,isNewStyle);
			
			if(newOpt.blockView){
				overObj.fadeIn(newOpt.fadeTime);
			}else{
				overObj.hide(0);
			}
			
			//如果用户指定只显示一个浮层，则隐藏其他浮层
			if(newOpt.single == true){
				
				//隐藏其他浮层
				hideAllPops(overObj);
			}
			
			//初始化当前浮层并显示
			initPop(this).fadeIn(newOpt.fadeTime);
			
			//保存一些参数
			topPop(overObj, this);
			
			//绑定事件：当页发生滚动时
			if(!newOpt.scroll){
				windowOnScroll();
			}
			
			return filterFunction(jQuery(this));
		},
		
		/***
		* 隐藏浮层
		* @time:	隐藏浮层的耗时（毫秒）
		* 其他浮层参数在显示浮层时确定
		**/	
		hidePop : function(time){
			time = time || 0;
			
			//隐藏当前浮层
			jQuery(this).fadeOut(time);
			
			var overobj = getOverBlock();
			
			topPop(overobj, true);
			
			//如果还有其他浮层显示，则保留遮罩层
			if(overobj && overobj.data(dataKey_TOP_POP) != null && overobj.data(dataKey_TOP_POP).length > 0){
				
				//获取最上层的可是浮层
				var pops = overobj.data(dataKey_TOP_POP).split(',');
				
				//重新显示（初始化）
				jQuery(pops[pops.length - 1]).showPop();
				
			}else{
			
				//无其他浮层，则隐藏遮罩层
				hideOverBlock();
			}
			
			return jQuery(this);
		},
			
		/***
		* 显示浮层
		* @t:	显示浮层的耗时（毫秒）
		* 兼容旧版本
		**/	
		showBox : function(t){
			t = t || 0;
			
			//获取默认参数
			var tempOpt = defaults;
			
			//保留用户输入的时间，默认0
			tempOpt.fadeTime = t;
			
			//调用showPop来显示浮层，传入参数
			return jQuery(this).showPop(tempOpt);
		},
			
		/***
		* 隐藏浮层
		* @t:	隐藏浮层的耗时（毫秒）
		* 兼容旧版本
		**/	
		hideBox : function(t){
			t = t || 0;
			
			return jQuery(this).hidePop(t);
		}
		
	});
	
	$ = function( selector, context ) {
		
		if( typeof selector == 'string'){
			
			var o = new jQuery.fn.init( selector, context );
			
			if(o.data(dataKey_STYLE_OPTION) != null){
				
				return filterFunction(o);
			}
			
		}
		
		return new jQuery.fn.init( selector, context );
	}
	
	/***
	* 复制参数
	* @dft		默认参数
	* @opt		传入参数
	**/
	var copyPrototypes = function(dft, old, opt){
		
		var newopt = {};
		
		if(opt == null || typeof opt != 'object'){
			
			return old || dft;
			
		}else if(getObjLength(opt) < 1){
			
			return dft;
			
		}else{
			dft = old || dft;
				
			for(var i in dft){
				//如果该属性值为对象，则递归复制（深度复制）
				if(typeof dft[i] == 'object'){
					
					newopt[i] = copyPrototypes(dft[i],dft[i],opt[i]);
				}else{
					
					newopt[i] = opt[i] != null ? opt[i] : dft[i];
				}
			}
		}
		
		return newopt;
	}
	
	/***
	*  设置参数（当前显示的所有的浮层选择器组成的字符串，最上层的在最后面，选择器之间以逗号连接，）
	*  @overObj		遮罩层对象，jQuery对象
	*  @flag		（可选参数）
	*					flag : true --->	表示隐藏最上层的浮层，将其选择器移出模拟栈				return		最后移出的浮层的jQuery对象
	*					flag ：false || 不填    --->     获取最上层浮层的对象（jQuery对象），		return		最上层浮层的jQuery对象
	*					flag ：当前浮层的选择器或该选择器对应的对象（jQuery对象）					return		最后新加入浮层的jQuery的对象
	**/
	var topPop = function(over_Obj, flag){
		
		var overObj = null;
		
		//如果为传入遮罩层对象
		if(arguments.length < 1 ){
			
			//尝试获取已初始化的遮罩层对象
			overObj = getOverBlock();
			
			//获取失败，则返回
			if(overObj.length < 1){
				return null;
			}
		}else{
			
			//传入遮罩层对象，则赋值
			overObj = over_Obj;
		}
		
		//未传入flag参数或传入false，则false
		flag = flag || false;
		
		//传入string时，则被认为是浮层选择器，根据选择器获取对象
		//传入非string时，则认为是浮层的jQuery对象
		flag = typeof flag == 'string' ? jQuery(flag) : flag;
		
		//当参数数组长度为1，而且flag为false
		//获取最上层可视浮层的jQuery对象
		if(arguments.length == 1 && flag == false){
			
			//获取储存在遮罩层对象上的参数（当前可视浮层选择器的字符串）
			var popStr = overObj.data(dataKey_TOP_POP) || '';
			
			//不存在可视浮层，返回null
			if(popStr == null || popStr.length < 1){
				return null;
			}
			
			var popArray = popStr.split(',');
			
			//返回最上层的可是浮层jQuery对象
			return jQuery(popArray[popArray.length - 1]) || null;
		
		}else if(flag != null){
			
			//获取储存在遮罩层对象上的参数（当前可视浮层选择器的字符串），并转换为数组
			var popArray = (overObj.data(dataKey_TOP_POP) || '').split(',');
			
			//获取当前浮层的选择器
			var currentPopID = flag.selector || '';
			
			var temp = ''
				
			//新数组，保存当前可视浮层选择器
			var newPopArray = new Array();
			
			/*遍历选择器数组，生成新的当前可视浮层选择器数组
			* 	保证保存在遮罩层对象的选择器不重复
			* 	而且删除当前目标浮层的选择器
			*/
			for(var i = 0; i < popArray.length; i ++){
				
				//保留当前遍历的选择器字符串
				temp = popArray[i];
				
				/*
				* 当前遍历字符串不为空且不在新数组中且不等于当前选择器字符串、选择器数组长度大于0
				* 保存该遍历的字符串
				*/
				if(popArray[i] != null && popArray[i].length > 0 && !isInArray(temp, newPopArray) && currentPopID != temp){
					newPopArray.push(temp)
				}
			}
			
			//当flag为jQuery对象
			if(typeof flag == 'object'){
				
				//往新数组重新压入当前的浮层选择器，以保证其处于最上层
				newPopArray.push(currentPopID);
				
				//设置其参数
				overObj.data(dataKey_TOP_POP, newPopArray.join(','));
			
				//返回当前浮层jQuery对象
				return flag;
				
			}else if(flag){
				
				//获取最上层的选择器，并将其从堆栈中删除
				var topTopID = newPopArray.pop();
				
				//重新设置参数
				overObj.data(dataKey_TOP_POP, newPopArray.join(','));
				
				//返回获取的对象
				return jQuery(topTopID);
				
			}
		}
		
	}
	
	/***
	* 隐藏所有浮层
	* @overObj		遮罩层对象
	**/
	var hideAllPops = function(over_Obj){
		
		var overObj = null;
		
		//尝试获取已初始化的遮罩层对象
		overObj = getOverBlock();
		
		//获取失败，则返回
		if(overObj.length < 1){
			return null;
		}
		
		//获取参数（遮罩层jQuery对象）
		overObj = over_Obj || overObj;
		
		//获取所有可视浮层的选择器字符串
		var popArray = (overObj.data(dataKey_TOP_POP) || '').split(',');
		
		//遍历数组，逐个隐藏
		for(var i = 0; i < popArray.length; i ++){
			
			var popObj = jQuery(popArray[i]);
			
			if(popObj.length > 0){
				popObj.hide(0);
			}
		}
		
		//设置参数为空
		overObj.data(dataKey_TOP_POP,'');
		overObj.removeData(dataKey_TOP_POP);
	}
	
	/***
	* 隐藏遮罩层
	**/
	var hideOverBlock = function(){
		
		var blockObj = null;
		
		//获取遮罩层对象
		blockObj = getOverBlock();
		
		//删除最上层遮罩层选择器字符串
		topPop(blockObj, true);
		
		//针对IE，设置SELECT元素的可见度
		if(isIE6()){
			$('body').find('select').css('visibility','visible');
		}
		
		//隐藏遮罩层
		blockObj.fadeOut(0);
		
	}
	
	/***
	* 获取遮罩层对象
	**/
	var getOverBlock = function(){
		
		var blockObj = null;
		
		if(jQuery('body').find('div[id^="overblock"]').length > 0){
			
			blockObj = jQuery('body').find('div[id^="overblock"]');
		}
		
		return blockObj;
	}
	
	/***
	* 设置浮层样式
	* @thisObj			当前浮层的this对象
	* @options			浮层样式
	* @isNewStyle		是否有新样式
	**/
	var params = function(thisObj,option,isNewStyle){
		
		//当获取到当前浮层的对象，且其对应的旧样式参数为空或有新样式
		if(jQuery(thisObj).length > 0 && (jQuery(thisObj).data(dataKey_STYLE_OPTION) == null || isNewStyle)){
			
			//重新设置参数
			jQuery(thisObj).data(dataKey_STYLE_OPTION,option);
		}
		
		//返回该样式
		return jQuery(thisObj).data(dataKey_STYLE_OPTION);
	}
	
	/***
	* 初始化浮层
	* @thisObj		浮层的this对象
	**/
	var initPop = function(thisObj){
		
		//转换为jQuery对象
		var obj = jQuery(thisObj);
		
		//设置距离顶部的高度
		var floatTop = (obj.data(dataKey_STYLE_OPTION) != null && !isNaN(obj.data(dataKey_STYLE_OPTION).marginTop)) ? obj.data(dataKey_STYLE_OPTION).marginTop : -1;
		
		var mLeft = Math.ceil((jQuery(window).width() - obj.width())/2);
		
		var mTop = Math.ceil((jQuery(window).height() - obj.height())/2);
		
		if(floatTop >= 0){
			mTop = floatTop;
		}
		
		if(isIE6()){
			mTop += scrollTop;
			obj.css({
				'position':'absolute',
				'left':mLeft+'px',
				'top':mTop+'px',
				'z-index':zIndex
			});
		}else{
			mLeft += scrollLeft;
			obj.css({
				'left':mLeft+'px',
				'top':mTop+'px',
				'z-index':zIndex
			});
			
			var options_ = obj.data(dataKey_STYLE_OPTION);

			if(!options_.scroll){
				obj.css('position','fixed');
			}else{
				obj.css('position','absolute');
			}
		}
			
		return obj.hide();
	}
	
	/***
	* 初始化遮罩层
	* @thisobj			当前浮层的this对象
	* @isnewstyle		是否新样式
	**/
	var initOverBlock = function(thisobj,isnewstyle){
		
		var blockObj = null;
		
		var obj = jQuery(thisobj);
		
		//获取遮罩层对象，如果没用，则追加遮罩层元素
		if(jQuery('body').find('div[id^="overblock"]').length > 0){
			
			blockObj = jQuery('body').find('div[id^="overblock"]');
		}else{
			//生成一个随机的ID
			var blockID = "overblock" + randomName();
			
			jQuery('body').append('<div id="' + blockID +'"></div>').css('margin','0');
			
			//获取遮罩层jQuery对象
			blockObj = jQuery("#" + blockID);
		}
		
		//如果遮罩层对象上已存在浮层对象，而且存在dataKey_INIT_INDEX属性 而且不是新样式
		if(blockObj && blockObj.data(dataKey_CURRENT_POP) != null && obj.data('dataKey_INIT_INDEX') != null && isnewstyle == false){
			
			var cObj = blockObj.data(dataKey_CURRENT_POP);
			
			//如果当前对象的dataKey_INIT_INDEX 等于 遮罩层保存的当前对象的dataKey_INIT_INDEX属性，则无需再次初始化遮罩层
			if(obj.data('dataKey_INIT_INDEX') == cObj.data('dataKey_INIT_INDEX')){

				return blockObj;
			}
			
			//设置当前浮层对象为当前对象
			blockObj.data(dataKey_CURRENT_POP, obj);
			
		}else{
			
			//重新设置dataKey_INIT_INDEX属性
			obj.data('dataKey_INIT_INDEX',init_index);
			
			//初始化序号自增1
			init_index ++;
			
			//重新设置当前对象
			blockObj.data(dataKey_CURRENT_POP, obj);
		}
		
		//获取当前对象的样式参数
		var opt = (obj.data(dataKey_STYLE_OPTION) || defaults).blockStyle;
		
		var ob_width = 0;
		var ob_height = 0;
		
		//页面宽度
		ob_width = document.body.scrollWidth;
		
		//页面高度
		ob_height = document.body.scrollHeight < jQuery(window).height() ? jQuery(window).height() : document.body.scrollHeight;
		
		//设置遮罩层样式
		blockObj.css({
			'position':'absolute',
			'background-color':opt.color,
			'top':'0px',
			'left':'0px',
			'width':ob_width + 'px',
			'height':ob_height + 'px',
			'z-index':zIndex - 1,
			'opacity':opt.opacity
		});
			
		//针对IE，设置SELECT元素的可见度
		if(isIE6()){
			$('body').find('select').css('visibility','hidden');
		}
		
		//给遮罩层绑定单独的click事件
		blockObj.unbind('click').bind('click',function(){
			
			//获取最顶层的可视浮层对象
			var topObj = topPop(blockObj);
			
			//当该可视浮层对应的样式参数中closeable属性为true时，才允许关闭
			if(topObj && topObj.data(dataKey_STYLE_OPTION).closeable != null && topObj.data(dataKey_STYLE_OPTION).closeable == true){
				
				if(blockObj && blockObj.data(dataKey_TOP_POP) != null && blockObj.data(dataKey_TOP_POP).length > 0){
					
					//隐藏最顶上的可视浮层
					topObj.hidePop(topObj.data(dataKey_STYLE_OPTION).fadeTime);
				}else{
					
					//隐藏遮罩层
					blockObj.fadeOut(topObj.data(dataKey_STYLE_OPTION).fadeTime);
					//隐藏所有浮层
					hideAllPops(blockObj);
				}
				
			}
		});
		
		return blockObj;
	}
	
	/***
	* 遮罩层大小重设
	**/
	var blockResize = function(){
		
		var ob_width = 0;
		var ob_height = 0;
		
		ob_width = document.body.scrollWidth;
		
		ob_height = document.body.scrollHeight < jQuery(window).height() ? jQuery(window).height() : document.body.scrollHeight;
		
		var blockObj = jQuery('body').find('div[id^="overblock"]');
		
		blockObj.css({
			'width':ob_width + 'px',
			'height':ob_height + 'px'
		});
		return blockObj;
	}
	
	/***
	* 弹出层位置重设
	**/
	var floatsReposition = function(){
		
		var blockObj = getOverBlock();
		
		var objs = null;
				
		//获取所有可视浮层对象
		if(blockObj && blockObj.data(dataKey_TOP_POP) != null && blockObj.data(dataKey_TOP_POP).length > 0){
			
			objs = jQuery(blockObj.data(dataKey_TOP_POP));
		}
		
		if(objs != null){
			objs.each(function(){
				var obj = jQuery(this);
				
				//计算出浮层的左边距
				var mLeft = Math.ceil((jQuery(window).width() - obj.width())/2);
				
				//计算出浮层的上边距
				var mTop = Math.ceil((jQuery(window).height() - obj.height())/2);
				
				//如果该浮层对应的marginTop不为空，且为大于0的数字
				if(obj && obj.data(dataKey_STYLE_OPTION) != null && !isNaN(obj.data(dataKey_STYLE_OPTION).marginTop) && obj.data(dataKey_STYLE_OPTION).marginTop >= 0){
					mTop = obj.data(dataKey_STYLE_OPTION).marginTop;
				}
				
				if(isIE6()){
					mTop += scrollTop;
					obj.css({
						'left':mLeft+'px',
						'top':mTop+'px'
					});
				}else{
					mLeft += scrollLeft;
					obj.css({
						'left':mLeft+'px',
						'top':mTop+'px'
					});
				}	
			});	
		}
	}
	
	/***
	* 窗口大小发生变化时触发的事件
	**/
	var windowOnResize = function(){
		
		//页面大小发生变化时
		jQuery(window).resize(function(){
			
			//重新初始化遮罩层，重设大小
			blockResize();
			
			//重定位浮层
			floatsReposition();
		});
	}
	
	/***
	* 页面滚动时触发事件
	* 针对IE6.0设定
	**/
	var windowOnScroll = function(){
		
		//针对IE6.0浏览器，浮层的定位样式为absolute，
		//当页面滚动时，需要重新定位
		//其他浏览器，浮层定位样式为fixed
		if(isIE6()){
			jQuery(window).scroll(function(){
				
				//滚动的高度
				scrollTop = (document.documentElement && document.documentElement.scrollTop) ? document.documentElement.scrollTop : document.body.scrollTop;
				//滚动的宽度
				scrollLeft = (document.documentElement && document.documentElement.scrollLeft) ? document.documentElement.scrollLeft : document.body.scrollLeft;	
				
				var blockObj = getOverBlock();
				
				var obj = null;
				
				//获取所有可视浮层对象
				if(blockObj && blockObj.data(dataKey_TOP_POP) != null && blockObj.data(dataKey_TOP_POP).length > 0){
					
					obj = jQuery(blockObj.data(dataKey_TOP_POP));
				}
				
				//存在可视浮层对象，则遍历，重新定位
				if(obj != null){
					obj.each(function(){
						
						var mLeft = Math.ceil((jQuery(window).width() - jQuery(this).width())/2);
						
						var mTop = Math.ceil((jQuery(window).height() - jQuery(this).height())/2);
							
						mTop += scrollTop;
						
						mLeft += scrollLeft;
						
						jQuery(this).stop().animate({top:mTop,left:mLeft},300);
					
						//jQuery(this).css({'top':mTop+'px','left':mLeft+'px'});
					});
				}
			});
		}
	}
	
	/***
	* 获取body子元素中最大的z-index
	* @index		指定的最新z-index
	**/
	var maxIndex = function(index){
		
		var obj = jQuery('body');
		
		index = index || 0;
		
		//获取所有对象
		var childrens = obj.children();
		
		//当前z-index
		var cindex = index;
		
		//遍历对象
		for(var i = 0; i < childrens.length; i ++){
		
			var tempIndex = childrens.eq(i).css('z-index');
			
			//当遍历对象已设置z-index属性，且可以转换为数字，且大于当前z-index
			if(tempIndex != null && !isNaN(parseInt(tempIndex)) && parseInt(tempIndex) > parseInt(cindex)){
				
				cindex = parseInt(tempIndex);
			}
		}
		
		return cindex;
	}
	
	/***
	* 判断当前字符串是否在目标数组中
	* @str		当前字符串
	* @array	目标数组
	**/
	var isInArray = function(str, array){
		
		for(var i = 0; i < array.length; i ++){
			
			if(str == array[i]){
				
				return true;
			}
		}
		return false;
	}
	
	/***
	*	计算样式对象的属性个数
	* 	不是对象，返回-1；空对象返回0
	*/
	var getObjLength = function(obj){
		if(typeof obj != 'object'){
			return -1;
		}else{
			var i = 0;
			for(var p in obj){
				i ++;
				//防止死循环
				if(i > 50){
					return i;
				}
			}
			return i;
		}
	}
	
	/***
	* 判断是否是 IE6.0 浏览器
	**/
	var isIE6 = function(){
		
		if(!-[1,]){
			//获取浏览器信息
			var na = navigator.appVersion;
			
			type = na.split(";")[1].replace(/[ ]|M|S/g,"");
			
			if(type == 'IE6.0'){
				return true;
			}
		}else{
			return false;
		}
		return false;
	}
	
	/***
	* 随机获取ID
	**/
	var randomName = function(){
 		return "_" + (new Date()).getTime() + "_" + Math.floor(1000*Math.random() + 10) ;
	}
	
	//绑定事件：当页面大小发生变化时
	windowOnResize();
	
	var filterFunction = function(o){
		o.hide = function(){
				return this;
		}
		o.show = function(){
			return this;
		}
		o.toggle = function(){
			return this;
		}
		o.fadeOut = function(){
			return this;
		}
		o.fadeIn = function(){
			return this;
		}
		o.fadeTo = function(){
			return this;
		}
		o.slideUp = function(){
			return this;
		}
		o.slideDown = function(){
			return this;
		}
		o.slideToggle = function(){
			return this;
		}
		o.animate = function(){
			return this;
		}
		
		return o;
	}
	
})(jQuery);

