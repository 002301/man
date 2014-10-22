package com.man
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.greensock.TweenMax;
	import com.greensock.plugins.*;

	/**
	 * 菜单切换效果,需要和fla配合。
	 * @author maning
	 */
	public class MenuNav extends MovieClip
	{
		private var tableMc:Array;
		private var contMc:Array;
		private var linkURL:Array;
		private var selectNum:int;
		private var _selectMc:MovieClip;
		private var _this:Object;
		private var setStyleFun:Function;
		private var _onClick:Function;
		public function MenuNav():void {
			
		}
		//p:父级影片剪辑  setFun：设置选中状态处理函数，click：设置点击后处理函数
		public function init(p:Object,setFun:Function=null,click:Function=null,index:String="m"):void {
			_this = p;
			if (setFun != null) {
				setStyleFun = setFun;
			}else {
				setStyleFun = setStyle;
			}
			_onClick = click;
			//trace(_this.numChildren)
			for (var i = 0; i < _this.numChildren; i++) {
				trace("m"+ i)
				var _thisMc:Object = _this.getChildAt(i) ;
				_thisMc.stop();
				_thisMc.addEventListener(MouseEvent.CLICK , onMcClick);
				_thisMc.addEventListener(MouseEvent.ROLL_OVER , onOver);
				_thisMc.addEventListener(MouseEvent.ROLL_OUT , onOut);
				_thisMc.buttonMode = true;
			}
			//gotoNum(0)
		}
		
		public function gotoNum(num:int):void {
			var mc = _this.getChildAt(num); 
			mc.dispatchEvent(new MouseEvent("click"));
		}
		
		private function onOut(e:MouseEvent):void 
		{
			var roll:MovieClip = e.target as MovieClip;
			if (roll != _selectMc) {
				setStyleFun(roll, false);
			}
			
		}
		
		private function onOver(e:MouseEvent):void 
		{
			
			var roll:MovieClip = e.target as MovieClip;
			if(roll)
			setStyleFun(roll, true);
		}
		
		private function onMcClick(e:MouseEvent):void {
			var roll:MovieClip = e.target as MovieClip;
			if (_onClick != null) {
				_onClick(e);
			}
			_selectMc = roll;
			movie();
			
		}
		
		private function movie():void{
			for (var i = 0; i < _this.numChildren; i++) {
				var _thisMc:MovieClip = _this.getChildAt(i) ;
				if (_selectMc == _thisMc) {
					setStyleFun(_thisMc, true);
					_thisMc.removeEventListener(MouseEvent.CLICK , onMcClick);
					_thisMc.buttonMode = false;
				}else {
					setStyleFun(_thisMc, false);
					_thisMc.addEventListener(MouseEvent.CLICK , onMcClick);
					_thisMc.buttonMode = true;
				}
			}
		}
		
		private function setStyle(mc:MovieClip,b:Boolean):void {
			if (b) {
				TweenMax.to(mc.show, 0.5 , { autoAlpha:1 } );
				TweenMax.to(mc.but, 0.5 ,{ autoAlpha:0.1 });
			}else{
				TweenMax.to(mc.show, 0.5 , { autoAlpha:0 } );
				TweenMax.to(mc.but, 0.5 ,{ autoAlpha:1 });	
			}
		}
		
		public function get selectMc():MovieClip 
		{
			return _selectMc;
		}
		
		public function set onClick(value:Function):void 
		{
			_onClick = value;
		}
	}
	
}