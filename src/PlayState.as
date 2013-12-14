package
{

	import adobe.utils.CustomActions;
	import flash.errors.InvalidSWFError;
	import org.flashdevelop.utils.TraceLevel;
	import org.flixel.*;
	import org.flixel.system.FlxDebugger;

	public class PlayState extends FlxState {
		
		

		public function PlayState() {
			super();

		}
		
		override public function create() : void {
			this.add(new Level(0));
			FlxG.bgColor = FlxG.WHITE;
		}
		
		override public function update() : void {
			super.update();
		}
		
	
		
		
	}

}