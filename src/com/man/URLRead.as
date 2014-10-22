package com.man
{
	import flash.external.*;
	/**
	 * 获取地址栏属性
	 * @author maning
	 */
	public class URLRead 
	{
		private var urlPath:String;
		private var item:Array = new Array;
		private var _typeNum:String
		public function URLRead():void {
			//geturlhttp();
			//return urlPath;
		}
		//获取URL地址栏里面的变量值 v
		
		public function geturlhttp(v:String):int {
			urlPath = ExternalInterface.call("window.location.href.toString");
			if (urlPath != null) {
				var propertNum:int = urlPath.search("html");//查找URL里面的html字符串
				var properts:String = urlPath.slice(propertNum + 5);//获取URL字符串html后面的字符
				urlPath = properts;
				if (properts != null) {
					propertNum = properts.search(v);
					properts = properts.slice(propertNum+2);
					_typeNum = properts;
					return propertNum;
				}else{
					return 0;
				}
				
			}else{
				return 0;
			}
		}
		
		public function get typeNum():String 
		{
			return _typeNum;
		}
		
	}
	
}