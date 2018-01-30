package com.man
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * @author maning
	 * 三张图片切换类
	 */
	public class ImgCarousel extends MovieClip
	{
		private var tableMc:Array;
		private var contMc:Array;
		private var linkURL:Array;
		private var selectNum:int;
		private var _this:MovieClip;
		private var time:Timer = new Timer(4000,0);
		public function ImgCarousel():void {
			init();
		}
		
		private function init():void {
			trace("picShow！！")
			_this = this;
			tableMc = ["m0", "m1", "m2"];
			contMc = ["cont0", "cont1", "cont2"];
			for(var i=0;i<tableMc.length;i++){
				_this.menuMc[tableMc[i]].addEventListener(MouseEvent.CLICK , onClick);
				_this.menuMc[tableMc[i]].stop();
				_this.menuMc[tableMc[i]].buttonMode = true;
				_this[contMc[i]].visible = false;
				_this[contMc[i]].alpha = 0;
			}
		//_this.menuMc[tableMc[0]].dispatchEvent(new MouseEvent("click"));
		//times();
		gotoNum(0)
		}
		public function gotoNum(num:int):void {
			//_this["m" + num].dispatchEvent(new MouseEvent("click"));
			_this.menuMc[tableMc[num]].dispatchEvent(new MouseEvent("click"));
			
		}
		private function onClick(e:MouseEvent):void{
			var thisName:String = String(e.target.name).substr(-1);
			selectNum =  int(thisName);
			movie();
			//time.stop();
			//time.start();
		}
		
		private function movie():void{
			for (var i = 0; i < tableMc.length; i++) {
				var _thisMc:MovieClip = _this.menuMc[tableMc[i]] as MovieClip;
				//_this[contMc[i]].x = 0;
				//_this[contMc[i]].y = 0;
				if(selectNum == i){
					_thisMc.addEventListener(Event.ENTER_FRAME, mouseEnter);
					TweenMax.to(_this[contMc[i]], .3, {delay:.2, autoAlpha :1,ease:Circ.easeInOut} );
				}else {
					TweenMax.to(_thisMc, .3, { frame:1 } );
					TweenMax.to(_this[contMc[i]], .3, { autoAlpha :0,ease:Circ.easeInOut} );
				}
			}
		}
		
		private function mouseEnter(e:Event):void 
		{
			var _this:MovieClip = e.target as MovieClip;
			if (_this.currentFrame == _this.totalFrames) {
				_this.stop();
				_this.removeEventListener(Event.ENTER_FRAME, mouseEnter);
			}else{
				_this.nextFrame();
			}
		}		
		
		private function times():void{
			
			 time.addEventListener("timer", Next);
			 time.start();
		}
		public function Next(event:TimerEvent=null):void {
			
			selectNum++;
			
            if(selectNum>=tableMc.length){
				selectNum = 0;
			}
			trace(selectNum)
			gotoNum(selectNum)
		}
		public function Prev(event:TimerEvent=null):void {
			
			selectNum -= 1;
			
            if(selectNum<0){
				selectNum = tableMc.length-1;
			}
			trace(selectNum)
			gotoNum(selectNum)
		}
	}
	
}