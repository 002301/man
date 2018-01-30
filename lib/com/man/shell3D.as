package com.man
{	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.utils.*;
	import flash.events.Event;
	import com.greensock.TweenMax;
	import flash.geom.Point;
	import flash.filters.BlurFilter;
	/**
	 * 此类是3d展示类
	 * 此类可以吧需要显示的影片剪辑布局为3D螺旋状
	 * 
	 * private var _NoArr:Array = new Array("no0","no1","no2","no3","no4","no5","no6")
	 * _NumberOne = new shellIDE(this);
	   _NumberOne.addPlane(_NoArr);
	 * 
	 * 
	 * @author maning
	 */
	public class shell3D extends MovieClip
	{
		private var _parent:MovieClip;
		
		private var arrData:Array;
		private var radian:Number = 0;
		//物体的角度
		private var cirx:Number = 00;
		//圆心的x坐标
		private var ciry:Number = 100;
		//圆心的y坐标
		private var radius:Number = 300;
		//圆的半径
		private var _data:Object = new Object();
		
		private var _move3D:Boolean=false;
		private var _num:int;
		private var dataNum:int=0;
		private var _numObj:Object;
		private var _gotoNum:int = 0;
		private var _stage:Object;
		//需要跳转到的位置
		
		public  function shell3D(stage:Object):void {
			_stage = stage;
			this.addEventListener(Event.ENTER_FRAME, onMouseM);
		}
		
		private function onMouseM(e:Event):void 
		{
			if (stage) {
				this.rotationY = (stage.stageWidth / 2 - mouseX)/500;
				this.rotationX = (stage.stageHeight / 2 - mouseY)/500;
			}
			
		}
		/*
		 * 
		 * @arr是一个类组成的数组，里面装有需要显示的图形类
		 * 通过类名获取加载的图形类
		 * */
		public function addPlane(arr:Array):void {
			arrData = arr;
			for (var i in arr) {
				//trace(arr.length - i)
				var arrl = arr.length - i - 1;
				var mc:Object  = getDefinitionByName(arr[arrl]);
				var plane:MovieClip = new mc();
				plane.x = -cirx*3;
				plane.y = ciry;
				plane.z = 2000;
				plane.alpha = 0;
				_data[i] = plane;
				this.addChild(plane)
			}
			movie(arr.length-1,0)
		}
		/*
		 * 跳转函数
		 * 
		 * @gotoNum 需要跳转的页数
		 * @vm  切换需要的时间
		 * 
		 * */
		public function goto(gotoNum:int,vm:int=1):void {
			if (gotoNum >= 0 && gotoNum < arrData.length) {
				_gotoNum = gotoNum;
				if (_gotoNum > _num) {
					movie(_num + 1,vm);
					//setTimeout(goto, 500, _gotoNum);
				}else if (_gotoNum < _num) {
					movie(_num-1,vm)
					//setTimeout(goto, 500, _gotoNum);
				}
			}else {
				//root["addWhell"]();
			}
			
		}
		
		public function movie(num:int,VM:int=1):void {
			if (num >= 0 && num < arrData.length) {
				_data[String(_num)].removeEventListener(Event.ENTER_FRAME, mcEnterFrame);
				_num = num;
				_data[String(_num)].addEventListener(Event.ENTER_FRAME, mcEnterFrame);
				var xx:int;
				var yy:int;
				for (var i in _data) {
					//trace("data  "+i)
					var endNum:int = int(i) - num ;
					var mc = _data[i];
					var alphaNum:Number;
					var blur:BlurFilter = new BlurFilter(5,5);  
					mc.filters = [blur];
					if (endNum == 0) {
						_numObj = _data[i];
					}
					if (endNum <= 0) {
						alphaNum = 1 + endNum * 0.3;
						xx = cirx + Math.sin(endNum*.2)* -6000;
						yy = ciry + Math.sin(endNum *.9)* 400;
					}else {
						alphaNum = 0;
					}
					TweenMax.to(mc, VM, { z: -2500 * endNum, x:xx, y:yy, autoAlpha:alphaNum,frame:1,rotationY: endNum * 10,rotationX: -endNum * 8, rotation: -endNum * 8,blurFilter:{blurX:-endNum*5,blurY:-endNum*5},onCompleteParams:[mc], onComplete:endMovieFun})
				}
			}else {
				//_stage.addWhell();
			}
			//_stage.setBG();
		}
		//
		private function endMovieFun(e):void {
			//trace("Play......"+_numObj+"   "+e)
			if (_numObj == e) { e.play(); } else e.gotoAndStop(1); 
			_stage.addWhell(); 
		} 
		private function mcEnterFrame(e:Event):void 
		{
			if (_move3D) {
				var _this:Object = e.target;
				TweenMax.to(_this, 1, { rotationY: -(mouseX) / 20, rotationX: (mouseY) / 20 } );
			}
			
		}
		
		public function get num():int 
		{
			return _num;
		}
		
		public function set num(value:int):void 
		{
			_num = value;
		}
		
		public function get move3D():Boolean 
		{
			return _move3D;
		}
		
		public function set move3D(value:Boolean):void 
		{
			_move3D = value;
		}
		
		public function get DataNum():int 
		{
			return arrData.length - _num;
		}
		
		public function set DataNum(value:int):void 
		{
			dataNum = value;
		}
	}

}