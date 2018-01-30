package com.man
{
	/**
	 * ...
	 * @author maning
	 * 
	 * 调用网页js
	 * 
		import com.man.js
		js.alert(s)
	 * 
	 */
	public class js 
	{
		
		public function js() 
		{
			
		}
		public static function alert(s:String):void 
		{
			ExternalInterface.call("window.alert",s)
		}
		public static function console(s:String):void 
		{
			ExternalInterface.call("console.log",s)
		}
		
	}

}