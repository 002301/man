package com.man
{
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	
	/**
	 * 让影片剪辑在一个区域内随机运动
	 * 
	 var ar = new Parallax(this);
	 ar.vy = 2;
	 ar.vx = 4;
	 
	 * @author maning
	 */
	public class RandomMc 
	{
		var _boundary:Rectangle;
		var cont:MovieClip;
		var _vx:Number = 0.5
		var _vy:Number=0.2;
		public function RandomMc(c:MovieClip):void {
			cont = c;
			_boundary = new Rectangle( cont.x-25, cont.y-25, 100, 20);
		}
		
		public function get boundary():Rectangle 
		{
			return _boundary;
		}
		//设置边界.................................
		public function set boundary(value:Rectangle):void 
		{
			_boundary = value;
		}
		
		public function get vy():Number 
		{
			return _vy;
		}
		
		public function set vy(value:Number):void 
		{
			_vy = value;
		}
		
		public function get vx():Number 
		{
			return _vx;
		}
		
		public function set vx(value:Number):void 
		{
			_vx = value;
		}
		public function upDate():void {
		　if (cont.x<=_boundary.left||cont.x>=_boundary.right) {//碰壁
		  　vx=- vx;//转向
		　}
		　if (cont.y<=_boundary.top||cont.y>=_boundary.bottom) {
		　　vy=- vy;
		　}
			cont.y+=vy;//移到
			cont.x += vx;
			trace(cont.x+"  "+cont.y)
		}
	}
	
}