package  
{
	import org.flixel.FlxSprite;
	import org.flixel.*;
	/**
	 * ...
	 * @author Sam Tregillus
	 */
	public class Box extends Entity
	{
		private var blackBox : FlxSprite;
		
		public var alphaDir : int = 1;
		public var alphaSpeed : Number = .005;
		
		private var minAlpha : Number = 0;
		private var maxAlpha : Number = .4;
		
		public function Box(startX : Number, startY : Number, worldCoords : Boolean = false) 
		{
			super(startX, startY, worldCoords);
			this.loadGraphic(Resources.imgBox);
			
			blackBox = new FlxSprite(startX, startY);
			blackBox.loadGraphic(Resources.imgBoxBlack);
			blackBox.alpha = .5;

		}
		
		override public function update() : void {
			super.update();
			
			this.blackBox.x = this.x;
			this.blackBox.y = this.y;
			
			if (this.blackBox.alpha <= minAlpha) {
				this.alphaDir = 1;
				this.blackBox.alpha = minAlpha;
			}
			else if (this.blackBox.alpha >= maxAlpha) {
				this.alphaDir = -1;
				this.blackBox.alpha = maxAlpha;
			}
			
			this.blackBox.alpha += this.alphaSpeed * this.alphaDir;
			
		}

		override public function draw() : void {
			super.draw();
			blackBox.draw();
		}
		
		override public function collideTilemap(tilemap : FlxTilemap) : void {
			
			//if (!beingCarried) {
				super.collideTilemap(tilemap);
			//}
		}
		
		override public function collideEntity(other : Entity) : void {
			//if (!beingCarried) {
				super.collideEntity(other);
			//}
		}
		
	}

}