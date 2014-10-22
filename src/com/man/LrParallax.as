package com.man
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import com.greensock.TweenMax;
	/**
	 * ...
	 * @author maning
	 *
	 * 一个设置影片剪辑内组件左右视差的类
	 * 
	 *
		var lp = new LrParallax(stage,10);
		lp.addMc(mc);
		lp.addMc(mc2);
	 * 
	 * 
	 */
	public class LrParallax
	{
		private var _parent:Object;
		private var _mcArr:Array;
		private var _mcArrX:Array;
		private var _movieNum:int;
		private var _timer:Timer;
		//  @pr  :视差参照影片；
		//  @num: 视差移动比值 （可以为负数 传值范围 -100~100）
		public function LrParallax(pr:Object,num:int = 50):void
		{
			_parent = pr;
			_movieNum = num;
			_mcArr = new Array();
			_mcArrX = new Array();
			_timer = new Timer(60);
			_timer.addEventListener(TimerEvent.TIMER, onTimer);
			_parent.addEventListener(Event.REMOVED_FROM_STAGE, removeTimer);
		}
		private function removeTimer(e:Event):void {
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER, onTimer);
		}
		private function onTimer(e:TimerEvent):void 
		{
			var mou = _parent.mouseX;
			var mov = ((_parent.width / 2)-mou)/_movieNum;
			//trace("mov "+mov)
			for (var i = 0; i < _mcArr.length;i++ ) {
				var mc = _mcArr[i];
				var mcx = _mcArrX[i]+mov;
				TweenMax.to(mc,.5,{x:mcx});
			}
		}
		
		public function addMc(mc:MovieClip):void
		{
			
			_mcArr.push(mc);
			_mcArrX.push(mc.x);
			_timer.start();
		}
	
	}

}