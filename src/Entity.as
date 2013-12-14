package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	/**
	 * ...
	 * @author ...
	 */
	public class Entity extends FlxSprite
	{
		public var gravityEnabled : Boolean = true;
		public var groundDrag : Number = 1000;
		public var airDrag : Number = 500;
		
		public var playerCollide : Boolean = true;
		
		public function Entity(startX:int = 0, startY:int = 0, worldCoords : Boolean = false) 
		{
			var mult : Number = CC.TILESIZE;
			if (worldCoords) mult = 1; 
			super(startX * mult, startY * mult);
		}
		
		public function collideEntity(other : Entity) : void {
			if (other is Player && !playerCollide) {
				
			}
			else{
				separate(this, other);
			}
			
		}
		
		public function collideTilemap(tilemap : FlxTilemap) : void {
			separate(this, tilemap);
		}
		
		override public function update() : void {
			//physics stuff
			this.acceleration.y = 0;
			this.acceleration.x = 0;
			if (gravityEnabled)
				this.acceleration.y = CC.GRAVITYAMOUNT;
				
			//friction stuff
			if (this.isTouching(FlxObject.FLOOR)) 
				this.drag.x = groundDrag;
			else 
				this.drag.x = airDrag
			
		}
		
		public function onPositive() : void {
			
		}
		
		public function onNegative() : void {
			
		}
	

		
	}

}