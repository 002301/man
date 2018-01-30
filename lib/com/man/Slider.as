package com.man
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author maning
	 * 滑动杆模块，声明之后控制滑动条输出数值。通过绑定影片剪辑，获取第一层和第二层的内容自动添加侦听事件
	 */
	public class Slider extends Sprite
	{
		private var _mc:Object;
		private var _mcBg:Object;//滑动背景
		private var _mcBtn:Object;//滑动按钮
		private var _value:Number=0;//初始值
		private var moveRec:Rectangle;
		private var _type:Boolean; // 滑动类型，“true”为横向滑动，“false”为竖向滑动
		
		// @mc  需要侦听的影片剪辑，里面至少有两层，一层为按钮，一层为背景
		// @type 滑杆的类型 true为横向，false为竖向
		public function Slider(mc:MovieClip=null, type:Boolean = true):void
		{
			if (mc) {
				_mc = mc;
			}else {
				_mc = this;
			}
			
			_type = type;
			init()
		}
		
		private function init():void
		{
			var childNum = _mc.numChildren;
			if (childNum > 1)
			{
				_mcBtn = _mc.getChildAt(1);
				_mcBg = _mc.getChildAt(0);
				_mcBtn.addEventListener(MouseEvent.MOUSE_DOWN, onMcDown);
				_mcBtn.stage.addEventListener(MouseEvent.MOUSE_UP, onMcOut)
				if (_type)
				{
					moveRec = new Rectangle(_mcBtn.x, _mcBtn.y, (_mcBg.width - _mcBtn.width), 0)
				}
				else
				{
					moveRec = new Rectangle(_mcBtn.y, _mcBtn.y, 0, (_mcBg.height - _mcBtn.height))
				}
				
			}
		}
		
		private function onMcOut(e:MouseEvent):void
		{
			_mcBtn.stage.removeEventListener(MouseEvent.MOUSE_MOVE, setValue);
			_mcBtn.stopDrag();
			setValue();
		}
		private function setValue(e:MouseEvent=null):void {
			if (_type)
			{
				_value = Math.round((_mcBtn.x / (_mcBg.width - _mcBtn.width)) * 100)
			}
			else
			{
				_value = Math.round((_mcBtn.y / (_mcBg.height - _mcBtn.height)) * 100)
			}
			this.dispatchEvent(new Event("change"))
		}
		private function onMcDown(e:MouseEvent):void
		{
			_mcBtn.startDrag(false, moveRec);
			_mcBtn.stage.addEventListener(MouseEvent.MOUSE_MOVE, setValue);
		}
		
		public function unInit():void
		{
			_mcBtn.removeEventListener(MouseEvent.MOUSE_DOWN, onMcDown);
			_mcBtn.stage.removeEventListener(MouseEvent.MOUSE_UP, onMcOut);
			_mcBtn.stage.removeEventListener(MouseEvent.MOUSE_MOVE, setValue);
		}
		// 获取值 0～100；
		public function get value():Number
		{
			return _value;
		}
		// 获取值 0～100；
		public function get num():Number {
			return _value;
		}
		//设置值
		public function set value(value:Number):void
		{
			_value = value;
			if (_type)
			{
				_mcBtn.x = (_mcBg.width - _mcBtn.width) * _value;
			}
			else
			{
				_mcBtn.y = (_mcBg.width - _mcBtn.width) * _value;
			}
		
		}
	
	}

}