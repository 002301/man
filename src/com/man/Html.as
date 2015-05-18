package man 
{
	/**
	 * ...
	 * @author maning
	 */
	public class Html 
	{
		
		public function Html() 
		{
			
		}
		public function alert(s:String):void 
		{
			ExternalInterface.call("window.alert",s)
		}
		public function console(s:String):void 
		{
			ExternalInterface.call("console.log",s)
		}
		
	}

}