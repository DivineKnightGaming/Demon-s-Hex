package;

import openfl.Assets;
import flash.geom.Rectangle;
import flash.net.SharedObject;
import org.flixel.FlxButton;
import org.flixel.FlxG;
import org.flixel.FlxPath;
import org.flixel.FlxSave;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.plugin.photonstorm.FlxExtendedSprite;
import org.flixel.plugin.photonstorm.FlxMouseControl;
//import org.flixel.FlxU;

class BattleState extends FlxState
{
	public var playerHand:Array<Dynamic>;
	public var enemyHand:Array<Dynamic>;
	public var playerDeck:Array<Dynamic>;
	public var enemyDeck:Array<Dynamic>;
	public var location = "assets/gfx/tokens/";
	
	public var tokenStartX:Float;
	public var tokenStartY:Float;
	
	public var turnOrder:Int;
	
	public var gameGrid:Array<Dynamic>;
	public var gameGridX:Int;
	public var gameGridY:Int;
	
	override public function create():Void
	{
		#if !neko
		FlxG.bgColor = 0xff131c1b;
		#else
		FlxG.camera.bgColor = {rgb: 0x131c1b, a: 0xff};
		#end		
		
		Registry.init();
		FlxG.mouse.show(Registry.pointer);
		
		add(Registry.battleMap);
		#if (cpp || neko)
		Registry.tileMap.atlas = atlas;
		#end
		
		if (FlxG.getPlugin(FlxMouseControl) == null)
		{
			FlxG.addPlugin(new FlxMouseControl());
		}
		
		Registry.backbtn = new FlxButton(32, 256, "", goToMap);
		Registry.backbtn.loadGraphic(Registry.arrowLeftImg);
		add(Registry.backbtn);
		
		gameGrid = [[null,null,null], [null,null,null,null], [null,null,null]];
			
		Registry.sprite = new FlxSprite(200,110,Registry.boardSpace);
		add(Registry.sprite);
		Registry.sprite = new FlxSprite(320,110,Registry.boardSpace);
		add(Registry.sprite);
		Registry.sprite = new FlxSprite(440,110,Registry.boardSpace);
		add(Registry.sprite);
		
		Registry.sprite = new FlxSprite(140,216,Registry.boardSpace);
		add(Registry.sprite);
		Registry.sprite = new FlxSprite(260,216,Registry.boardSpace);
		add(Registry.sprite);
		Registry.sprite = new FlxSprite(380,216,Registry.boardSpace);
		add(Registry.sprite);
		Registry.sprite = new FlxSprite(500,216,Registry.boardSpace);
		add(Registry.sprite);
		
		
		Registry.sprite = new FlxSprite(200,322,Registry.boardSpace);
		add(Registry.sprite);
		Registry.sprite = new FlxSprite(320,322,Registry.boardSpace);
		add(Registry.sprite);
		Registry.sprite = new FlxSprite(440,322,Registry.boardSpace);
		add(Registry.sprite);
		
		add(Registry.boardTokenGroup);
		
		//enemy hand
		this.getEnemyHand();
		
		Registry.sprite = new FlxSprite(200,-40,Registry.tokenBack);
		add(Registry.sprite);
		Registry.sprite = new FlxSprite(264,-40,Registry.tokenBack);
		add(Registry.sprite);
		Registry.sprite = new FlxSprite(338,-40,Registry.tokenBack);
		add(Registry.sprite);
		Registry.sprite = new FlxSprite(392,-40,Registry.tokenBack);
		add(Registry.sprite);
		Registry.sprite = new FlxSprite(456,-40,Registry.tokenBack);
		add(Registry.sprite);
		Registry.sprite = new FlxSprite(520,-40,Registry.tokenBack);
		add(Registry.sprite);
		
		this.getPlayerHand();
		
		Registry.dktSprite = new DKToken(121, 475, playerHand[0][0], playerHand[0][1], playerHand[0][2], playerHand[0][4], playerHand[0][4], location + playerHand[0][5], playerHand[0][6], playerHand[0][7], 1);
		Registry.dktSprite.enableMouseDrag(true, true);
		Registry.dktSprite.mousePressedCallback = saveTokenStartXY;
		Registry.dktSprite.mouseReleasedCallback = positionToken;
		Registry.playerTokenGroup.add(Registry.dktSprite);
		Registry.dktSprite = new DKToken(185,475,playerHand[1][0], playerHand[1][1], playerHand[1][2], playerHand[1][4], playerHand[1][4], location + playerHand[1][5], playerHand[1][6], playerHand[1][7], 1);
		Registry.dktSprite.enableMouseDrag(true, true);
		Registry.dktSprite.mousePressedCallback = saveTokenStartXY;
		Registry.dktSprite.mouseReleasedCallback = positionToken;
		Registry.playerTokenGroup.add(Registry.dktSprite);
		Registry.dktSprite = new DKToken(249,475,playerHand[2][0], playerHand[2][1], playerHand[2][2], playerHand[2][4], playerHand[2][4], location + playerHand[2][5], playerHand[2][6], playerHand[2][7], 1);
		Registry.dktSprite.enableMouseDrag(true, true);
		Registry.dktSprite.mousePressedCallback = saveTokenStartXY;
		Registry.dktSprite.mouseReleasedCallback = positionToken;
		Registry.playerTokenGroup.add(Registry.dktSprite);
		Registry.dktSprite = new DKToken(313,475,playerHand[3][0], playerHand[3][1], playerHand[3][2], playerHand[3][4], playerHand[3][4], location + playerHand[3][5], playerHand[3][6], playerHand[3][7], 1);
		Registry.dktSprite.enableMouseDrag(true, true);
		Registry.dktSprite.mousePressedCallback = saveTokenStartXY;
		Registry.dktSprite.mouseReleasedCallback = positionToken;
		Registry.playerTokenGroup.add(Registry.dktSprite);
		Registry.dktSprite = new DKToken(377,475,playerHand[0][0], playerHand[4][1], playerHand[4][2], playerHand[4][4], playerHand[4][4], location + playerHand[4][5], playerHand[4][6], playerHand[4][7], 1);
		Registry.dktSprite.enableMouseDrag(true, true);
		Registry.dktSprite.mousePressedCallback = saveTokenStartXY;
		Registry.dktSprite.mouseReleasedCallback = positionToken;
		Registry.playerTokenGroup.add(Registry.dktSprite);
		Registry.dktSprite = new DKToken(441,475,playerHand[0][0], playerHand[5][1], playerHand[5][2], playerHand[5][4], playerHand[5][4], location + playerHand[5][5], playerHand[5][6], playerHand[5][7], 1);
		Registry.dktSprite.enableMouseDrag(true, true);
		Registry.dktSprite.mousePressedCallback = saveTokenStartXY;
		Registry.dktSprite.mouseReleasedCallback = positionToken;
		Registry.playerTokenGroup.add(Registry.dktSprite);
		add(Registry.playerTokenGroup);
		
		Registry.sprite = new FlxSprite(0,0,Registry.frameImg);
		add(Registry.sprite);
		
		turnOrder = 1;
	}

	override public function update():Void
	{
		if (turnOrder == 2)
		{
			//disable player input
			this.playEnemyTurn();
			turnOrder = 1;
		}
		else 
		{
			//enable player input
		}
		super.update();
	}	
	
	public function playEnemyTurn():Void 
	{
		
	}
	
	public function getEnemyHand():Void
	{
		/*var myXml:Xml = Xml.parse(Registry.tokens);
		trace(myXml);
		playerDeck = [];
		for ( child in myXml.elementsNamed("token") ) {
			trace(child);
			if(child.get("class_id") == "1")
			{
				playerDeck.push([location+child.get("image"),child.get("name"),child.get("attack"),child.get("defense"),child.get("class_id"),child.get("element"),child.get("directions")]);
			}
		}*/
		enemyHand = [];
		for(p in 0...6)
		{
			enemyHand.push(Registry.monsterTokens[Std.random(Registry.monsterTokens.length)]);
		}
	}
	
	public function getPlayerHand():Void
	{
		/*var myXml:Xml = Xml.parse(Registry.tokens);
		trace(myXml);
		playerDeck = [];
		for ( child in myXml.elementsNamed("token") ) {
			trace(child);
			if(child.get("class_id") == "1")
			{
				playerDeck.push([location+child.get("image"),child.get("name"),child.get("attack"),child.get("defense"),child.get("class_id"),child.get("element"),child.get("directions")]);
			}
		}*/
		playerHand = [];
		for(p in 0...6)
		{
			playerHand.push(Registry.heroTokens[Std.random(Registry.heroTokens.length)]);
		}
	}
	
	public function saveTokenStartXY(obj:FlxExtendedSprite, x:Int, y:Int):Void
	{
		tokenStartX = obj.x;
		tokenStartY = obj.y;
	}
	
	public function positionToken(obj:FlxExtendedSprite, x:Int, y:Int):Void
	{
		var newX:Float = 0;
		var newY:Float = 0;
		var changeHands:Bool = true;
		if (obj.y + 64 >= 126 && obj.y + 64 <= 190)
		{
			newY = 110;
			gameGridY = 1;
			if (obj.x + 64 >= 216 && obj.x + 64 <= 280)
			{
				newX = 200;
				gameGridX = 1;
			}
			else if (obj.x + 64 >= 336 && obj.x + 64 <= 400)
			{
				newX = 320;
				gameGridX = 2;
			}
			else if (obj.x + 64 >= 456 && obj.x + 64 <= 520)
			{
				newX = 440;
				gameGridX = 3;
			}
			else
			{
				newX = tokenStartX;
				newY = tokenStartY;
				changeHands = false;
			}
			
		}
		else if(obj.y + 64 >= 232 && obj.y + 64 <= 296)
		{
			newY = 216;
			gameGridY = 2;
			if (obj.x + 64 >= 156 && obj.x + 64 <= 220)
			{
				newX = 140;
				gameGridX = 1;
			}
			else if (obj.x + 64 >= 276 && obj.x + 64 <= 340)
			{
				newX = 260;
				gameGridX = 2;
			}
			else if (obj.x + 64 >= 396 && obj.x + 64 <= 460)
			{
				newX = 380;
				gameGridX = 3;
			}
			else if (obj.x + 64 >= 516 && obj.x + 64 <= 580)
			{
				newX = 500;
				gameGridX = 3;
			}
			else
			{
				newX = tokenStartX;
				newY = tokenStartY;
				changeHands = false;
			}
		}
		else if(obj.y + 64 >= 338 && obj.y + 64 <= 402)
		{
			newY = 322;
			gameGridY = 3;
			if (obj.x + 64 >= 216 && obj.x + 64 <= 280)
			{
				newX = 200;
				gameGridX = 1;
			}
			else if (obj.x + 64 >= 336 && obj.x + 64 <= 400)
			{
				newX = 320;
				gameGridX = 2;
			}
			else if (obj.x + 64 >= 456 && obj.x + 64 <= 520)
			{
				newX = 440;
				gameGridX = 3;
			}
			else
			{
				newX = tokenStartX;
				newY = tokenStartY;
				changeHands = false;
			}
		}
		else
		{
			newX = tokenStartX;
			newY = tokenStartY;
			changeHands = false;
		}
		
		obj.x = newX;
		obj.y = newY;
		if (changeHands == true)
		{
			
			if (this.addTokenToGrid(obj.getTokenInfo(), gameGridX, gameGridY))
			{
			
				obj.mousePressedCallback = null;
				obj.mouseReleasedCallback = null;
				obj.disableMouseDrag();
				obj.addFilter(new GlowFilter(0x0000FF, 1, 30, 30, 2, 1), new FlxPoint(10, 10)); 

				Registry.playerTokenGroup.remove(obj);
				Registry.boardTokenGroup.add(obj);
				
				turnOrder = 2;
			}
			else 
			{
				obj.x = newX;
				obj.y = newY;
			}
		}
	}
	
	public function addTokenToGrid(tokenInfo:Array<Dynamic>,gridX:Int,gridY:Int):Bool
	{
		if (gameGrid[gridY][gridX] == null)
		{
			gameGrid[gridY][gridX] = tokenInfo;
			return true;
		}
		else
		{
			return false;
		}
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}
		
	private function goToMap():Void
	{
		FlxG.switchState(new MapState());
	}
}
