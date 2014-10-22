package com.nettop.webUtils.events {
	import flash.events.Event;

	/**
	 * @author zeroWq
	 */
	public class GlobalEvent extends Event {
		public static const INDEX_CHANGE:String = "indexChange";
		public static const POP_LAYER:String = "popLayer";

		public function GlobalEvent(type:String) {
			super(type);
		}
	}
}
