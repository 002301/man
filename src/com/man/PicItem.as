package com.man
{
	import com.man.picList.PicItem;
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.greensock.TweenMax;
	/**
	 * ...
	 * @author maning
	 */
	public class PicItem extends Sprite 
	{
		private var loadMC:Loader;
		private var _data:XML;
		public function PicItem(item:XML):void {
			if (item.pic != "")
			{
				_data = item;
				loadPic(item.pic);
			}
		}

		private function loadPic(url:String):void
		{
			loadMC= new Loader();
			loadMC.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderHaldren);
			try {
				trace(url)
				loadMC.load(new URLRequest(url));
			}catch (myError:Error) { 
			 trace("error caught: " + myError);
			 trace("pic loading err::" + url);
			} 
			
		}

		private function loaderHaldren(e:Event):void
		{
			//loadMC.width = 200;
			//loadMC.height = 200;
			loadMC.y = loadMC.height;
			//loadMC.x = -40;
			this.addChild(loadMC);
			TweenMax.to(loadMC, 0.5, { y:0 , x:0 } );
		}
		
		public function get data():XML 
		{
			return _data;
		}
		
	}
}