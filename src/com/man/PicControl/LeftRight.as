
package com.man.PicControl
{
	import com.greensock.easing.Strong;
	import com.greensock.TweenMax;
	import com.man.picControl.LeftRight;
	import com.man.picControl.PicControl;
	import flash.display.MovieClip;
	import flash.events.Event;

	/**
	 * ...
	 * @author maning
	 * 初始化后图片集中在右侧，点击左右后只有当前的图片移动，其他不动。
	 *
	   import com.man.PicControl.LeftRight;
	   var lrCtor = new LeftRight(lists,l,r,863);
	 *
	 */
	public class LeftRight extends PicControl
	{
		private var _startX:Number = 0;//起始x轴位置
		private var _endF:Function = null;
		/**
		 * LeftRight 参数说明
		 * @cont  需要切换的图片剪辑
		 * @l     左侧按钮
		 * @r     右侧按钮
		 * @widthNum 移动距离
		 * @sx    图片开始x轴距离
		 * 
		 * **/
		public function LeftRight(Cont:MovieClip, l:Object, r:Object, widthNum:Number = 0, sx:Number = 0):void
		{
			//trace("lr_Init")
			super();
			movieXY = widthNum;
			_startX = sx;
			super.init(Cont, l, r);
			
		}
		
		override public function movie(num:Number):void {
		   for (var i=0; i< _total; i++)
		   {
			   var _thisMC = _Cont.getChildAt(i);
			    _currentNum = num;
			   if (num < i)
			   {
			   TweenMax.to(_thisMC,0.3,{x:movieXY});
			   }
			   else if (num==i)
			   {
				   
				TweenMax.to(_thisMC,0.3,{x:0});
			   }
			   else if (num>i)
			   {
			   TweenMax.to(_thisMC,0.3,{x:-movieXY});
			   }
		   }
		   dispatchEvent(new Event("change"));
		   AutoHide();
		   onENDFunction()
		 }
		 
		public function  onENDFunction():void {
			 if (endF != null) {
				 endF();
			 }
		}
		
		public function get startX():Number
		{
			return _startX;
		}

		public function set startX(value:Number):void
		{
			_startX = value;
		}
		
		
		public function get endF():Function 
		{
			return _endF;
		}
		
		public function set endF(value:Function):void 
		{
			_endF = value;
		}
	}

}