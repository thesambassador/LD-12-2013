package  
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Sam Tregillus
	 */
	public class Level extends FlxGroup
	{
		public var tileMap : FlxTilemap;
		public var entities : FlxGroup;
		
		public var player : Player;
		public var box : Box;
		
		public function Level(levelNum : int) 
		{
			super();
			tileMap = new FlxTilemap();
			tileMap.loadMap(FlxTilemap.arrayToCSV(Resources.basicLevel, 40), Resources.imgTilemap, 20, 20, FlxTilemap.AUTO);
			entities = new FlxGroup();
			
			this.add(entities);
			this.add(tileMap);
			
			
			player = new Player(13, 19, this);
			entities.add(player);
			
			box = new Box(16, 19);
			entities.add(box);
			
			entities.add(new Button(20, 21, Button.BTN_HOLD));
			
			entities.add(new ConveyorBelt(22, 21, 1, 20));
			entities.add(new ConveyorBelt(23, 21, 1, 20));
			entities.add(new ConveyorBelt(24, 21, 1, 20));
			entities.add(new ConveyorBelt(25, 21, 1, 20));
			
		}
		

		
		override public function update() : void {
			FlxG.overlap(entities, tileMap, collideTilemap);
			FlxG.overlap(entities, entities, collideEntities);

			tileMap.update();
			entities.update();
			

		}
		
		public function collideTilemap(obj1 : FlxObject, obj2 : FlxObject) : void{

			if (obj1 is FlxTilemap && obj2 is Entity) {
				(obj2 as Entity).collideTilemap(obj1 as FlxTilemap);
			}
			else {
				(obj1 as Entity).collideTilemap(obj2 as FlxTilemap);
			}
			
		}
		
		public function collideEntities(obj1 : FlxObject, obj2 : FlxObject) {
			var ent1 : Entity = obj1 as Entity;
			var ent2 : Entity = obj2 as Entity;
			ent1.collideEntity(ent2);
			ent2.collideEntity(ent1);
		}
		
		public function AddEntityAtTile(x:int, y:int, ent : Entity) {
			ent.x = x * CC.TILESIZE;
			ent.y = y * CC.TILESIZE;
			entities.add(ent);
		}
		
		public function AddButtonAt(x:int, y:int) {
			var btn : Button = new Button(0, 0);
			AddEntityAtTile(x, y, btn);
			btn.y += 10;
		}
	}

}