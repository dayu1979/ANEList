package
{
	import flash.text.TextField;

	public class Temp extends TestAne_IOS
	{
		static public var txt:TextField;
		public function Temp()
		{
			txt=new TextField();
			txt.width=400;
			txt.height=400;
			txt.text="huan欢迎测试";
			this.addChild(txt);
			super();
		}
		static public function log(...args){
			txt.appendText(args.toString()+"\r");	
		}
	}
}