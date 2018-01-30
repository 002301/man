package com.nettop.webUtils {
	import flash.net.URLRequest;
	import flash.events.SecurityErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.events.Event;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLLoader;

	/**
	 * @author zeroWq
	 */
	public class PreLoad {
		private static var _list:Array;
		private static var _pause:Boolean = false;
		private static var _loadIndex:int = -1;
		private static var _loader:URLLoader;

		/**
		 * 添加下载列表
		 * @param url: 要添加的下载地址
		 */
		public static function add(url:String):void {
			init();
			_list.push(url);
			if(_loadIndex<0) {
				_loadIndex = 0;
			}
			load();
		}

		/**
		 * 继续预加载
		 */
		public static function resume():void {
			init();
			_pause = false;
			load();
		}

		/**
		 * 暂停预加载（当前不会暂停）
		 */
		public static function pause():void {
			_pause = true;
			try {
				_loader.close();
			}catch(error:Error) {
			}
		}

		/**
		 * 初始化，仅第一次生效
		 */
		private static function init():void {
			if(_list==null) {
				_list = [];
				_loadIndex = -1;
			}
			if(_loader==null) {
				_loader = new URLLoader();
				_loader.dataFormat = URLLoaderDataFormat.BINARY;
				_loader.addEventListener(Event.COMPLETE, completeHandler);
				_loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
				_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			}
		}

		/**
		 * 读取当前列表
		 */
		private static function load():void {
			if(!_pause) {
				var url:String = _list[_loadIndex];
				if(url!=null && url!="") {
					try {
						_loader.load(new URLRequest(url));
					}catch(error:Error) {
						loadNext();
					}
				}
			}
		}

		/**
		 * 读取列表下一个
		 */
		private static function loadNext():void {
			_loadIndex++;
			load();
		}

		/**
		 * 获取已预读的列表，仅供测试用
		 */
		public static function get loadedList():Array {
			return _list.slice(0, _loadIndex);
		}

		private static function completeHandler(event:Event):void {
			loadNext();
		}

		private static function ioErrorHandler(event:IOErrorEvent):void {
			loadNext();
		}

		private static function securityErrorHandler(event:SecurityErrorEvent):void {
			loadNext();
		}
	}
}
