package  
{
	import flash.utils.Dictionary;
	import org.flixel.*;
	/**
	 * ...
	 * @author Sam Tregillus
	 */
	public class Player extends Entity
	{
		private var moveSpeed : Number = 150;
		
		public var levelRef : Level;
		
		public var hasBox : Boolean;
		
		public var state : String;
		
		public var controlConfig : Dictionary;
		
		public var accelNormal : Number = 8;
		public var accelCube : Number = 6;
		public var jumpNormal : Number = -275;
		public var jumpCube : Number = -200
		
		public function Player(startX:int, startY:int, lvlRef : Level) 
		{
			super(startX, startY);
			this.levelRef = lvlRef;
			
			this.loadGraphic(Resources.imgPlayer, true, true, 30, 40);
			this.width = 20;
			this.height = 20;
			this.offset.x = 5;
			this.offset.y = 20;
			this.maxVelocity.x = moveSpeed;
			
			
			
			//controls:
			controlConfig = new Dictionary();
			controlConfig["LEFT"] = "A";
			controlConfig["RIGHT"] = "D";
			controlConfig["UP"] = "W";
			controlConfig["DOWN"] = "S";
			controlConfig["JUMP"] = "SPACE";
			
			//hasBox = true;
		}
		
		override public function update() : void{
			super.update();
			
			HandleControls();
			
		}
		
		public function PickupBox() : void {
			for each(var ent : Entity in levelRef.entities.members) {
				if (ent is Box) {
					if (CC.getDistanceBetweenSprites(this, ent, true) < 40) {
						this.hasBox = true;
						this.height = 40;
						this.y -= 20;
						this.offset.y = 0;
						this.frame = 1;
						levelRef.entities.remove(ent, true);
						ent.destroy();
					}	
				}
			}
			
		}
		
		public function DropBox() : void {
			if (hasBox) {
				this.hasBox = false;
				this.height = 20;
				this.frame = 0;
				this.y += 20;
				this.offset.y = 20;
						
				var box : Box = new Box(this.x, this.y - 20, true);
				var dir : int = 1;
				if (this.facing == LEFT) dir = -1;
				
				box.velocity.x = 200 * dir;
				box.playerCollide = false;
				
				levelRef.entities.add(box);
			}
		}
		
		public function HandleControls() : void{
			//movement stuff
			var accFactor : Number = accelNormal;
			if (this.hasBox) accFactor = accelCube;
			
			if (FlxG.keys[this.controlConfig["LEFT"]]) {
				this.acceleration.x -= this.maxVelocity.x * accFactor;
				this.facing = LEFT;
			}
			if (FlxG.keys[this.controlConfig["RIGHT"]]) {
				this.acceleration.x += this.maxVelocity.x * accFactor;
				this.facing = RIGHT;
			}
			if (FlxG.keys.justPressed(this.controlConfig["JUMP"]) && this.isTouching(FlxObject.FLOOR)) {
				if (hasBox) 
					this.velocity.y += jumpCube;
				else
					this.velocity.y += jumpNormal;
			}
			
			if (FlxG.mouse.justPressed()) {
				if (hasBox) {
					DropBox();
				}
				else {
					PickupBox();
				}
			}
			
			
		}
		
		
	}

}