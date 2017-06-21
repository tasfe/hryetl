(function(window){
	$('div[class^="pointerDiv"]').live('mouseover', function(){
		var subs = $(this).find('div[class^="optDiv"],input[class^="optDiv"]');
		subs.css('visibility', 'visible');
	}).live('mouseout', function(){
		var subs = $(this).find('div[class^="optDiv"],input[type="checkbox"][class^="optDiv"]');
		subs.css('visibility', 'hidden');
	});
	
	var isDebug = false;
	/*
	* 图形的偏移量
	*/	
	var POSITION = {
		left : 10,
		top : 10
	};
	var VARS = {
		
	};
	var LINE = {
		vLen : 80
	};
	var pointWidth = 185, pointHeight = 30;
	var gap = 120;
	//横线
	function horiLine(x, y, len, className) {
		x += POSITION.left;
		y += POSITION.top;
		
		var div = '<div class="shadowDiv '+className+'" style="z-index : 10; position : absolute;left:'+x+'px;top:'+y+'px;width:'+len+'px;height:0px;border:1px solid black;"></div>';
		
		getLocationObj().append(div);
	}
	//竖线
	function vertLine(x, y, len, className) {
		x += POSITION.left;
		y += POSITION.top;
		var div = '<div class="shadowDiv '+className+'"  style="z-index : 10; position : absolute;left:'+x+'px;top:'+y+'px;width:0px;height:'+len+'px;border:1px solid black;"></div>';
		
		getLocationObj().append(div);
	}
	function drawPointer(obj) {
		
		if(obj.text == null) {
			return;
		}
		
		var lct = obj.pointerLocation();
		
		var x = lct.left;
		var y = lct.top;
	
		x += POSITION.left;
		y += POSITION.top;
		
		var debugHtml = '';
		if(isDebug) {
			debugHtml = '<div style="position : absolute;width : 100%; text-align : center;">('+x+','+y+')</div>';
		} 
		
		var t =obj.info;// '('+obj.text+')';//
		var className = obj.cn;
		$('div[class$=" '+className+'"]').remove();
		
		var checkBox = '<input type="checkbox" value="'+obj.text+'" class="pointerCheckBox" />';
		
		var div = '<div class="pointerDiv '+className+'" style="z-index : 15; position : absolute;left:'+x+'px;top:'+y+'px;width:'+pointWidth+'px;height:'+(pointHeight + 10)+'px;">'+
		'<div class="shadowDiv pointerText" title="'+t+'" style="z-index : 15;position : absolute;height:'+(pointHeight + 1)+'px;"><div style="color : black;padding-top:5px;overflow:hidden;white-space：normal">'+cutString(t)+debugHtml+'</div></div>'+
		'<div style="position : absolute;width:13px;height:13px;margin-top:'+(pointHeight + 3)+'px;">'+pointerOper(obj) + checkBox + '</div></div>';
		
		getLocationObj().append(div);
	}
	
	function cutString(s) {
		if(s == null || s.length < 20) {
			return s;
		}
		return s.substring(0, 20) + '<span style="font-size:10px;">...</span>';
	};
	
	function pointerOper(o) {
		var h = '';
		h += pointerOperHTML('red', 'common/images/delete.png',  function(o){
			Pointer.pointerRemove(o);
		}, o);
		
		h += pointerOperHTML('green', 'common/images/add.png', function(o, obj){
			Pointer.pointerAdd(o, obj);
		}, o);
		
		return h;
	};
	function pointerOperHTML(color, img, func, o) {
		return '<div style="position:relative; display:table-cell; font-size:5px;">&nbsp;</div>'+
		'<div class="optDiv" onclick="('+func+')(\''+o+'\', this);" style="position:relative; display:table-cell; '+
		'font-size:10px; width:14px;height:12px;background-color:'+color+';background-image:url('+img+')">&nbsp;&nbsp;&nbsp;&nbsp;</div>';
	};
	function getLocationObj() {
		
		return Pointer.getLoactionObj();
	};
	
	/***
	* 获取元素对象
	* 将流程图画到指定对象上
	*/
	Pointer.getLoactionObj = function() {
		return jQuery('body');
	};
	//删除某个节点，包括子节点
	Pointer.pointerRemove = function(o) {
		if(!confirm('确定删除？')) {
			return;
		}
		var obj = POINTER_STACK[o];
		if(obj.parent == null) {
			Ext.MessageBox.alert("提示",'开始节点不可以删除！');
			return;
		}
		if(obj) {
			obj.remove();
		}
	};
	//默认的新增节点操作方法，可以覆盖
	Pointer.pointerAdd = function(o, thisObj) {
		var targetParentPointer = POINTER_STACK[o];
		var t = prompt('新节点名字：');
			
		if(POINTER_STACK[t]) {
			if(!confirm('该节点已存在，是否放弃新增？\n【确认】：放弃\n【取消】：重新出入')) {
				t = prompt('新节点名字：');
			} else {
				return;
			}
		}
		if(POINTER_STACK[t]) {
			return;
		}
		
		if(t == null || t.length < 1) {
			return;
		}
		var temp = new Pointer(null, t);
		
		targetParentPointer.push(temp);
	};
	
	
	//节点数量
	Pointer.pointerLength = function(o) {
			var i = 0;
			var h = '';
			for(var j in POINTER_STACK) {
				if(checkNull(POINTER_STACK[j])) { continue; } 
				h += POINTER_STACK[j] + ', '
				i ++;
			}
			return i + '\n' + h;
			
	};
	
	//根据节点标识，获取节点信息
	Pointer.getAllPointers = function() {
		return POINTER_STACK;
	};
	//根据节点标识，获取节点信息
	Pointer.get = function(s) {
		return POINTER_STACK[s];
	};
	//设置根节点
	Pointer.setRoot = function(p) {
		ROOT = p;
		POINTER_STACK[p] = p;
	};
	//获取根节点
	Pointer.getRoot = function() {
		return ROOT;
	};
	//从【流程图树】生成【二叉树】
	Pointer.getB_Tree = function() {
		VAR_JOB_ID = -900;
		for(var i in POINTER_STACK) {
		if(checkNull(POINTER_STACK[i])) { continue; } 
			POINTER_STACK[i].hasHandle = false;
		}
		return bTree(ROOT);
	};
	//从【二叉树】生成【流程图树】
	Pointer.createFromB_Tree = function(btree, opt) {
		if(opt) {
			BTREE_OBJ_KEY.name = opt.n || BTREE_OBJ_KEY.name;
			BTREE_OBJ_KEY.left = opt.l || BTREE_OBJ_KEY.left;
			BTREE_OBJ_KEY.right = opt.r || BTREE_OBJ_KEY.right;
		}
		return filterPointerTree(getPointerTreeFromB_Tree(btree));
	};
	//清空整个【流程图树】
	Pointer.clearAll = function() {
		clearAll();
	};
	//将json对象转换成字符串
	Pointer.jsonToString = function(obj) {
		return jsonToString(obj);
	};
	Pointer.displayAll = function() {
		calculateRootAndDraw(ROOT);
	};
	Pointer.showCheckBox = function() {
		var subs = jQuery('input.pointerCheckBox');
		subs.each(function(){
			var pName = $(this).val();
			var pointer = Pointer.get(pName);
			if(pointer.subsSize() > 0 || pointer.mergeParent) {
				$(this).css('visibility', 'hidden');
			} else {
				$(this).css('visibility', 'visible');
			}
			$(this).css('visibility', 'visible');
		});
	};
	Pointer.hideCheckBox = function() {
		var subs = jQuery('input.pointerCheckBox');
		subs.css('visibility', 'hidden');
		jQuery('input.pointerCheckBox').attr('checked', false);
	};
	Pointer.getSelectedCheckBoxes = function() {
		var subs = jQuery('input.pointerCheckBox').filter(':checked');
		if(subs.length < 2) {
			Ext.MessageBox.alert("提示",'至少需选择两个节点！');
			return '';
		}
		return subs.map(function() {
			return $(this).val();
		}).get().join(',');
	};
	
	
	function clearAll() {
		for(var i in POINTER_STACK) {
			removeHTMLAndNode(POINTER_STACK[i]);
			delete POINTER_STACK[i];
		}
		ROOT = null;
		PointerCounter = 0;
		nameIndex = 0;
	}

	//保存所有在用节点
	var POINTER_STACK = {};
	//根节点
	var ROOT = null;
	function addNewPointer(p) {
		if(p == null) {
			return;
		}	
		
		POINTER_STACK[p] = p;
		if(p.subsSize() > 0) {
			for(var i in p.subs) {
				addNewPointer(p.subs[i]);
			}
		}
	}
	
	function delPointer(p) {
		if(p.subsSize() > 0) {
			for(var i in p.subs) {
				delPointer(p.subs[i]);
			}
		}
		if(p.mergeParent) {
			p.mergeParent.delMergeSub(p);
		}
		delete POINTER_STACK[p];
	}
	
	function checkNull(obj) {
		return obj == null;
	} 
	//节点计数，如果没有设置根节点则第一次初始化的节点默认为根节点
	var PointerCounter = 0;
	function Pointer(tx, info, x, y) {
		
		this.text = tx || getName();
		if(this.text == null) {
			return null;
		}
		this.info = info || this.text;
		this.x = x || 0;	//节点起点线的x坐标
		this.y = y || 0;	//节点起点线的y坐标
		this.subs = [];		//子节点
		this.cn = 'wj_' + this.text;	//相关HTML对象的className
		this.parent = null;		//节点的父节点
		this.level = 1;			//节点层次
		
		this.mergeSubs = {};
		this.mergeParent = null;	//节点的归一节点
		
		this.isDraw = false;
		
		this.data = {};
		
		this.type = '';
		
		if(PointerCounter == 0) {		//默认设置第一个初始化的节点为根节点，建议通过【Pointer.setRoot】方法设置
			Pointer.setRoot(this);
			PointerCounter ++;
		}
		
	}
	
	function defaultParam(newValue, defaultValue) {
		return newValue && newValue > defaultValue && newValue || defaultValue;
	};
	
	//如果是Pointer类型，则直接返回，如果是string，则查看是否已存在该名称的Pointer，有则返回，无则返回null
	function pointerOrPointerByStr(p) {
		if(p == null || p == 'null' || p.text == null) {
			return null;
		}
		if(p && ! (p instanceof Pointer)){
			p = POINTER_STACK[p] && POINTER_STACK[p] || null;
			if(p == null) {
				return null;
			}
		}
		return p;
	};
	
	//设置参数
	Pointer.setParameter = function(opt) {
		opt = opt || {};
		
		LINE.vLen = defaultParam(opt.vLen, LINE.vLen);
		
		pointWidth = defaultParam(opt.pWidth, pointWidth);
		pointHeight = defaultParam(opt.pHeight, pointHeight);
		
		POSITION.left = defaultParam(opt.left, POSITION.left);// + pointWidth / 2 + 2;
		POSITION.top = defaultParam(opt.top, POSITION.top);// + pointHeight;
		
		gap = defaultParam(opt.gap, gap);
	};


	Pointer.prototype.setXY = function(x, y) {
		this.x = x;
		this.y = y;
	};
	Pointer.prototype.getY = function() {
		return this.y;
	};
	Pointer.prototype.getX = function() {
		return this.x;
	};

	Pointer.prototype.toString = function() {
		return this.text;
	};
	Pointer.prototype.valueOf = function() {
		return this.text;
	};
	
	Pointer.prototype.addMergeSub = function(p) {
		if(p && ! (p instanceof Pointer)){
			return false;
		}
		
		
		addNewPointer(this);
		if(Pointer.get(p) == null) {
			addNewPointer(p);
		}
		
		if(this.mergeSubs[p] == null) {
			this.mergeSubs[p] = p;
		}
		
		var nLevel = p.level + 1;
		
		this.level = nLevel > this.level ? nLevel : this.level;
		
		p.mergeParent = this;
		return true;
	};
	Pointer.prototype.delMergeSub = function(p) {
		p = pointerOrPointerByStr(p);
		
		delete this.mergeSubs[p];
	};
	
	Pointer.prototype.setMergeParent = function(p) {
		if(p && ! (p instanceof Pointer) || this.mergeParent != null){
			return;
		}
		
		return p.addMergeSub(this);
	};
	
	//设置节点的data对象的属性值
	Pointer.prototype.setDataValue = function(k, v, isOverWrite) {
		isOverWrite = isOverWrite || true;
		if(isOverWrite || this.data[k] == null) {
			this.data[k] = v;
		}
	};
	/*
	*返回该节点的坐标信息
	*@return 
	*/
	Pointer.prototype.pointerLocation = function() { 
		var y = this.y - pointHeight - 2;
		var x = this.x - (pointWidth / 2);
		
		return {
			left : x,
			top : y
		};
	};
	
	/*
	*在html上画出节点信息
	*@return void
	*/
	Pointer.prototype.draw = function() {		
		jQuery('div[class$="'+this.cn+'"]').remove();
		
		var subLen = this.subsSize();

		drawPointer(this);
		var thisLevel = this.level;
		if(subLen > 0) {
			if(subLen == 1) {
				var subObj = null;
				for(var i in this.subs) {
					subObj = this.subs[i];
					if(checkNull(subObj)) { continue; } 
				}
				
				subObj.draw();
				
				if(this.x != subObj.x) {
					var deltY = (LINE.vLen - pointHeight) / 2;
					var scdY = this.y + deltY;
					vertLine(this.x, this.y, deltY, this.cn);
					vertLine(subObj.x, scdY, deltY, this.cn);
					
					var horiLen = Math.abs(this.x - subObj.x);
					horiLine(Math.min(this.x, subObj.x), scdY, horiLen, this.cn);
				} else {
					vertLine(this.x, this.y, LINE.vLen - pointHeight, this.cn);
				}
			} else {
				var minX = 10000, minY = 0, MaxX = 0;
				var nLen = (LINE.vLen - pointHeight) / 2 - 3;
				
				vertLine(this.x, this.y, nLen, this.cn);
				
				for(var i in this.subs) {
					
					if(checkNull(this.subs[i])) { continue; } 
						
					var pObj = this.subs[i];
					var tempX = pObj.getX();
					var tempY = pObj.getY();
					
					if(minX > tempX){
						minX = tempX;
					}
					
					if(tempX > MaxX) {
						MaxX = tempX;
					}
					
					minY = tempY - nLen - pointHeight - 4;
					vertLine(tempX, minY, nLen, this.cn);
						
					pObj.draw();
				}
				horiLine(minX, minY - 2, MaxX - minX, this.cn);
				
				var newY = this.y + nLen;
				if(this.x < minX) {
					horiLine(this.x, newY, minX - this.x, this.cn);
				}
			}
		}
	};
	
	/*
	*返回该节点的子节点数量
	*@return 子节点数量
	*/
	Pointer.prototype.subsSize = function() {
		return objSize(this.subs);
	};
	Pointer.prototype.mergeSubsSize = function() {
		
		return objSize(this.mergeSubs);
	};
	function objSize(obj) {
		if(obj) {
			var i = 0;
			for(var j in obj) {
				if(checkNull(obj[j]) || checkNull(POINTER_STACK[j])) { continue; } 
					
				i ++;
			}
			return i;
		}
		return 0;
	}
	/*
	*新增节点
	*@param 	p 需要新增的子节点
	*@return	自身
	*/
	Pointer.prototype.push = function(p){
		pushPointerTo(p, this);
		
	//	calculateRootAndDraw();
		Pointer.displayAll();
		return this;
	};
	function pushPointerTo(sub, parent) {		
		if(sub && ! (sub instanceof Pointer)){
			return;
		}
		
		if(sub == null) { 
			return;
		}
		
		//新增节点，保存信息
		addNewPointer(sub);
		
		sub.parent = parent;
		sub.level = parent.level + 1;
		sub.y = (sub.level - 1) * LINE.vLen;
		parent.subs[sub] = sub;
	};
	
	
	/*
	*删除节点
	*@param 	p 需要删除的子节点；如果p为空，则删除自身
	*@return	返回被删除的节点
	*/
	Pointer.prototype.remove = function(p){
		p = pointerOrPointerByStr(p);
		
		if(p) {	//如果指定要删除的元素，则删除
			
			var del = this.subs[p];
			if(del == null) {
				return this;
			} 
			var subs = del.subsSize();
			
			if(subs > 0) {
				for(var i in del.subs) {
					if(checkNull(del.subs[i])) { continue; } 
					//del.remove(del.subs[i]);
				}
			}
			removeHTMLAndNode(del);
			if(del.parent != null) {
				delete del.parent.subs[del];
			}
		
			calculateRootAndDraw();
			
			return del;
			
		} else if(this || this.parent) {	//否则删除自身
			removeHTMLAndNode(this);
			if(this.parent) {
				this.parent.remove(this);
			}
		//	calculateRootAndDraw();
			return this;
		}
		
		new Pointer('').push(this).remove(this);
	//	calculateRootAndDraw();
		delPointer(this);
	};
	
	function removeHTMLAndNode(p) {
		if(p && p.cn) {
			//删除节点html
			jQuery('div[class$="'+p.cn+'"]').remove();
			jQuery('div[class$="'+p.cn+'_merge"]').remove();
			if(p.subsSize() > 0) {
				for(var i in p.subs) {
					removeHTMLAndNode(p.subs[i]);
				}
			}
			delPointer(p);
		}
	};
	
	
	Pointer.prototype.displayAll = function() {
		var root = this;
		while(root.parent != null) {
			root = root.parent;
		};
	
		calculateRootAndDraw(root);
	};
	
	function calculateRootAndDraw(root, l) {
		l = l || 0;
		
		root = root || ROOT;
		
		resetLevel(ROOT);
		
		var rs = calculate(l, root);
		
		root.x = (rs.left + rs.right) / 2;
		
		ROOT.draw();
		
		Pointer.mergeJob();
	};
	
	//计算所有节点位置
	function calculate(l, p) {
		if(p.subsSize() == 0) {
			p.x = l;
			return {
				left : l,
				right : l
			};
		} else {
			var left = l, right = l;
			var preLocation = null;
			for(var i in p.subs) {
				var subObj = p.subs[i];
				
				if(preLocation == null) {
					preLocation = calculate(right, subObj);
				} else {
					right = preLocation.right + pointWidth + 20;
					preLocation = calculate(right, subObj);
				} 
				
				subObj.x = Math.ceil((preLocation.left + preLocation.right) / 2);
			} 
			return {
				left : left,
				right : preLocation.right
			};
		} 
	};
	function resetLevel(p, lvl) {
		lvl = lvl || 1;
		p.level = lvl;
		p.y = (p.level - 1) * LINE.vLen;
		if(p.subsSize() > 0) {
			for(var i in p.subs) {
				resetLevel(p.subs[i], lvl + 1);
			} 
		} 
	};
	
	
	function Node(n, l, r, d, info) {
		d = d || {};
		return {
			name : n,
			left : l,
			right : r,
			data : d,
			info : info || '',
			type : 'normal'
		};
	};
	function createNode(root) {
		return new Node(root.text, null, null, root.data, root.info);
	};
	var VAR_JOB_ID = -900;
	function createMergeNode(root){
		if(root.mergeParent) {//如果有汇聚节点
			var parentPointer = root.mergeParent;
			if(parentPointer.data.childrenJobId == null) {
				parentPointer.data.childrenJobId = VAR_JOB_ID;
				VAR_JOB_ID --;
			}
			var abstractNode = new Node('mg_' + parentPointer.text, null, null);
			abstractNode.type = 'barrier';
			abstractNode.info = 'barrier node';
			abstractNode.data = {};
			abstractNode.data.jobId = parentPointer.data.childrenJobId;
			return abstractNode;
		}
	};
	function bTree(root) {
		var p = createNode(root);
		if(root.subsSize() > 0) {
			var temp = null;
			for(var i in root.subs) {
				var subObj = root.subs[i];
				if(checkNull(subObj)) { continue; } 
				if(temp == null) {
					temp = bTree(subObj);
					p.right = temp;
				} else {
					var ntemp = bTree(subObj);
					temp.left = ntemp;
					temp = ntemp;
				}
			}
		}
		
		if(root.mergeParent) {
			p.right = createMergeNode(root);
			
			if(!root.mergeParent.hasHandle) {
				var newNode = bTree(root.mergeParent);
				p.right.right = newNode;
				root.mergeParent.hasHandle = true;
			}
		} 
		
		return p;
	};
	
	
	BTREE_OBJ_KEY = {
		name : 'name',
		left : 'left',
		right : 'right'
	};
	var POINTER_MERGE_MAP = {};
	function filterPointerTree(pt) {
		findMergePointer(pt);
		replaceMergePointer(pt);
		for(var i in POINTER_MERGE_MAP) {
			POINTER_STACK[i] = null;
		}
		return pt;
	};
	function replaceMergePointer(pt) {
		if(pt && pt.subsSize() > 0) {
			for(var i in pt.subs) {
				var obj = pt.subs[i];
				if(checkNull(obj)) { continue; } 
				
				if(obj.type == 'barrier') {
					
					var nextMerge = POINTER_MERGE_MAP[obj];
					
					if(nextMerge == null) {
						continue;
					}
					
					nextMerge.addMergeSub(pt);
					nextMerge.parent = null;
					pt.subs = {};
					
					replaceMergePointer(nextMerge);
				} else {
					replaceMergePointer(obj);
				}
			}
		}
	};
	
	function findMergePointer(pt) {
		if(pt && pt.subsSize() > 0) {
			for(var i in pt.subs) {
				var obj = pt.subs[i];
				if(checkNull(obj)) { continue; } 
				
				if(obj.type == 'barrier') {
					var nextMerge = null;
					for(var i in obj.subs) {
						nextMerge = obj.subs[i];
					}
					if(nextMerge != null) {
						POINTER_MERGE_MAP[obj] = nextMerge;
					}
				}
				findMergePointer(obj);
			}
		}
	};
	function getPointerTreeFromB_Tree(btree) {
		var p = btreeObjToPointer(btree);
		
		if(isNodeNotNull(btree[BTREE_OBJ_KEY.right])) {
			var tempP = null;
		
			tempP = getPointerTreeFromB_Tree(btree[BTREE_OBJ_KEY.right]);
			pushPointerTo(tempP, p);
				
			btree = btree[BTREE_OBJ_KEY.right];
			if(isNodeNotNull(btree[BTREE_OBJ_KEY.left])) {
				var parentPointer = p;
				var leftTreeNode = null;
				
				while((leftTreeNode = btree[BTREE_OBJ_KEY.left]) != null) {
					var leftP = isNodeNotNull(leftTreeNode.right) && getPointerTreeFromB_Tree(leftTreeNode) || btreeObjToPointer(leftTreeNode);
				
					pushPointerTo(leftP, parentPointer);
					
					btree = btree[BTREE_OBJ_KEY.left];
					
				};
			}
		}
		
		
		return p;
	}
	
	function isNodeNotNull(node) {
		return node && node.info;
	};
	/*
	* 二叉树对象转换成Pointer对象
	*/
	var nameIndex = 0;
	function getName(obj) {
		if(obj && obj.type == 'barrier'){
			return obj.name;
		}
		return 'P_' + (nameIndex ++);
	};
	function btreeObjToPointer(bt) {
		//alert(Pointer.jsonToString(bt));
		if(bt == null || bt.type == null) {
			return null;
		}
		
		var nm = getName(bt);
		
		if(POINTER_STACK[nm] != null) {
			return POINTER_STACK[nm];
		}
		var rsP = new Pointer(nm, bt.info);
		rsP.data = bt.data || {};
		rsP.type = bt.type;
		
		return rsP;
	}
	
	
	function jsonToString(o){
		if(o.constructor == Array){
			var h = '[';
			for(var i = 0; i < o.length; i += 1){
				var obj = o[i];
				h += jsonToString(obj);
				if(i < o.length - 1){
					h += ',';
				}
			}
			h += ']';
			return h;
		}else{
			return '{'+jts(o)+'}';
		}
	}
	function jts(o){
		var s = '';
		for(var i in o){
			if(typeof o[i] == 'object'){
				var temp = jts(o[i]);
				if(temp == '') {
					s += '\"' + i + '\"' + ': null,';
				} else {
					s += '\"' + i + '\"' + ':{'+jts(o[i])+'},';
				}
			}else{
				s += '\"' + i + '\"' + ':\"' + o[i] + '\",';
			}
		}
		if(s.charAt(s.length - 1) == ','){
			s = s.substring(0, s.length - 1);
		}
		return s;
	}
	


/*
*	节点聚合的相关操作
*/
Pointer.mergeJob = function() {
	clat();
	drawMerge();
};
function clat(r) {
	r = r || ROOT;
	
	if(r.mergeParent != null) {
		dealWithMerge(r.mergeParent);
	}
	if(r.subsSize() > 0) {
		for(var i in r.subs) {
			var subObj = r.subs[i];
			if(checkNull(subObj)) { continue; } 
			clat(subObj);
		}
	}
};
function dealWithMerge(p) {
	var mergeSubSize = objSize(p.mergeSubs);
	if(mergeSubSize >= 2) {
		var left = 10000, right = 0, level = 0;
		for(var i in p.mergeSubs) {
			var subObj = p.mergeSubs[i];
			if(checkNull(subObj)) { continue; } 
			if(subObj.x < left) {
				left = subObj.x;
			}
			if(subObj.x > right) {
				right = subObj.x
			}
			
			if(subObj.level > level) {
				level = subObj.level
			}
		}
		level += 1;
		
		p.x = Math.ceil((left + right) / 2);
		p.y = (level - 1) * LINE.vLen;
	} else {
		removeHTMLAndNode(p);
	}
}

/**
* 聚合，画图
*/
function drawMerge(p) {
	p = p || ROOT;
	
	if(p.mergeParent) {
		
		var mp = p.mergeParent;
		var mergeSubSize = objSize(mp.mergeSubs);
		if(mergeSubSize >= 2 && POINTER_STACK[mp] != null) {
			var cName = mp.cn + '_merge';
			jQuery('div[class$="'+cName+'"]').remove();
			
			drawPointer(mp);
			
			var finalY = mp.y - Math.ceil((LINE.vLen + pointHeight) / 2) - 2;
			vertLine(mp.x, finalY, mp.y - finalY - pointHeight - 3, cName);
			
			var left = 10000, right = 0;
			
			var maxLevel = 0;
			for(var i in mp.mergeSubs) {
				var subObj = mp.mergeSubs[i];
				if(checkNull(subObj)) { continue; } 
				
				var nLen = finalY - subObj.y;
				
				vertLine(subObj.x, subObj.y, nLen, cName);
				
				if(subObj.x < left) {
					left = subObj.x;
				}
				if(subObj.x > right) {
					right = subObj.x
				}
				
				if(subObj.level > maxLevel) {
					maxLevel = subObj.level;
				}
			}
			
			horiLine(left, finalY, right - left, cName);
			
			mp.level = maxLevel + 1;
			calculate(mp.x, mp);
			resetLevel(mp, mp.level);
			
			mp.draw();
		}
		
		p = p.mergeParent;
	}
	if(p.subsSize() > 0) {
		for(var i in p.subs) {
			var subObj = p.subs[i];
			if(checkNull(subObj)) { continue; } 
			
			drawMerge(subObj);
		}
	}
}

	window.Pointer = Pointer;
})(window);


/*******************************************************************************
 * 获取元素对象 将流程图画到指定对象上
 */
Pointer.getLoactionObj = function() {
	return jQuery('#fieldSetFlowId-body');
};
// 默认的新增节点操作方法，可以覆盖
Pointer.pointerAddNode = function(o, thisObjId, thisObjName) {
	var targetParentPointer = Pointer.get(o);
//	if (Pointer.get(thisObjId)) {
//		alert('已经存在节点' + thisObjName);
//		return;
//	}
	var temp = new Pointer(thisObjId, thisObjName);
	temp.setDataValue('jobId', thisObjId);
	temp.setDataValue('terminateOnError', 1);
	targetParentPointer.push(temp);
};
Pointer.pointerAdd = function(o, thisObj) {
	var win = Ext.create('banggo.view.taskManager.WorkFlowJobWindow', {
		jobId : o
	});
	win.show();
};
