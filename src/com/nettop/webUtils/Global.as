package com.nettop.webUtils {
	import flash.display.LoaderInfo;

	import com.nettop.webUtils.events.GlobalEvent;

	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.external.ExternalInterface;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display.Stage;
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;

	/**
	 * @author zeroWq
	 */
	public class Global {
		public static var DEBUG:Boolean = false;
		private static var _handle:EventDispatcher;
		private static var _lock:Object;
		private static var _root:DisplayObject;
		private static var _stage:Stage;
		private static var _index:Array;
		private static var _lastIndex:Array;
		private static var _data:Object;

		/**
		 * 初始化
		 * @param root: 根场景，自动获取stage并初始化，可以不设置，但是部分功能讲不能实现
		 */
		public static function init(root:DisplayObject):void {
			_root = root;
			_stage = _root.stage;
			_stage.scaleMode = StageScaleMode.NO_SCALE;
			_stage.align = StageAlign.TOP_LEFT;
			_stage.frameRate = 30;
		}

		/**
		 * 数据传递:获取
		 * @param label: 变量名
		 */
		public static function getData(label:String):Object {
			if(_data==null) {
				_data = {};
			}
			return _data[label];
		}

		/**
		 * 数据传递:传值
		 * @param label: 变量名
		 * @param value: 变量值
		 */
		public static function setData(label:String,value:Object):void {
			if(_data==null) {
				_data = {};
			}
			_data[label] = value;
		}

		/**
		 * 数据传递:清空
		 */
		public static function clearData():void {
			_data = {};
		}

		/**
		 * 打开链接
		 * @see 解决IE通过navigateToURL打开链接出现拦截警告问题
		 */
		public static function openUrl(url:String,target:String = "_blank"):void {
			if (ExternalInterface.available) {
				var browserAgent:String = ExternalInterface.call("function getBrowser(){return navigator.userAgent;}");

				if (browserAgent!=null && (browserAgent.indexOf("MSIE")>=0 || browserAgent.indexOf("Firefox")>=0)) {
					ExternalInterface.call("window.open", url, target);
				} else {
					navigateToURL(new URLRequest(url), target);
				}
			} else {
				navigateToURL(new URLRequest(url), target);
			}
		}

		/**
		 * 比较两个数组值是否相等
		 * @param arr1: 第一个数组
		 * @param arr2: 第二个数组
		 */
		public static function equal(arr1:Array,arr2:Array):Boolean {
			var result:Boolean = false;
			if(arr1.length!=arr1.length) {
				result = true;
			} else {
				for(var i:int = 0;i<arr1.length;i++) {
					if(arr1[i]!=arr2[i]) {
						result = true;
						break;
					}
				}
			}
			return result;
		}

		/**
		 * 获取相对路径
		 * @param target: 获取相对路径的元件目标，默认为null时取基于root的相对路径，否则获取元件所在swf的路径
		 */
		public static function getBaseUrl(target:DisplayObject = null):String {
			var li:LoaderInfo;
			if(target==null) {
				if(_root==null) {
					return "";
				} else {
					li = _root.loaderInfo;
				}
			} else {
				li = target.loaderInfo;
			}
			
			var tmp:String = li.url;
			tmp = tmp.substr(0, tmp.lastIndexOf("/") + 1);
			if(tmp==li.url) {
				tmp = tmp.substr(0, tmp.lastIndexOf("\\") + 1);
			}
			return tmp;
		}

		/**
		 * 事件管理:传播句柄
		 */
		public static function get handle():EventDispatcher {
			if(_handle==null) {
				_handle = new EventDispatcher();
			}
			return _handle;
		}

		/**
		 * 内页索引设置
		 * @param value: 索引值
		 */
		public static function set index(value:Array):void {
			if(!lock["index"]) {
				_lastIndex = _index;
				_index = value;
				var change:Boolean = false;
				if(_lastIndex==null) {
					_lastIndex = [0];
				}
				if(_index==null) {
					_index = [0];
					_lastIndex = [0];
					change = true;
				} else {
					change = equal(_index, _lastIndex);
				}
				if(change) {
					handle.dispatchEvent(new GlobalEvent(GlobalEvent.INDEX_CHANGE));
				}
			}
		}

		/**
		 * 获取当前内页索引
		 */
		public static function get index():Array {
			if(_index==null) {
				_index = [0];
			}
			return _index.concat();
		}

		/**
		 * 获取上次访问内页索引
		 */
		public static function get lastIndex():Array {
			if(_lastIndex==null) {
				_lastIndex = [0];
			}
			return _lastIndex.concat();
		}

		/**
		 * 根影片剪辑
		 */
		public static function get root():DisplayObject {
			return _root;
		}

		/**
		 * 舞台
		 */
		public static function get stage():Stage {
			return _stage;
		}

		/**
		 * 内页索引锁定
		 * @see loading或者正在切换index时需要将其锁定，防止切换逻辑出错
		 */
		public static function set lockIndex(value:Boolean):void {
			lock["index"] = value;
		}

		/**
		 * 防死锁
		 */
		private static function get lock():Object {
			if(_lock==null) {
				_lock = new Object();
			}
			return _lock;
		}
	}
}
