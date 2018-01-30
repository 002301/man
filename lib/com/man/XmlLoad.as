package com.man
{
    import flash.events.*;
    import flash.net.*;
	
	/**
	 * ...
	 * @author maning 
	 * 
	 * xmlLoad 1.0
	 * 
	   var xmlld:XmlLoad = new XmlLoad("url",comp);
	   
	   
	 * 
	 * 
	 */
	public class XmlLoad extends URLLoader 
	{
		private var _url:String;
		private var _xmlData:XML;
		private var _comp:Function;
		public function XmlLoad(url:String,comp:Function=null):void {
			if (url != "") {
				_url = url;
				_comp = comp;
				init();
			}else {
				//var err:Event = new Event();
			}
		}
		
		private function init():void {
			var loader:URLLoader = new URLLoader();
			configureListeners(loader);
			var request:URLRequest = new URLRequest(_url);
            try {
                loader.load(request);
            } catch (error:Error) {
                trace("Unable to load requested document.");
            }
		}
		
		private function configureListeners(dispatcher:IEventDispatcher):void {
			if (_comp == null) {
				dispatcher.addEventListener(Event.COMPLETE, completeHandler);
			}else {
				dispatcher.addEventListener(Event.COMPLETE, _comp);
				
			}
            
            dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
            dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
            dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
            dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
        }

        private function completeHandler(event:Event):void {
			//trace("xml Load Ok!")
            var loader:URLLoader = URLLoader(event.target);
			_xmlData = XML(loader.data); 
			this.data = loader.data; 
			//trace("xml : "+_xmlData)
			//this.dispatchEvent(new Event("complete"));
        }

        private function progressHandler(event:ProgressEvent):void {
           // trace("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
        }

        private function securityErrorHandler(event:SecurityErrorEvent):void {
           // trace("securityErrorHandler: " + event);
        }

        private function httpStatusHandler(event:HTTPStatusEvent):void {
           // trace("httpStatusHandler: " + event);
        }

        private function ioErrorHandler(event:IOErrorEvent):void {
            trace("ioErrorHandler: " + event);
        }
		
		 public function get xmlData():XML 
		{
			return _xmlData;
		}
		
		 public function set xmlData(value:XML):void 
		{
			_xmlData = value;
		}
		
		public function get url():String 
		{
			return _url;
		}
		
		public function set url(value:String):void 
		{
			_url = value;
		}
		
	}
}