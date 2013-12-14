package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Sam Tregillus
	 */
	public class Button extends Entity
	{
		public var type : int = 0;
		public static var BTN_PRESS_ONCE = 0;
		public static var BTN_HOLD = 1;
		
		private var sinkDist : Number = 5;
		private var sinkSpeed : Number = 1;
		private var startY : int = 0;
		
		private var deactivateDelay : int = 4; //number of frames to wait before deciding that the player isn't on us anymore
		private var curDelay : int = 0;
		
		public var beingPressed : Boolean = false;
		
		public var activated : Boolean = false;
		
		public var targetEntity : Entity;
		
		
		public function Button(tileX : int, tileY : int, buttonType : int = 0, target : Entity = null) 
		{
			super(tileX, tileY);
			this.y += 10;
			this.startY = this.y;
			
			this.type = buttonType;
			
			this.loadGraphic(Resources.imgButton);
			this.height = 10;
			this.offset.y = 10;
			//this.color = 0xff0000;
			this.gravityEnabled = false;
			this.immovable = true;
			
			targetEntity = target;

		}
		
		override public function update() : void {
			super.update();
			
			if(beingPressed){
				if(this.y < this.startY + this.sinkDist)
					this.y += sinkSpeed;

			}
			else if (this.type == BTN_HOLD) {
				if (curDelay > 0) {
					curDelay -= 1;
				}
				else {
					if (this.y > this.startY) {
						this.y -= sinkSpeed;
					}
				}
			}
			
			if (this.y >= this.startY + this.sinkDist) {
				this.activated = true;
			}
			else {
				this.activated = false;
			}
			
			if (this.activated) {
				this.color = 0x00ff00;
				if(this.targetEntity)
					this.targetEntity.onPositive();
			}
			else {
				this.color = 0xff0000;
				if(this.targetEntity)
					this.targetEntity.onNegative();
			}
			
			beingPressed = false;
		}
		
		override public function collideEntity(other : Entity) : void {
			if (other is Player || other is Box) {
				if (this.y >= other.y + other.height - 2) {
					beingPressed = true;
					curDelay = deactivateDelay;
				}
			}
		}
	}

}