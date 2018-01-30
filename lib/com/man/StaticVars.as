package com.man {
	import flash.display.MovieClip;
	import flash.external.ExternalInterface;
	/**
	 * 添加检测类
	 * 包括一个Wt和一个GA检测通用代码
	 * @author maning
	 */
	public class StaticVars extends MovieClip{
		public function StaticVars() {
			// constructor code
		}
		//调用 root["trackEvent"]("txt")("txt")("txt")("txt")
		public static function trackEvent(TITLE:String,URL:String,str_1:String="",str_2:String=""):void{
			//var trackingStr = dcsMultiTrack('WT.ti','激情操控','DCS.dcsuri','/cx7/peference/break','WT.cg_n','cx7','WT.cg_s','peference','WT.cg_3','break');
			//trace(URL);
			var site:String = "";
			trace(TITLE,URL,str_1,str_2)
			if (ExternalInterface.available)
			{
				if (str_1 == "")
				{
					ExternalInterface.call("dcsMultiTrack","WT.ti",TITLE,"DCS.dcsuri",URL);
				}
				else if (str_2 == "")
				{
					ExternalInterface.call("dcsMultiTrack","WT.ti",TITLE,"DCS.dcsuri",URL,"WT.event",str_1);
					//ExternalInterface.call("dcsMultiTrack","WT.ti",TITLE,"DCS.dcsuri",URL,"WT.cg_n",str_1,"WT.cg_s",str_2);
				}
				else
				{
					ExternalInterface.call("dcsMultiTrack","WT.ti",TITLE,"DCS.dcsuri",URL,"WT.cg_n",site,"WT.cg_s",str_1,"WT.cg_3",str_2);
				}
			}
		}
		//调用root["linkListener"]("test");
		public static function linkListener(str:String):void
		{
			if (ExternalInterface.available) {
				ExternalInterface.call("_gaq.push",["_trackPageview",str]);
				trace("_gaq.push(_trackPageview,"+str+" )")
			}
		}
		//  StaticVars.ga('/flash/1/vurl/button_navigation','阿特兹产品站_导航')
		public static function ga(str:String,srt1:String):void
		{
			if (ExternalInterface.available) {
				//ExternalInterface.call("_gaq.push",["_trackPageview",str]);
				ExternalInterface.call('ga','send','pageview',str,srt1);
				trace("ga(send,pageview,"+str+" )")
			}
		}
	}
}
