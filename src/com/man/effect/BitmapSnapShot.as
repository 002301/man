package man.effect {
	
	import flash.display.*;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.events.*;
	import flash.filters.*;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.filters.BitmapFilter;
    import flash.filters.BitmapFilterQuality;
    import flash.filters.BlurFilter;
	import flash.filters.DropShadowFilter;
	import man.effect.BitmapGrabber;
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	
	public class BitmapSnapShot extends MovieClip{
		
		/*
		**@Author             Gerry Creighton - www.thespikeranch.com - 9-2008 -  gerry@thespikeranch.com
		**@Param    total     This is the total number of snap shots to display. This gets calculated by cols X rows 
		**                    which are calculated by the snapSize.
		**@Param    count     This is a copy of the uint total but is used to count down for the animations. This must be
		**                    set after the total is set so do not move.
		**@Param    startx    This is the x position to place everything on the stage.
		**@Param    starty    This is the y position to place everything on the stage.
		**@Param    snapSize  This is the size of the cube that animates. Right now the size has to be a number that 400 can easily be dived by. 
		**                    I used the Tweener animation classes for the animations, you can reference the documentation for those classes
		**                    at the following location: http://tweener.google.com
		3D碎片效果
		
		var bs = new BitmapSnapShot(this);
		bs.effect(this.getChildAt(0));
		
		
		*/
		private var Box:MovieClip;
		
		private var snapSize:Number = 40;
		//
		private var pictures:Array = new Array();
		private var total:uint;
		private var count:uint = total;
		private var cols:Number;
		private var rows:Number;
		private var bw:Number;
		private var bh:Number;
		private var startx:Number = 0;
		private var starty:Number = 0;

		private var _parent:MovieClip;
		private var _min:Number;
		private var _max:Number;
		
		
		
		public function BitmapSnapShot(mc:MovieClip){
			_parent = mc
			
			
		}
		
		public function effect(mc:MovieClip,min:Number=1,max:Number=4):void{
			Box = mc;
			_min = min;
			_max = max;
			setDimensions(mc)
			buildSnaps(mc);
		}
		private function setDimensions(img:MovieClip):void{
			bw = img.width;
			bh = img.height;
			cols = Math.ceil(bw/snapSize);
			rows = Math.ceil(bh/snapSize);
			total = cols * rows;
			count = total;
			//trace(total+"  "+cols+"  "+rows);
		}
		public function buildSnaps(mySource:MovieClip):void{
			//loop to make snapshots of image and position them
			var xx = 0;
			var yy = 0;
			for(var i:uint = 1; i<total+1; i++){
				//take snapshots of different parts of the mySource image
				var bmpData:BitmapData = man.effect.BitmapGrabber.grab(mySource,new Rectangle(xx,yy,snapSize,snapSize), true );
				//add BitmapData to an mc
				var holder:MovieClip = new MovieClip();
				_parent.addChild(holder);
				var newClip:Bitmap = new Bitmap(bmpData);
				holder.addChild(newClip);
				holder.x = startx+xx;
				holder.y = starty+yy;
				pictures.push(holder);
				//trace(i % cols == 0)
				if (i % cols == 0) {
					yy+=snapSize
					xx=0;
				}else {
					xx+=snapSize
				}
		    }
			//remove original image to save memory
			_parent.removeChild(mySource);
			//animate snaps 
			Animate();
		}
		

		private function ranDom(min:Number, max:Number):Number {
			//generates a random number between min and max
			var randomNum:Number = Math.floor(Math.random() * (max - min )) + min;
			return randomNum;
		}
		//
		public function Animate():void {
			//trace("pictures length: "+pictures.length);
			if (count >= 0) {
				for(var i:uint = 0; i< pictures.length; i++){
					var clip = pictures[i];
					var rotx:Number = ranDom(-90, 90);
					var roty:Number = ranDom(-90, 90);
					var rotz:Number = ranDom(-90, 90);
					//tween out eith a delay between clips
					var cx:Number = ranDom(-400,_parent.stage.stageWidth+200);
					var cy:Number = ranDom( -200, _parent.stage.stageHeight + 400);
					var cz:Number =  ranDom( -300, -600);
					var tt:Number = ranDom(1, 5);
					TweenMax.from(clip,tt,{x:cx,y:cy,rotationX:rotx,rotationY:roty,rotationZ:rotz,z:cz,ease:Cubic.easeOut})
				}
				
			}
			
		}

	}
	//

}
//
