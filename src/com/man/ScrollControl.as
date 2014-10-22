package com.man
{
	import com.greensock.easing.Cubic;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import com.greensock.TweenMax;
	/**
	 * 控制时间轴滚动类
	 * @author maning
	 */
	public class  ScrollControl extends Sprite
	{
		public var _MC:MovieClip;
		private var goNum:Number =50;
		private var gotoSecond:Number = 0.7;//间隔多少秒;
		private var _stage:Stage;
		private var _scroll:Function;
		public function ScrollControl() {
		}
		public function add(mc:MovieClip):void {
			//trace("ScrollControl")
			_MC = mc;
			_stage = mc.stage;
			_MC.stop();
			addListener();
		}
		public function addListener():void {
			//trace("addListener")
			//if (_stage != null) {
				_stage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			//}
		}
		public function removeListener():void {
			_stage.removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		}
		public function onMouseWheel(e:MouseEvent):void 
		{
			//trace(e.delta)
			if (e.delta > 0) {
				//_MC.prevFrame();
				TweenMax.to(_MC, gotoSecond, {frame:_MC.currentFrame-goNum,ease:Cubic.easeOut} );
			}else {
				TweenMax.to(_MC, gotoSecond, {frame:_MC.currentFrame+goNum,ease:Cubic.easeOut} );
				//_MC.nextFrame();
			}
			if (_scroll!=null) {
				_scroll();
			}
		}
		
		public function get scroll():Function 
		{
			return _scroll;
		}
		
		public function set scroll(value:Function):void 
		{
			_scroll = value;
		}
	}
	
}