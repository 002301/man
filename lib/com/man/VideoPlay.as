package com.man {
    import flash.display.Sprite;
    import flash.events.NetStatusEvent;
    import flash.events.SecurityErrorEvent;
    import flash.media.Video;
    import flash.net.NetConnection;
    import flash.net.NetStream;
    import flash.events.Event;
    import flash.display.MovieClip;
	/*
	 * 简单的flv播放类，只有播放功能
	 * 
	 * 
	 * 
	 * 
	 * 
	 * 
	 * */
    public class VideoPlay extends Sprite {
        private var videoURL:String = "video.flv";
        private var connection:NetConnection;
        private var stream:NetStream;
		private var videoMC:MovieClip;
		public static var VIDEO_COMPLETE:String = "video_complete";

        public function VideoPlay(video_mc:MovieClip,url:String) {
			videoMC = video_mc;
			videoURL = url;
            connection = new NetConnection();
            connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
            connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
            connection.connect(null);
        }

        private function netStatusHandler(event:NetStatusEvent):void {
            switch (event.info.code) {
                case "NetConnection.Connect.Success":
                    connectStream();
                    break;
                case "NetStream.Play.StreamNotFound":
                    trace("Stream not found: " + videoURL);
                    break;
				case "NetStream.Play.Stop":
					removeVideoAll();
					this.dispatchEvent(new Event(VideoPlay.VIDEO_COMPLETE));
					
					break;
            }
        }

        private function securityErrorHandler(event:SecurityErrorEvent):void {
            trace("securityErrorHandler: " + event);
        }

        private function connectStream():void {
         	stream = new NetStream(connection);
            stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
            stream.client = new Object();
            var video:Video = new Video(1000,620);
            video.attachNetStream(stream);
            stream.play(videoURL);
            videoMC.addChild(video);
        }
		public function removeVideoAll(){
			//trace(stream);
			if(connection != null){
				connection.removeEventListener(NetStatusEvent.NET_STATUS,netStatusHandler);
				connection.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			}
			//trace(stream);
			if(stream != null){
				//trace(stream);
				stream.pause();
				stream.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
				
				stream.close();
				
			}
		}
    }
}

