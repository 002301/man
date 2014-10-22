package com.man
{
	import com.greensock.TweenMax;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.greensock.easing.*;
	/**
	 * ...
	 * @author maning
	 * 基本按钮类，默认添加鼠标移入高亮，移出恢复效果。
	 * 
		import com.man.BasicBtn;
		var btn = new BasicBtn(this)
	 
	 */
	public class BasicBtn extends MovieClip
	{
		private var _btn:MovieClip;
		public function BasicBtn(btn:MovieClip = null):void {
			if (btn == null) {
				_btn = this;
			}else {
				_btn = btn;
			}
			init()
		}
		
		private function init():void {
			_btn.addEventListener(MouseEvent.ROLL_OVER,over);
			_btn.addEventListener(MouseEvent.ROLL_OUT,out);
			_btn.buttonMode = true;
		}
		private function unInit():void {
			_btn.removeEventListener(MouseEvent.ROLL_OVER,over);
			_btn.removeEventListener(MouseEvent.ROLL_OUT,out);
			_btn.buttonMode = false;
		}
		private function over(e:MouseEvent)
		{
			TweenMax.to(e.currentTarget,1, {colorMatrixFilter:{brightness:1.4},ease:Strong.easeOut});
		}
		private function out(e:MouseEvent)
		{
			TweenMax.to(e.currentTarget,1, {colorMatrixFilter:{brightness:1},ease:Strong.easeOut});
		}
		
		public function set disable(e:Boolean):void {
			if (e) {
				init()
			}else {
				unInit()
			}
		}
	}

}