package
{
	import com.lzm.anesdk.AneSDK;
	import com.lzm.anesdk.weibo.WeiBo;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.setTimeout;

	public class TestWeiBo
	{
		private var weibo:WeiBo;
		public function TestWeiBo()
		{
			setTimeout(function():void{
				weibo = new WeiBo();
				AneSDK.addCodelistener(WeiBo.EVENT_SINAWEIBODIDLOGIN,onLogin);
				
				weibo.initWeiBo("2268202422","9b3be26bfb203413e8803c78dcb1088b");
				weibo.login();
			},3000);
		}
		var userID:String;
		var accessToken:String;

		private var load:URLLoader;
		private function onLogin(data:String):void{
			Temp.log(data);
			//{"userID":"1897992937","accessToken":"2.00_fm8EC0_pI6Vd34193af970ZsEbo"}
			var obj=JSON.parse(data);
			this.userID=obj.userID;
			this.accessToken=obj.accessToken;
			getfriends();
		}
		public function getfriends():void{
			load=new URLLoader();
			load.addEventListener(Event.COMPLETE,oncom);
			load.addEventListener(IOErrorEvent.IO_ERROR,onerror);
			//
			var url:URLRequest=new URLRequest("https://api.weibo.com/2/friendships/friends.json?access_token="+this.accessToken);
			load.load(url);
			//
			
		}
		
		protected function onerror(event:IOErrorEvent):void
		{
			Temp.log(event);
		}
		var friends:Array;
		protected function oncom(event:Event):void
		{
			this.friends=JSON.parse(load.data).users;
			//
			for(var i=0;i<friends.length;i++){
				Temp.log(friends[i].user.id,friends[i].user.name);
			}
			var file:File = File.applicationDirectory;
			var imagePath:String = file.resolvePath("testshare.png").nativePath;
			Temp.log(imagePath);
			weibo.share("测试分享",imagePath);
		}
	}
}

