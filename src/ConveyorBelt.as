package  
{
	/**
	 * ...
	 * @author Sam Tregillus
	 */
	public class ConveyorBelt extends Entity
	{
		public var speed : Number;
		public var direction : int;
		
		
		public function ConveyorBelt(tileX : int, tileY : int, dir : int, spd : Number) 
		{
			super(tileX, tileY);
			loadGraphic(Resources.imgConveyor, true, true, 20, 20);
			
			speed = spd;
			direction = dir;
			
			immovable = true;
			gravityEnabled = false;
			
			if (direction == -1) this.facing = LEFT;
			
			
			this.addAnimation("move", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], spd, true);
			
		}
		
		override public function update() : void {
			this.play("move");
		}
		
		override public function collideEntity(other : Entity) : void {
			other.velocity.x += speed * direction;
		}
		
	}

}