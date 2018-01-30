package  com.man
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.ContextMenuEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuBuiltInItems;
	import flash.ui.ContextMenuItem;

	/**
	 * ...自定义右键菜单
	 * 
	 * 
	 import com.man.RightClick;
	 var rc = new RightClick(this);
	 rc.addMenu("东边游山","www.airmn.com")
	 
	 * @author Maning
	 */
	public class RightClick 
	{
		private var _stage:Object;
		private var rcMc:Sprite;
		private var myContextMenu:ContextMenu;
		public function RightClick(s:Object) 
		{
			myContextMenu = new ContextMenu();
			removeDefaultItems();
			_stage = s;
			

		}
		/* 添加右键链接
		 * menuLabel:标签名称
		 * url:需要跳转到地址
		 * 
		 * */
		public function addMenu(menuLabel:String,url:String):void {
            var item:ContextMenuItem = new ContextMenuItem(menuLabel);
            myContextMenu.customItems.push(item);
			_stage.contextMenu = myContextMenu;
            item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
			function menuItemSelectHandler(event:ContextMenuEvent):void {
               //trace("menuSelectHandler: " + event);
			   navigateToURL(new URLRequest(url), "_blank");
            }

        }
		//删除默认菜单
		private function removeDefaultItems():void {
            myContextMenu.hideBuiltInItems();
            //var defaultItems:ContextMenuBuiltInItems = myContextMenu.builtInItems;
            //defaultItems.print = true;
        }

		
	}

}