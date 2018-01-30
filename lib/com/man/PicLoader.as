package com.man
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	/**
	 * 图片加载类
	 * @author maning
	 */
	public class PicLoader 
	{
		private var _url:String;
		private var _load:Loader;
		private var mc:DisplayObject;
		private var center:Boolean;
		private var onComplete:Function = null;
		private var _par;
		public function PicLoader (url, parentMc = null,cent:Boolean=false,comp:Function=null,progr:Function=null):void {
			//trace("PicLoader " + url + " Mc " + parentMc)
			onComplete = comp;
			_par = parentMc;
			if (url == "") {
				trace("url is null")
			}else  {
				center = cent;
				_url = url;
				_load = new Loader();
				if (progr == null) {
					_load.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
				}else {
					_load.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progr);
				}
				_load.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompletes);
				_load.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
				
				//_load.load(new URLRequest(url));
				
				
			}
			
		}
		public function load():void {
			//trace("load   "+_url);
			_load.load(new URLRequest(_url),new LoaderContext(true));
		}
		public function stop():void {
			//_load.close();
			_load.unload();
		}
		private function onCompletes(e:Event):void 
		{
			//trace("loadOK!!!!")
			var pic = new Sprite();
			var mbp = e.target.content;
			if (onComplete != null) {				
				onComplete(e);
			}else {
				mbp.smoothing = true;
				//trace(e.target.content)
				while(_par.numChildren>0)_par.removeChildAt(0)
				pic.addChild(mbp);
				_par.addChild(pic);
			}
			
			mc = pic;
			//mc = _load.content; 
			if (center) {
				pic.x = -pic.width / 2;
				pic.y = -pic.height / 2;
				
			}
			
		}
		
		private function onError(e:IOErrorEvent):void 
		{
			trace("loading error!!" + e )
		}
		
		private function onProgress(e:ProgressEvent):void 
		{
			//trace("loading...")
			//var prog = int(ProgressEvent(e).bytesLoaded / ProgressEvent(e).bytesTotal * 100)
		}
		
		public function get loadMc():Loader 
		{
			return _load;
		}
		
		public function get Mc():Object 
		{
			return mc;
		}
		
		
	}
	
}