package com.man
{
	import com.man.picList.PicBasic;
	import com.nettop.webUtils.Global;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import com.man.picList.PicItem;
	import com.greensock.TweenMax;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	
	/**
	 * PicBasic 1.0
	 * 
	 * @author maning
	 */
	public class PicBasic extends Sprite 
	{
		private var method:String;
		private var thisXml:XML;
		//private var _this:Sprite;
		private var picWidth:int;
		private var picMC:MovieClip;
		private var selectMC:PicItem;
		private var LoadPic:Sprite;
		private var loadFun:Loader;
		private var _parent:MovieClip;
		private var _mouseX:int;
		
		public function PicBasic(xml:XML,Parents:MovieClip,num:int = 340):void
		{
			if (xml != null) {
				thisXml = xml;
				picWidth = num;
				_parent = Parents;
				init();
			}
		}
		
		private function init():void 
		{
			picMC = new MovieClip();
			for(var i=0;i<thisXml.item.length();i++){
				var item:PicItem = new PicItem(thisXml.item[i]);
				picMC.addChild(item);
				picMC.buttonMode = true;
				item.addEventListener(MouseEvent.CLICK, onPicClick);
				item.name =i;
				item.x = i * picWidth+30;
			}
			addChild(picMC);
			picMC.x = 0;
			picMC.y = _parent.height-85;
			LoadPic = new Sprite();
			_parent.cont.addChildAt(LoadPic, 0);
			loadFun= new Loader();
			selectMC = PicItem(picMC.getChildAt(0));
			selectMC.dispatchEvent(new MouseEvent("click"));
			loadPicFun(selectMC.data.details);
			selectClick();
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			_parent.addEventListener(MouseEvent.ROLL_OVER, autoMouseOver);
			_parent.addEventListener(MouseEvent.ROLL_OUT, autoMouseOut);
			
			//_parent["loading"].visible = false;
		}
		
		private function autoMouseOut(e:MouseEvent):void 
		{
			TweenMax.to(picMC, 1, {autoAlpha:0});
		}
		
		private function autoMouseOver(e:MouseEvent):void 
		{
			TweenMax.to(picMC,1, {autoAlpha:1} );
		}
		
		private function onMouseOut(e:MouseEvent):void 
		{
			removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			//removeEventListener(Event.ENTER_FRAME, onMouseEnter);
		}
		
		private function onMouseOver(e:MouseEvent):void 
		{
			
			addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		private function onMouseMove(e:MouseEvent):void 
		{
			addEventListener(Event.ENTER_FRAME, onMouseEnter);
			_mouseX = mouseX ;
		}
		
		private function onMouseEnter(e:Event):void 
		{
			
			var MainMc:MovieClip = this.getChildAt(0) as MovieClip;
			var _Width:Number = MainMc.width - 970;
			trace(_Width)
			if (_Width > 0) {
				var moviePix:Number =  Number(_mouseX / 970);
				trace(moviePix)
				moviePix = -(_Width * Number(moviePix.toFixed(2)));
				var i:Number = (moviePix - MainMc.x) / 7
				i = Number(i.toFixed());
				var goto = MainMc.x + i;
				//if (goto < 10 && goto > -MainMc.width -500) {
				//	MainMc.x = goto;
				//}
				MainMc.x = goto;
				if (i == 0) {
					removeEventListener(Event.ENTER_FRAME, onMouseEnter);
				}
			}
		}
		
		private function onPicClick(e:MouseEvent):void 
		{
			var selectPic:PicItem = e.currentTarget as PicItem;
			
			if (selectPic != selectMC) {
				var loadURL:XML = selectPic.data;
				selectMC = selectPic;
				loadPicFun(loadURL.details);
				selectClick();
				_parent["loading"].visible = true;
				//root["nt"]("picNum"+selectPic.name);
				//var _ga = Global.getData("gaPic");
				//_ga();
			}
			
		}
		
		
		private function selectClick():void {
			var MainMc:MovieClip = this.getChildAt(0) as MovieClip;
			for (var i = 0 ; i < MainMc.numChildren; i++) {
				var thisMc:PicItem = MainMc.getChildAt(i) as PicItem;
				if (selectMC != thisMc) {
					TweenMax.to(thisMc, 0.5, {colorTransform:{tint:0x000000, tintAmount:0.5}} );
				}else {
					TweenMax.to(thisMc, 0.5, {colorTransform:{tint:0x000000, tintAmount:0}} );
				}
			}
		}
		
		private function loadPicFun(url:String):void
		{
			if (url != "") {
				loadFun.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderHaldren);
				try {
					loadFun.load(new URLRequest(url));
				}catch (myError:Error) { 
				 trace("error caught: " + myError);
				 trace("pic loading err::" + url);
				} 
				
			}

		}

		private function loaderHaldren(e:Event):void
		{
			TweenMax.to(LoadPic, 0, {colorTransform:{tint:0x000000, tintAmount:1}} );
			var setMc:Bitmap = e.target.content;
			setMc.width = 1000;
			setMc.scaleY = setMc.scaleX;
			setMc.smoothing = true;
			if (LoadPic.numChildren<1) {
				LoadPic.addChild(setMc);
			}else {
				LoadPic.removeChildAt(0);
				LoadPic.addChildAt(setMc, 0);
			}
			TweenMax.to(LoadPic, 1, {colorTransform:{tint:0x000000, tintAmount:0}} );
			_parent["loading"].visible = false;
			stage.dispatchEvent(new Event("resize"));
		}
	}
	
}