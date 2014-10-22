package com.man
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Quart;	
	import flash.display.MovieClip;
	import flash.events.ProgressEvent;
	/**
	 * loading加载类
	 * @author maning
	 */
	public class loading extends MovieClip 
	{
		private var _isGoto:Boolean;//是否按照时间轴播放
		private var _hideType:Function;
		public function loading ():void {
			TweenMax.to(this,0,{autoAlpha:0})
		}
		//关闭/隐藏
		public function hide():void {
			if (_hideType!=null) {
				_hideType();
			}else {
				TweenMax.to(this,.3,{delay:0.5,autoAlpha:0,ease:Quart.easeOut})
			}
		}
		//进度设置
		public function prosses(num:int):void{
			TweenMax.to(this, .3, { autoAlpha:1, ease:Quart.easeOut } )
			if (_isGoto) {
				this.gotoAndStop(num);
			}
			
			if (txt) {
				txt.text = num+"%"
			}
			if(num==100){
				hide();
			}
		}
		//进度设置相应事件
		public function prossEvent(e:ProgressEvent):void {
			var prog = int(ProgressEvent(e).bytesLoaded / ProgressEvent(e).bytesTotal * 100);
			prosses(prog);
		}
		
		public function get isGoto():Boolean 
		{
			return _isGoto;
		}
		
		public function set isGoto(value:Boolean):void 
		{
			_isGoto = value;
		}
		
		public function get hideType():Function 
		{
			return _hideType;
		}
		
		public function set hideType(value:Function):void 
		{
			_hideType = value;
		}
	}
	
}