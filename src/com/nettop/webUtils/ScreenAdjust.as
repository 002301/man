package com.nettop.webUtils{
	import flash.geom.Rectangle;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.display.Stage;
	import flash.display.DisplayObject;

	/**
	 * @author zeroWq
	 */
	public class ScreenAdjust {
		private var _width:Number;
		private var _height:Number;
		private var _alignList:Array;
		private var _scaleList:Array;
		private var _fixValue:Boolean;
		private var _stage:Stage;

		/**
		 * 构造函数
		 * @param stage: 场景，默认为null，需通过resize手动调整全局大小，如果不为null，根据stage宽高自动匹配
		 * @param fixValue: 坐标修正为整数，默认为true
		 */
		public function ScreenAdjust(stage:Stage = null,fixValue:Boolean = true) {
			clearAll();
			_fixValue = fixValue;
			_stage = stage;
			if (_stage!=null) {
				_width = _stage.stageWidth;
				_height = _stage.stageHeight;
				_stage.scaleMode = StageScaleMode.NO_SCALE;
				_stage.align = StageAlign.TOP_LEFT;
				_stage.addEventListener(Event.RESIZE, resizeHandler);
			} else {
				_width = 800;
				_height = 600;
			}
		}

		/**
		 * 添加对齐元件
		 * @param item: 要添加的元件
		 * @param rateX: 水平百分比（0~1）
		 * @param rateY: 垂直百分比（0~1）
		 * @param offsetX: 水平偏移坐标
		 * @param offsetX: 垂直偏移坐标
		 * 
		 * @see 坐标定位公式 item.x=_width*rateX+offsetX, item.y=_height*rateY+offsetY
		 */
		public function addAlignObj(item:DisplayObject,rateX:Number = 0,rateY:Number = 0,offsetX:Number = 0,offsetY:Number = 0):void {
			var obj:Object = {};
			obj["item"] = item;
			obj["rateX"] = rateX;
			obj["rateY"] = rateY;
			obj["offsetX"] = offsetX;
			obj["offsetY"] = offsetY;
			_alignList.push(obj);
			alignItem(obj);
		}

		/**
		 * 通过场景对齐方式添加对齐元件
		 * @param item: 要添加的元件
		 * @param alignType: 基于StageAlign字符串的对齐方式，默认为"center"，任何非StageAlign内字符串都会转换成"center"
		 * @param checkRect: 检测边界，true时以元件内容所占位置对齐，false时以元件(0,0)点为对齐
		 */
		public function addAlignObjByType(item:DisplayObject,alignType:String = "center",checkRect:Boolean = false):void {
			var rect:Rectangle;
			if (checkRect) {
				rect = item.getBounds(item);
			} else {
				rect = new Rectangle();
			}
			switch (alignType) {
				case StageAlign.TOP :
					addAlignObj(item, 0.5, 0, -rect.x - rect.width / 2, -rect.y);
					break;
				case StageAlign.TOP_LEFT :
					addAlignObj(item, 0, 0, -rect.x, -rect.y);
					break;
				case StageAlign.TOP_RIGHT :
					addAlignObj(item, 1, 0, -rect.x - rect.width, -rect.y);
					break;
				case StageAlign.LEFT :
					addAlignObj(item, 0, 0.5, -rect.x, -rect.y - rect.height / 2);
					break;
				case StageAlign.RIGHT :
					addAlignObj(item, 1, 0.5, -rect.x - rect.width, -rect.y - rect.height / 2);
					break;
				case StageAlign.BOTTOM :
					addAlignObj(item, 0.5, 1, -rect.x - rect.width / 2, -rect.y - rect.height);
					break;
				case StageAlign.BOTTOM_LEFT :
					addAlignObj(item, 0, 1, -rect.x, -rect.y - rect.height);
					break;
				case StageAlign.BOTTOM_RIGHT :
					addAlignObj(item, 1, 1, -rect.x - rect.width, -rect.y - rect.height);
					break;
				default :
					addAlignObj(item, 0.5, 0.5, -rect.x - rect.width / 2, -rect.y - rect.height / 2);
			}
		}

		/**
		 * 清除对齐列表其中一个元件
		 * @param item: 要清除的对象
		 */
		public function removeAlignObj(item:DisplayObject):void {
			for (var i:int = _alignList.length - 1; i>=0; i--) {
				var obj:Object = _alignList[i];
				if (obj!=null && obj["item"]==item) {
					_alignList[i] = null;
				}
			}
		}

		/**
		 * 添加缩放元件
		 * @param item: 要添加的元件
		 * @param scaleType: 基于StageScaleMode字符串的缩放模式，具体效果见Flash帮助文档
		 * @param direction: 缩放方向，"all"时缩放宽高，"width"只缩放宽，"height"只缩放高
		 */
		public function addScaleObj(item:DisplayObject,scaleType:String,direction:String = "all"):void {
			var obj:Object = {};
			obj["item"] = item;
			obj["scaleType"] = scaleType;
			obj["width"] = item.width;
			obj["height"] = item.height;
			switch (direction.toLowerCase()) {
				case "width" :
					obj["direction"] = "width";
					break;
				case "height" :
					obj["direction"] = "height";
					break;
				default :
					obj["direction"] = "all";
			}
			_scaleList.push(obj);
			scaleItem(obj);
		}

		/**
		 * 清除缩放列表其中一个元件
		 * item: 要清除的对象
		 */
		public function removeScaleObj(item:DisplayObject):void {
			for (var i:int = _scaleList.length - 1; i>=0; i--) {
				var obj:Object = _scaleList[i];
				if (obj!=null && obj["item"]==item) {
					_scaleList[i] = null;
				}
			}
		}

		/**
		 * 手动调整尺寸
		 * @param width: 更改全局宽度
		 * @param height: 更改全局高度
		 */
		public function resize(width:Number,height:Number):void {
			_width = width;
			_height = height;
			for each (var ao:Object in _alignList) {
				alignItem(ao);
			}
			for each (var so:Object in _scaleList) {
				scaleItem(so);
			}
		}

		/**
		 * 清空自适应列表
		 */
		public function clearAll():void {
			_alignList = [];
			_scaleList = [];
		}

		/**
		 * 销毁
		 */
		public function dispos():void {
			clearAll();
			if (_stage!=null) {
				_stage.addEventListener(Event.RESIZE, resizeHandler);
			}
		}

		/**
		 * 对齐单独一个元件
		 * @param itemData: 列表中获取的对齐数据
		 */
		private function alignItem(itemData:Object):void {
			if (itemData!=null) {
				var item:DisplayObject = itemData["item"];
				if (item!=null) {
					if (item.stage==null) {
						removeAlignObj(item);
					} else {
						var rateX:Number = itemData["rateX"];
						var rateY:Number = itemData["rateY"];
						var offsetX:Number = itemData["offsetX"];
						var offsetY:Number = itemData["offsetY"];
						item.x = _width * rateX + offsetX;
						item.y = _height * rateY + offsetY;
						if (_fixValue) {
							item.x = Math.round(item.x) ;
							item.y = Math.round(item.y) ;
						}
					}
				}
			}
		}

		/**
		 * 缩放单独一个元件
		 * @param itemData: 列表中获取的缩放数据
		 */
		private function scaleItem(itemData:Object):void {
			if (itemData!=null) {
				var item:DisplayObject = itemData["item"];
				if (item!=null) {
					if (item.stage==null) {
						removeScaleObj(item);
					} else {
						var scaleType:String = itemData["scaleType"];
						var direction:String = itemData["direction"];
						var width:Number = itemData["width"];
						var height:Number = itemData["height"];
						var rate:Number = width / height;
						if (scaleType==StageScaleMode.EXACT_FIT) {
							if (direction=="all" || direction=="width") {
								item.x = 0;
								item.scaleX = _width / width;
							}
							if (direction=="all" || direction=="height") {
								item.y = 0;
								item.scaleY = _height / height;
							}
						} else if (scaleType==StageScaleMode.NO_SCALE) {
							item.scaleX = 1;
							item.scaleY = 1;
							item.x = (_width - width) / 2;
							item.y = (_height - height) / 2;
						} else {
							var rate2:Number = _width / _height;
							if (scaleType==StageScaleMode.NO_BORDER) {
								if (rate>rate2) {
									item.scaleX = item.scaleY = _height / height;
									item.x = (_width - width*item.scaleX) / 2;
									item.y = 0;
								} else {
									item.scaleX = item.scaleY = _width / width;
									item.y = (_height - height*item.scaleY) / 2;
									item.x = 0;
								}
							} else if (scaleType==StageScaleMode.SHOW_ALL) {
								if (rate>rate2) {
									item.scaleX = item.scaleY = _width / width;
									item.y = (_height - height*item.scaleY) / 2;
									item.x = 0;
								} else {
									item.scaleX = item.scaleY = _height / height;
									item.x = (_width - width*item.scaleX) / 2;
									item.y = 0;
								}
							}
						}
						if (_fixValue) {
							item.x = Math.round(item.x);
							item.y = Math.round(item.y);
						}
					}
				}
			}
		}

		private function resizeHandler(event:Event):void {
			resize(_stage.stageWidth, _stage.stageHeight);
		}
	}
}