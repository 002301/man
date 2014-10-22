package com.man.PicControl
{
	import flash.display.MovieClip;
	import com.greensock.TweenMax;
	import flash.events.Event;
	
	/**
	 * 时间轴效果图片切换
	 * @author maning
	 */
	public class TimeLine3D extends PicControl
	{
		private var _content:MovieClip;
		public var lRMove:Function = mlr;
		
		public function TimeLine3D(Cont:MovieClip, l:Object, r:Object, f:Function):void
		{
			super();
			_content = Cont;
			lRMove = f;
			super.init(Cont, l, r);
		
		}
		
		override public function movie(num:int):void
		{
			var j = 5;
			//trace("num  " + num + "    i   " + _content.numChildren)
			for (var i = 0; i < _content.numChildren; i++)
			{
				var _thisMC = _Cont.getChildAt(_content.numChildren - i - 1);
				
				if (i < num)
				{
					TweenMax.to(_thisMC, 0.3, {y: 50, z: -100, autoAlpha: 0});
				}
				else if (num == i)
				{
					_currentNum = num;
					TweenMax.to(_thisMC, 0.3, {y: 0, z: 0, autoAlpha: 1, colorMatrixFilter: {colorize: 0xffffff, amount: 0}, onComplete: addLR});
				}
				else if (i > num)
				{
					if (j > 0)
					{
						var movieXX = 60 * (i - num);
						TweenMax.to(_thisMC, 0.3, {y: -movieXX, z: movieXX * 5, colorMatrixFilter: {colorize: 0xffffff, amount: 1}, autoAlpha: j * .2, onComplete: addLR});
						j--;
					}
					else
					{
						TweenMax.to(_thisMC, 0.3, {autoAlpha: 0, onComplete: addLR});
					}
					
				}
				
			}
			lRMove(num, _content.numChildren);
		}
		
		function mlr(num, totle):void
		{
		
		}
	}

}