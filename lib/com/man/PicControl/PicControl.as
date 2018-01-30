package com.man.PicControl
{
	import com.man.picControl.PicControl;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.greensock.TweenMax;
	
	/**
	 * 图片切换效果抽象类
	 *
	 * @author maning
	 */
	public class PicControl extends Sprite
	{
		protected var _Cont:MovieClip; //切换内容
		protected var _total:Number; //总数
		protected var _currentNum:Number; //当前索引
		protected var _currentMC:MovieClip; //当前影片剪辑
		protected var _leftMc:Object; //左侧按钮
		protected var _rightMc:Object; //右侧按钮
		protected var _auto:Boolean; //是否连续切换
		protected var movieXY:Number; //移动距离
		
		public function PicControl():void
		{
		
		}
		
		/*
		 * init
		 * @cont  需要切换的图片剪辑
		 * @l     左侧按钮
		 * @r     右侧按钮
		 * @auto  到底后是否连续切换，
		 * */
		public function init(Cont:MovieClip, l:Object, r:Object):void
		{
			_Cont = Cont;
			_total = Cont.numChildren;
			_currentNum = 0;
			_leftMc = l;
			_rightMc = r;
			if (_leftMc)
			{
				_leftMc.visible = false;
			}
			//addLR();
			//trace("pic init ")
			gotoNum(0, true);
		}
		
		public function addLR():void
		{
			//trace("addLR")
			_leftMc.addEventListener(MouseEvent.CLICK, onMClick);
			_leftMc.buttonMode = true;
			_rightMc.addEventListener(MouseEvent.CLICK, onMClick);
			_rightMc.buttonMode = true;
		}
		
		public function removeLR():void
		{
			//trace("removeLR")
			_leftMc.removeEventListener(MouseEvent.CLICK, onMClick);
			_leftMc.buttonMode = false;
			_rightMc.removeEventListener(MouseEvent.CLICK, onMClick);
			_rightMc.buttonMode = false;
		}
		
		//左右移动响应
		protected function onMClick(e:MouseEvent):void
		{
			removeLR();
			var mc = e.target;
			var gotoN:int = 0;
			if (mc == _leftMc)
			{
				gotoN = _currentNum - 1;
				gotoNum(gotoN, false);
			}
			else
			{
				gotoN = _currentNum + 1;
				gotoNum(gotoN, true);
			}
		
		}
		
		public function get Cont():MovieClip
		{
			return _Cont;
		}
		
		public function set Cont(value:MovieClip):void
		{
			_Cont = value;
		}
		
		public function get total():Number
		{
			return _total;
		}
		
		public function get currentNum():Number
		{
			return _currentNum;
		}
		
		public function get currentMC():MovieClip
		{
			return _currentMC;
		}
		
		public function get leftMc():Object
		{
			return _leftMc;
		}
		
		public function set leftMc(value:Object):void
		{
			_leftMc = value;
		}
		
		public function get rightMc():Object
		{
			return _rightMc;
		}
		
		public function set rightMc(value:Object):void
		{
			_rightMc = value;
		}
		
		public function get auto():Boolean
		{
			return _auto;
		}
		
		public function set auto(value:Boolean):void
		{
			_auto = value;
		}
		
		//左右移动函数
		public function gotoNum(num:int, b:Boolean = true):void
		{
			//trace(num + "     " + b + "  " + _total)
			if (b)
			{
				if (num < _total)
				{
					movie(num);
				}
				
			}
			else
			{
				if (num >= 0)
				{
					movie(num);
				}
			}
			
			AutoHide();
		}
		
		//切换效果的函数
		public function movie(num:Number):void
		{
		
		}
		
		//判断应该隐藏那个按钮
		protected function AutoHide():void
		{
			//trace(_currentNum+"     "+_rightMc+"   _total  "+_total)
			if (_total < 2)
			{
				TweenMax.to(_leftMc, 0.3, {autoAlpha: 0});
				TweenMax.to(_rightMc, 0.3, {autoAlpha: 0});
			}
			else if (_currentNum == 0)
			{
				TweenMax.to(_leftMc, 0.3, {autoAlpha: 0});
				TweenMax.to(_rightMc, 0.3, {autoAlpha: 1});
			}
			else if (_currentNum > 0 && _currentNum < _total - 1)
			{
				TweenMax.to(_leftMc, 0.3, {autoAlpha: 1});
				TweenMax.to(_rightMc, 0.3, {autoAlpha: 1});
			}
			else if (_currentNum == _total - 1)
			{
				TweenMax.to(_rightMc, 0.3, {autoAlpha: 0});
				TweenMax.to(_leftMc, 0.3, {autoAlpha: 1});
			}
			addLR();
		}
	}

}