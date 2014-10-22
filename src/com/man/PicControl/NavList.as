package com.man.PicControl 
{
	import com.greensock.easing.Strong;
	import com.greensock.TweenMax;
	import flash.display.MovieClip;
	import flash.events.Event;
	/**
	 * 菜单列表式图片切换
	 * 
	 * 2013-08-20
	 * @author maning
	 * 
	 */
	public class NavList extends PicControl
	{
		private var _startX:Number = 0;//起始x轴位置
		private var _listWidth:Number; // 列表需要显示的子图片数;
		/**
		 * NavList
		 * 
		 * 
		 * @cont  需要切换的图片剪辑
		 * @l     左侧按钮
		 * @r     右侧按钮
		 * @widthNum 移动距离
		 * @lw    列表需要显示的图片数量
		 * @sx    图片开始x轴距离
		 * 
		 * 
		 * **/
		public function NavList(Cont:MovieClip, l:Object, r:Object, widthNum:Number = 0,lw:Number=0, sx:Number = 0):void
		{
			//trace("lr_Init")
			movieXY = widthNum;
			_startX = sx;
			_listWidth = lw;
			super.init(Cont, l, r);
			_total = Math.floor(_total / _listWidth);
			AutoHide();
			//trace("_total:"+_total)
		}
		override public function movie(num:Number):void
		{
			_currentNum = num;
			TweenMax.to(_Cont, 0.5, {x: -_startX + movieXY * num, ease: Strong.easeOut});
			//trace(num +" xx  "+_startX + movieXY * num)
		}
		
		
	}

}