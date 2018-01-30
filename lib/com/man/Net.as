package  com.man
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;
	import flash.net.URLLoader;
	import flash.utils.getTimer;
	import flash.system.LoaderContext;
	/**
	 * 
	 * @author maning
	 * 
	 * 通过submit发送一个网络请求
	 */
	public class Net extends Sprite
	{
		
		public var wrong:XML;
		private var isRandom:Boolean;
		private var _comp:Function;
		private var _error:Function;
		private var _url:String
		private var _Rvalue:URLVariables;
		private var _base64:Boolean;
		/*/ 初始化网络请求  
		comple：请求完毕执行的函数，  
		error：请求错误执行的函数；
		isR；是否带随机数
		Rvalue :设置POST参数
		_base64：是否Base64加密
		
		
		*/
		public function Net(comple:Function=null,error:Function=null,isR:Boolean=false)
		{
			isRandom = isR;
			_comp = comple;
			_error = error;
		}
		
		
		//提交数据
		public function submit(url:String)
		{
			//trace("url:"+url);
			_url = url;
			var request:URLRequest
			if (isRandom) {
				
				request = new URLRequest(url+"?temp="+Math.random()*10000);
			}else {
				
				request = new URLRequest(url);
			}
			
			if(_Rvalue){
				request.data = _Rvalue;
				request.method = URLRequestMethod.POST;//提交方式为post
			}
			
			//var request:URLRequest =new URLRequest("data.xml")
            var loader:URLLoader = new URLLoader();
			if (_comp != null) {
				loader.addEventListener(Event.COMPLETE,_comp);
			}else {
				
            loader.addEventListener(Event.COMPLETE,completeHandler);
			}
			if (_error != null) {
				loader.addEventListener(IOErrorEvent.IO_ERROR,_error);
			}else {
				loader.addEventListener(IOErrorEvent.IO_ERROR,errorHandler);
			}
            loader.load(request);
		}
		
		//验证完成
		private function completeHandler(e:Event):void {
			var d:XML = XML(e.target.data);
			wrong = d;
			if (wrong)
			{
				dispatchEvent(new Event("complete"));
			}else
			{
				//dispatchEvent(new Event("error"));
			}
			
        }
        
		
        private function errorHandler(event:IOErrorEvent):void{
              trace("数据上传失败");
        }
		
		public function get url():String 
		{
			return _url;
		}
		
		public function set url(value:String):void 
		{
			_url = value;
		}
		
		public function get Rvalue():URLVariables
		{
			return _Rvalue;
		}
		
		public function set Rvalue(value:URLVariables):void 
		{
			_Rvalue = value;
		}
		
		public function get base64():Boolean
		{
			return _base64;
		}
		
		public function set base64(value:Boolean):void 
		{
			_base64 = value;
		}
		
	}

}