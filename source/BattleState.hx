package;

import openfl.Assets;
import flash.geom.Rectangle;
import flash.net.SharedObject;
import flash.filters.GlowFilter;

import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.util.FlxPath;
import flixel.util.FlxSave;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxPoint;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.effects.FlxSpriteFilter;

import flixel.addons.display.FlxExtendedSprite;
import flixel.addons.plugin.FlxMouseControl;
import DKToken;

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
	
	public var enemyToken:Array<Dynamic>;
	public var defenderToken:Array<Dynamic>;
	public var tokenPos:Int;
	
	public var moves:Int;
	
	public var objTest:FlxSpriteFilter;
	
	public var playerControl:Int;
	public var enemyControl:Int;
	
	public var battleRand:Int;
	public var battleGridX:Int;
	public var battleGridY:Int;
	public var battleBuff:Int;
	public var doingBattle:Bool;
	public var nextBattle:Bool;
	public var defenders:Array<Dynamic>;
	public var defenderGrids:Array<Dynamic>;
	public var battleWalls:Array<Dynamic>;
	
	override public function create():Void
	{
		#if !neko
		//FlxG.bgColor = 0xff131c1b;
		#else
		//FlxG.camera.bgColor = {rgb: 0x131c1b, a: 0xff};
		#end		
		
		Registry.init();
		FlxG.mouse.show(Registry.pointer);
		
		add(Registry.battleMap);
		#if (cpp || neko)
		Registry.tileMap.atlas = atlas;
		#end
		
		/*if (FlxG.getPlugin(FlxMouseControl) == null)
		{
			FlxG.addPlugin(new FlxMouseControl());
		}*/
		FlxG.plugins.add(new FlxMouseControl());
		
		Registry.backbtn = new FlxButton(32, 256, "", goToMap);
		Registry.backbtn.loadGraphic(Registry.arrowLeftImg);
		add(Registry.backbtn);
		
		gameGrid = new Array();
		gameGrid.push([null,null,null]);
		gameGrid.push([null,null,null,null]);
		gameGrid.push([null,null,null]);
		
		Registry.sprite = new FlxSprite(112,77,Registry.gameBoard);
		add(Registry.sprite);
		
		Registry.sprite = new FlxSprite(32,32,Registry.window150x175Img);
		add(Registry.sprite);
		
		this.displayWalls();
		
		add(Registry.boardTokenGroup);
		
		//enemy hand
		this.getEnemyHand();
		
		Registry.sprite = new FlxSprite(200,-40,Registry.tokenBack);
		Registry.enemyTokenGroup.add(Registry.sprite);
		Registry.sprite = new FlxSprite(264,-40,Registry.tokenBack);
		Registry.enemyTokenGroup.add(Registry.sprite);
		Registry.sprite = new FlxSprite(338,-40,Registry.tokenBack);
		Registry.enemyTokenGroup.add(Registry.sprite);
		Registry.sprite = new FlxSprite(392,-40,Registry.tokenBack);
		Registry.enemyTokenGroup.add(Registry.sprite);
		Registry.sprite = new FlxSprite(456,-40,Registry.tokenBack);
		Registry.enemyTokenGroup.add(Registry.sprite);
		Registry.sprite = new FlxSprite(520,-40,Registry.tokenBack);
		Registry.enemyTokenGroup.add(Registry.sprite);
		add(Registry.enemyTokenGroup);
		
		this.getPlayerHand();
		
		playerHand[0][8] = 121;
		Registry.dktSprite = new DKToken(121,475,playerHand[0][0], playerHand[0][1], playerHand[0][2], playerHand[0][4], playerHand[0][4], location + playerHand[0][5], playerHand[0][6], playerHand[0][7], 1);
		Registry.dktSprite.enableMouseDrag(true, true);
		Registry.dktSprite.mousePressedCallback = saveTokenStartXY;
		Registry.dktSprite.mouseReleasedCallback = positionToken;
		Registry.playerTokenGroup.add(Registry.dktSprite);
		playerHand[1][8] = 185;
		Registry.dktSprite = new DKToken(185,475,playerHand[1][0], playerHand[1][1], playerHand[1][2], playerHand[1][4], playerHand[1][4], location + playerHand[1][5], playerHand[1][6], playerHand[1][7], 1);
		Registry.dktSprite.enableMouseDrag(true, true);
		Registry.dktSprite.mousePressedCallback = saveTokenStartXY;
		Registry.dktSprite.mouseReleasedCallback = positionToken;
		Registry.playerTokenGroup.add(Registry.dktSprite);
		playerHand[2][8] = 249;
		Registry.dktSprite = new DKToken(249,475,playerHand[2][0], playerHand[2][1], playerHand[2][2], playerHand[2][4], playerHand[2][4], location + playerHand[2][5], playerHand[2][6], playerHand[2][7], 1);
		Registry.dktSprite.enableMouseDrag(true, true);
		Registry.dktSprite.mousePressedCallback = saveTokenStartXY;
		Registry.dktSprite.mouseReleasedCallback = positionToken;
		Registry.playerTokenGroup.add(Registry.dktSprite);
		playerHand[3][8] = 313;
		Registry.dktSprite = new DKToken(313,475,playerHand[3][0], playerHand[3][1], playerHand[3][2], playerHand[3][4], playerHand[3][4], location + playerHand[3][5], playerHand[3][6], playerHand[3][7], 1);
		Registry.dktSprite.enableMouseDrag(true, true);
		Registry.dktSprite.mousePressedCallback = saveTokenStartXY;
		Registry.dktSprite.mouseReleasedCallback = positionToken;
		Registry.playerTokenGroup.add(Registry.dktSprite);
		playerHand[4][8] = 377;
		Registry.dktSprite = new DKToken(377,475,playerHand[4][0], playerHand[4][1], playerHand[4][2], playerHand[4][4], playerHand[4][4], location + playerHand[4][5], playerHand[4][6], playerHand[4][7], 1);
		Registry.dktSprite.enableMouseDrag(true, true);
		Registry.dktSprite.mousePressedCallback = saveTokenStartXY;
		Registry.dktSprite.mouseReleasedCallback = positionToken;
		Registry.playerTokenGroup.add(Registry.dktSprite);
		playerHand[5][8] = 441;
		Registry.dktSprite = new DKToken(441,475,playerHand[5][0], playerHand[5][1], playerHand[5][2], playerHand[5][4], playerHand[5][4], location + playerHand[5][5], playerHand[5][6], playerHand[5][7], 1);
		Registry.dktSprite.enableMouseDrag(true, true);
		Registry.dktSprite.mousePressedCallback = saveTokenStartXY;
		Registry.dktSprite.mouseReleasedCallback = positionToken;
		Registry.playerTokenGroup.add(Registry.dktSprite);
		add(Registry.playerTokenGroup);
		
		Registry.sprite = new FlxSprite(0,0,Registry.frameImg);
		add(Registry.sprite);
		
		turnOrder = Std.random(2)+1;
		moves = 0;
		playerControl = 0;
		enemyControl = 0;
		
		Registry.sprite = new FlxSprite(56,56,Registry.tokenBackSmall);
		add(Registry.sprite);
		Registry.sprite = new FlxSprite(96,120,Registry.tokenBackSmall);
		add(Registry.sprite);
		
		Registry.enemyScore = new FlxText(72,44,300,Std.string(enemyControl));
		Registry.enemyScore.size = 56;
		Registry.enemyScore.color = 0x00ff0000;
		add(Registry.enemyScore); 
		
		Registry.playerScore = new FlxText(112,108,300,Std.string(playerControl));
		Registry.playerScore.size = 56;
		Registry.playerScore.color = 0x000000ff;
		add(Registry.playerScore); 
		
		add(Registry.randomBattleAnim);
		
		Registry.enemyTurnInd = new FlxSprite(120,-100,Registry.arrowLeftImgSmall);
		add(Registry.enemyTurnInd);
		Registry.playerTurnInd = new FlxSprite(64,-100,Registry.arrowRightImgSmall);
		add(Registry.playerTurnInd);
		
		Registry.randomBattleAnim.x = 318;
		Registry.randomBattleAnim.y = 220;
		Registry.randomBattleAnim.animation.play("turnorder");
		haxe.Timer.delay(endAnimation, 2000);
		
		turnOrder = 0;
		
		/*for (i in 0... playerHand.length)
		{
			trace("Orig X for " + i + ": " + playerHand[i][8]);
		}*/
	}
	
	public function displayWalls():Void
	{
		var ran = Std.random(Registry.walls.length);
		battleWalls = Registry.walls[ran];
		
		//first virtical row
		//318,141; 438,141; 
		if (battleWalls[0][0] == 1)
		{
			Registry.sprite = new FlxSprite(318,141,Registry.wallVertical);
			add(Registry.sprite);
		}
		if (battleWalls[0][1] == 1)
		{
			Registry.sprite = new FlxSprite(438,141,Registry.wallVertical);
			add(Registry.sprite);
		}
		
		//first horizontal row, NW/NE
		//204,207; 264,207; 324,207; 384,207; 444,207; 504,207;
		if (battleWalls[1][0] == 1)
		{
			Registry.sprite = new FlxSprite(204,207,Registry.wallHorizontalNW);
			add(Registry.sprite);
		}
		if (battleWalls[1][1] == 1)
		{
			Registry.sprite = new FlxSprite(264,207,Registry.wallHorizontalNE);
			add(Registry.sprite);
		}
		if (battleWalls[1][2] == 1)
		{
			Registry.sprite = new FlxSprite(324,207,Registry.wallHorizontalNW);
			add(Registry.sprite);
		}
		if (battleWalls[1][3] == 1)
		{
			Registry.sprite = new FlxSprite(384,207,Registry.wallHorizontalNE);
			add(Registry.sprite);
		}
		if (battleWalls[1][4] == 1)
		{
			Registry.sprite = new FlxSprite(444,207,Registry.wallHorizontalNW);
			add(Registry.sprite);
		}
		if (battleWalls[1][5] == 1)
		{
			Registry.sprite = new FlxSprite(504,207,Registry.wallHorizontalNE);
			add(Registry.sprite);
		}
		
		//second vertical row
		//258,248; 378,248; 498,248;
		if (battleWalls[2][0] == 1)
		{
			Registry.sprite = new FlxSprite(258,248,Registry.wallVertical);
			add(Registry.sprite);
		}
		if (battleWalls[2][1] == 1)
		{
			Registry.sprite = new FlxSprite(378,248,Registry.wallVertical);
			add(Registry.sprite);
		}
		if (battleWalls[2][2] == 1)
		{
			Registry.sprite = new FlxSprite(498,248,Registry.wallVertical);
			add(Registry.sprite);
		}
		
		//second horizontal row NE/NW
		//204,313; 264,313; 324,313; 384,313; 444,313; 504,313;
		if (battleWalls[3][0] == 1)
		{
			Registry.sprite = new FlxSprite(204,313,Registry.wallHorizontalNE);
			add(Registry.sprite);
		}
		if (battleWalls[3][1] == 1)
		{
			Registry.sprite = new FlxSprite(264,313,Registry.wallHorizontalNW);
			add(Registry.sprite);
		}
		if (battleWalls[3][2] == 1)
		{
			Registry.sprite = new FlxSprite(324,313,Registry.wallHorizontalNE);
			add(Registry.sprite);
		}
		if (battleWalls[3][3] == 1)
		{
			Registry.sprite = new FlxSprite(384,313,Registry.wallHorizontalNW);
			add(Registry.sprite);
		}
		if (battleWalls[3][4] == 1)
		{
			Registry.sprite = new FlxSprite(444,313,Registry.wallHorizontalNE);
			add(Registry.sprite);
		}
		if (battleWalls[3][5] == 1)
		{
			Registry.sprite = new FlxSprite(504,313,Registry.wallHorizontalNW);
			add(Registry.sprite);
		}
		
		//third vertical row
		//318,354; 438,354;
		if (battleWalls[4][0] == 1)
		{
			Registry.sprite = new FlxSprite(318,354,Registry.wallVertical);
			add(Registry.sprite);
		}
		if (battleWalls[4][1] == 1)
		{
			Registry.sprite = new FlxSprite(438,354,Registry.wallVertical);
			add(Registry.sprite);
		}
	}
	
	public function endAnimation():Void 
	{
		var ran = Std.random(6);
		if (ran % 2 == 0)
		{
			turnOrder = 2;
		}
		else
		{
			turnOrder = 1;
		}
		//Registry.randomBattleAnim.animation.gotoAndStop(ran);
		Registry.randomBattleAnim.animation.curAnim.stop();
		Registry.randomBattleAnim.animation.curAnim.curFrame = ran;
		haxe.Timer.delay(startGame, 1500);
		
	}
	
	public function startGame():Void
	{
		Registry.randomBattleAnim.x = 0;
		Registry.randomBattleAnim.y = 400;
		Registry.randomBattleAnim.animation.play("idle");
		if (turnOrder == 2)
		{
			haxe.Timer.delay(playEnemyTurn, 2000);
			Registry.enemyTurnInd.y = 72;
		}
		else
		{
			Registry.playerTurnInd.y = 136;
		}
	}

	override public function update():Void
	{
		Registry.enemyScore.text = Std.string(enemyControl);
		Registry.playerScore.text = Std.string(playerControl);
		
		if (enemyControl + playerControl < 10)
		{
			if (turnOrder == 2)
			{
				//Registry.enemyTurnInd.x = 96;
				Registry.enemyTurnInd.y = 72;
				Registry.playerTurnInd.y = -96;
			}
			else if (turnOrder == 1)
			{
				//Registry.playerTurnInd.x = 48;
				Registry.playerTurnInd.y = 136;
				Registry.enemyTurnInd.y = -96;
			}
		}
		else 
		{
			Registry.enemyTurnInd.y = -96;
			Registry.playerTurnInd.y = -96;
			
			haxe.Timer.delay(delayWinCondition,1000);
		}
		super.update();
	}	
	
	public function delayWinCondition():Void
	{
		Registry.score = playerControl;
		if (playerControl == 10)
		{
			FlxG.switchState(new PerfectState());
		}
		else if (enemyControl < playerControl)
		{
			FlxG.switchState(new WinState());
		}
		else if (enemyControl > playerControl)
		{
			FlxG.switchState(new LoseState());
		}
		else
		{
			FlxG.switchState(new DrawState());
		}
	}
	
	public function getEnemyHand():Void
	{
		enemyHand = [];
		for(p in 0...6)
		{
			var ran = Std.random(Registry.monsterTokens.length);
			//enemyHand.push(Registry.monsterTokens[Std.random(Registry.monsterTokens.length)]);
			enemyHand.push([Registry.monsterTokens[ran][0],Registry.monsterTokens[ran][1],Registry.monsterTokens[ran][2],Registry.monsterTokens[ran][3],Registry.monsterTokens[ran][4],Registry.monsterTokens[ran][5],Registry.monsterTokens[ran][6],Registry.monsterTokens[ran][7],0,p]);
		}
	}
	
	public function getPlayerHand():Void
	{
		playerHand = [];
		for(p in 0...6)
		{
			var ran = Std.random(Registry.heroTokens.length);
			playerHand.push([Registry.heroTokens[ran][0],Registry.heroTokens[ran][1],Registry.heroTokens[ran][2],Registry.heroTokens[ran][3],Registry.heroTokens[ran][4],Registry.heroTokens[ran][5],Registry.heroTokens[ran][6],Registry.heroTokens[ran][7],0,p]);
		}
	}
	
	public function saveTokenStartXY(obj:FlxExtendedSprite, x:Int, y:Int):Void
	{
		tokenStartX = obj.x;
		tokenStartY = obj.y;
	}
	
	public function positionToken(obj:FlxExtendedSprite, x:Int, y:Int):Void
	{
		if (turnOrder == 1)
		{
			var newX:Float = 0;
			var newY:Float = 0;
			var changeHands:Bool = true;
			if (obj.y + 64 >= 126 && obj.y + 64 <= 190)
			{
				newY = 110;
				gameGridY = 0;
				if (obj.x + 64 >= 216 && obj.x + 64 <= 280)
				{
					newX = 200;
					gameGridX = 0;
				}
				else if (obj.x + 64 >= 336 && obj.x + 64 <= 400)
				{
					newX = 320;
					gameGridX = 1;
				}
				else if (obj.x + 64 >= 456 && obj.x + 64 <= 520)
				{
					newX = 440;
					gameGridX = 2;
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
				gameGridY = 1;
				if (obj.x + 64 >= 156 && obj.x + 64 <= 220)
				{
					newX = 140;
					gameGridX = 0;
				}
				else if (obj.x + 64 >= 276 && obj.x + 64 <= 340)
				{
					newX = 260;
					gameGridX = 1;
				}
				else if (obj.x + 64 >= 396 && obj.x + 64 <= 460)
				{
					newX = 380;
					gameGridX = 2;
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
				gameGridY = 2;
				if (obj.x + 64 >= 216 && obj.x + 64 <= 280)
				{
					newX = 200;
					gameGridX = 0;
				}
				else if (obj.x + 64 >= 336 && obj.x + 64 <= 400)
				{
					newX = 320;
					gameGridX = 1;
				}
				else if (obj.x + 64 >= 456 && obj.x + 64 <= 520)
				{
					newX = 440;
					gameGridX = 2;
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
			
			if (changeHands == true)
			{
				
				if (this.addPlayerTokenToGrid(playerHand,tokenStartX, gameGridX, gameGridY) == true)
				{
					obj.x = newX;
					obj.y = newY;
				
					obj.mousePressedCallback = null;
					obj.mouseReleasedCallback = null;
					obj.disableMouseDrag();

					Registry.playerTokenGroup.remove(obj);
					//obj.addFilter(new GlowFilter(0x0000FF, 1, 10, 10, 2, 1), 10,10); 
					Registry.dktFilter = new FlxSpriteFilter(obj);
					Registry.dktFilter.addFilter(new GlowFilter(0x0000ff, 1, 10, 10, 2, 1));
					Registry.boardFilterArray[gameGridY][gameGridX] = Registry.dktFilter;
					Registry.boardTokenGroup.add(obj);
					
					turnOrder = 2;
					if (turnOrder == 2)
					{
						//disable player input
						if (playerControl+enemyControl < 10)
						{
							//this.playEnemyTurn();
							haxe.Timer.delay(playEnemyTurn,1000);
						}
					}
				}
				else 
				{
					obj.x = tokenStartX;
					obj.y = tokenStartY;
				}
			}
			else
			{
				obj.x = tokenStartX;
				obj.y = tokenStartY;
			}
		}
		else
		{
			obj.x = tokenStartX;
			obj.y = tokenStartY;
		}
	}
	
	public function playEnemyTurn():Void 
	{
		Registry.enemyTokenGroup.remove(Registry.enemyTokenGroup.getRandom(), false);
		
		var returnVals = EnemyAI.makeMove(gameGrid, battleWalls, enemyHand);
		tokenPos = returnVals[0];
		enemyToken = enemyHand[tokenPos];
		gameGridX = returnVals[1];
		gameGridY = returnVals[2];
		this.addEnemyTokenToGrid(enemyToken, gameGridX, gameGridY);
		
		var newX:Float = 0;
		var newY:Float = 0;
		
		if (gameGridY == 0)
		{
			newY = 110;
			if (gameGridX == 0)
			{
				newX = 200;
			}
			else if (gameGridX == 1)
			{
				newX = 320;
			}
			else if (gameGridX == 2)
			{
				newX = 440;
			}
		}
		else if (gameGridY == 1)
		{
			newY = 216;
			if (gameGridX == 0)
			{
				newX = 140;
			}
			else if (gameGridX == 1)
			{
				newX = 260;
			}
			else if (gameGridX == 2)
			{
				newX = 380;
			}
			else if (gameGridX == 3)
			{
				newX = 500;
			}
		}
		else if (gameGridY == 2)
		{
			newY = 322;
			if (gameGridX == 0)
			{
				newX = 200;
			}
			else if (gameGridX == 1)
			{
				newX = 320;
			}
			else if (gameGridX == 2)
			{
				newX = 440;
			}
		}
		
		enemyHand.remove(enemyToken);
		Registry.dktSprite = new DKToken(newX, newY, enemyToken[0], enemyToken[1], enemyToken[2], enemyToken[4], enemyToken[4], location + enemyToken[5], enemyToken[6], enemyToken[7], 2);
		//Registry.dktSprite.addFilter(new GlowFilter(0xff0000, 1, 10, 10, 2, 1), 10,10);
		//Registry.dktFilter = new FlxSpriteFilter(Registry.dktSprite);
		//Registry.dktFilter.addFilter(new GlowFilter(0xff0000, 1, 10, 10, 2, 1));
		//Registry.boardTokenGroup.push(Registry.dktFilter);
		Registry.dktFilter = new FlxSpriteFilter(Registry.dktSprite);
		Registry.dktFilter.addFilter(new GlowFilter(0xff0000, 1, 10, 10, 2, 1));
		Registry.boardFilterArray[gameGridY][gameGridX] = Registry.dktFilter;
		Registry.boardTokenGroup.add(Registry.dktSprite);
		
		turnOrder = 1;
	}
	
	public function addEnemyTokenToGrid(token:Array<Dynamic>,gridX:Int,gridY:Int):Void
	{
		token.push(2);
		enemyControl = enemyControl + 1;
		gameGrid[gridY][gridX] = token;
		gameGrid[gridY][gridX][10] = 2;
		this.doBattle(token, gridX, gridY);
		//trace("Enemy Control: " + enemyControl);
		moves = moves + 1;
	}
	
	public function addPlayerTokenToGrid(hand:Array<Dynamic>,startX:Float,gridX:Int,gridY:Int):Bool
	{
		if (gameGrid[gridY][gridX] == null)
		{
			for (i in 0... hand.length)
			{
				if (hand[i][8] == startX)
				{
					hand[i].push(1);
					playerControl = playerControl + 1;
					gameGrid[gridY][gridX] = hand[i];
					gameGrid[gridY][gridX][10] = 1;
					this.doBattle(hand[i], gridX, gridY);
					//trace("Player Control: " + playerControl);
					moves = moves + 1;
					return true;
				}
			}
			return false;
		}
		else
		{
			return false;
		}
	}
	
	public function doBattle(token:Array<Dynamic>,gridX:Int,gridY:Int):Void
	{
		//token
		//token[7=array[directions: 0=tr,1=r,2=br,3=bl,4=l,5=tl]]
		//token[3=attack, 4=defense]
		//gameGrid
		//gridY and gridX of placed tokenx
		defenderGrids = new Array();
		defenders = new Array();
		if (gridY == 0)
		{
			if (gridX == 0)
			{
				//bl,br,r
				if (token[7][1] == 1 && gameGrid[0][1] != null && token[10] != gameGrid[0][1][10] && battleWalls[0][0] == 0)
				{
					defenderToken = gameGrid[0][1];
					defenders.push(defenderToken);
					defenderGrids.push([0,1,defenderToken[7][4]]);
				}
				if (token[7][3] == 1 && gameGrid[1][0] != null && token[10] != gameGrid[1][0][10] && battleWalls[1][0] == 0)
				{
					defenderToken = gameGrid[1][0];
					defenders.push(defenderToken);
					defenderGrids.push([1,0,defenderToken[7][0]]);
				}
				if (token[7][2] == 1 && gameGrid[1][1] != null && token[10] != gameGrid[1][1][10] && battleWalls[1][1] == 0)
				{
					defenderToken = gameGrid[1][1];
					defenders.push(defenderToken);
					defenderGrids.push([1,1,defenderToken[7][5]]);
				}
			}
			else if (gridX == 1)
			{
				//l,bl,br,r
				if (token[7][4] == 1 && gameGrid[0][0] != null && token[10] != gameGrid[0][0][10] && battleWalls[0][0] == 0)
				{
					defenderToken = gameGrid[0][0];
					defenders.push(defenderToken);
					defenderGrids.push([0,0,defenderToken[7][1]]);
				}
				if (token[7][1] == 1 && gameGrid[0][2] != null && token[10] != gameGrid[0][2][10] && battleWalls[0][1] == 0)
				{
					defenderToken = gameGrid[0][2];
					defenders.push(defenderToken);
					defenderGrids.push([0,2,defenderToken[7][4]]);
				}
				if (token[7][3] == 1 && gameGrid[1][1] != null && token[10] != gameGrid[1][1][10] && battleWalls[1][2] == 0)
				{
					defenderToken = gameGrid[1][1];
					defenders.push(defenderToken);
					defenderGrids.push([1,1,defenderToken[7][0]]);
				}
				if (token[7][2] == 1 && gameGrid[1][2] != null && token[10] != gameGrid[1][2][10] && battleWalls[1][3] == 0)
				{
					defenderToken = gameGrid[1][2];
					defenders.push(defenderToken);
					defenderGrids.push([1,2,defenderToken[7][5]]);
				}
			}
			else if (gridX == 2)
			{
				//l,bl,br
				if (token[7][4] == 1 && gameGrid[0][1] != null && token[10] != gameGrid[0][1][10] && battleWalls[0][1] == 0)
				{
					defenderToken = gameGrid[0][1];
					defenders.push(defenderToken);
					defenderGrids.push([0,1,defenderToken[7][1]]);
				}
				if (token[7][3] == 1 && gameGrid[1][2] != null && token[10] != gameGrid[1][2][10] && battleWalls[1][4] == 0)
				{
					defenderToken = gameGrid[1][2];
					defenders.push(defenderToken);
					defenderGrids.push([1,2,defenderToken[7][0]]);
				}
				if (token[7][2] == 1 && gameGrid[1][3] != null && token[10] != gameGrid[1][3][10] && battleWalls[1][5] == 0)
				{
					defenderToken = gameGrid[1][3];
					defenders.push(defenderToken);
					defenderGrids.push([1,3,defenderToken[7][5]]);
				}
			}
		}
		else if (gridY == 1)
		{
			if (gridX == 0)
			{
				//tr,r,br
				if (token[7][0] == 1 && gameGrid[0][0] != null && token[10] != gameGrid[0][0][10] && battleWalls[1][0] == 0)
				{
					defenderToken = gameGrid[0][0];
					defenders.push(defenderToken);
					defenderGrids.push([0,0,defenderToken[7][3]]);
				}
				if (token[7][1] == 1 && gameGrid[1][1] != null && token[10] != gameGrid[1][1][10] && battleWalls[2][0] == 0)
				{
					defenderToken = gameGrid[1][1];
					defenders.push(defenderToken);
					defenderGrids.push([1,1,defenderToken[7][4]]);
				}
				if (token[7][2] == 1 && gameGrid[2][0] != null && token[10] != gameGrid[2][0][10] && battleWalls[3][0] == 0)
				{
					defenderToken = gameGrid[2][0];
					defenders.push(defenderToken);
					defenderGrids.push([2,0,defenderToken[7][5]]);
				}
			}
			else if (gridX == 1)
			{
				//all
				if (token[7][5] == 1 && gameGrid[0][0] != null && token[10] != gameGrid[0][0][10] && battleWalls[1][1] == 0)
				{
					defenderToken = gameGrid[0][0];
					defenders.push(defenderToken);
					defenderGrids.push([0,0,defenderToken[7][2]]);
				}
				if (token[7][0] == 1 && gameGrid[0][1] != null && token[10] != gameGrid[0][1][10] && battleWalls[1][2] == 0)
				{
					defenderToken = gameGrid[0][1];
					defenders.push(defenderToken);
					defenderGrids.push([0,1,defenderToken[7][3]]);
				}
				if (token[7][4] == 1 && gameGrid[1][0] != null && token[10] != gameGrid[1][0][10] && battleWalls[2][0] == 0)
				{
					defenderToken = gameGrid[1][0];
					defenders.push(defenderToken);
					defenderGrids.push([1,0,defenderToken[7][1]]);
				}
				if (token[7][1] == 1 && gameGrid[1][2] != null && token[10] != gameGrid[1][2][10] && battleWalls[2][1] == 0)
				{
					defenderToken = gameGrid[1][2];
					defenders.push(defenderToken);
					defenderGrids.push([1,2,defenderToken[7][4]]);
				}
				if (token[7][3] == 1 && gameGrid[2][0] != null && token[10] != gameGrid[2][0][10] && battleWalls[3][1] == 0)
				{
					defenderToken = gameGrid[2][0];
					defenders.push(defenderToken);
					defenderGrids.push([2,0,defenderToken[7][0]]);
				}
				if (token[7][2] == 1 && gameGrid[2][1] != null && token[10] != gameGrid[2][1][10] && battleWalls[3][2] == 0)
				{
					defenderToken = gameGrid[2][1];
					defenders.push(defenderToken);
					defenderGrids.push([2,1,defenderToken[7][5]]);
				}
			}
			else if (gridX == 2)
			{
				//all
				if (token[7][5] == 1 && gameGrid[0][1] != null && token[10] != gameGrid[0][1][10] && battleWalls[1][3] == 0)
				{
					defenderToken = gameGrid[0][1];
					defenders.push(defenderToken);
					defenderGrids.push([0,1,defenderToken[7][2]]);
				}
				if (token[7][0] == 1 && gameGrid[0][2] != null && token[10] != gameGrid[0][2][10] && battleWalls[1][4] == 0)
				{
					defenderToken = gameGrid[0][2];
					defenders.push(defenderToken);
					defenderGrids.push([0,2,defenderToken[7][3]]);
				}
				if (token[7][4] == 1 && gameGrid[1][1] != null && token[10] != gameGrid[1][1][10] && battleWalls[2][1] == 0)
				{
					defenderToken = gameGrid[1][1];
					defenders.push(defenderToken);
					defenderGrids.push([1,1,defenderToken[7][1]]);
				}
				if (token[7][1] == 1 && gameGrid[1][3] != null && token[10] != gameGrid[1][3][10] && battleWalls[2][2] == 0)
				{
					defenderToken = gameGrid[1][3];
					defenders.push(defenderToken);
					defenderGrids.push([1,3,defenderToken[7][4]]);
				}
				if (token[7][3] == 1 && gameGrid[2][1] != null && token[10] != gameGrid[2][1][10] && battleWalls[3][3] == 0)
				{
					defenderToken = gameGrid[2][1];
					defenders.push(defenderToken);
					defenderGrids.push([2,1,defenderToken[7][0]]);
				}
				if (token[7][2] == 1 && gameGrid[2][2] != null && token[10] != gameGrid[2][2][10] && battleWalls[3][4] == 0)
				{
					defenderToken = gameGrid[2][2];
					defenders.push(defenderToken);
					defenderGrids.push([2,2,defenderToken[7][5]]);
				}
			}
			else if (gridX == 3)
			{
				//tl,l,bl
				if (token[7][5] == 1 && gameGrid[0][2] != null && token[10] != gameGrid[0][2][10] && battleWalls[1][5] == 0)
				{
					defenderToken = gameGrid[0][2];
					defenders.push(defenderToken);
					defenderGrids.push([0,2,defenderToken[7][2]]);
				}
				if (token[7][4] == 1 && gameGrid[1][2] != null && token[10] != gameGrid[1][2][10] && battleWalls[2][2] == 0)
				{
					defenderToken = gameGrid[1][2];
					defenders.push(defenderToken);
					defenderGrids.push([1,2,defenderToken[7][1]]);
				}
				if (token[7][3] == 1 && gameGrid[2][2] != null && token[10] != gameGrid[2][2][10] && battleWalls[3][5] == 0)
				{
					defenderToken = gameGrid[2][2];
					defenders.push(defenderToken);
					defenderGrids.push([2,2,defenderToken[7][0]]);
				}
			}
		}
		else if (gridY == 2)
		{
			if (gridX == 0)
			{
				//tl,tr,r
				if (token[7][5] == 1 && gameGrid[1][0] != null && token[10] != gameGrid[1][0][10] && battleWalls[3][0] == 0)
				{
					defenderToken = gameGrid[1][0];
					defenders.push(defenderToken);
					defenderGrids.push([1,0,defenderToken[7][2]]);
				}
				if (token[7][0] == 1 && gameGrid[1][1] != null && token[10] != gameGrid[1][1][10] && battleWalls[3][1] == 0)
				{
					defenderToken = gameGrid[1][1];
					defenders.push(defenderToken);
					defenderGrids.push([1,1,defenderToken[7][3]]);
				}
				if (token[7][1] == 1 && gameGrid[2][1] != null && token[10] != gameGrid[2][1][10] && battleWalls[4][0] == 0)
				{
					defenderToken = gameGrid[2][1];
					defenders.push(defenderToken);
					defenderGrids.push([2,1,defenderToken[7][4]]);
				}
			}
			else if (gridX == 1)
			{
				//l,tl,tr,r
				if (token[7][5] == 1 && gameGrid[1][1] != null && token[10] != gameGrid[1][1][10] && battleWalls[3][2] == 0)
				{
					defenderToken = gameGrid[1][1];
					defenders.push(defenderToken);
					defenderGrids.push([1,1,defenderToken[7][2]]);
				}
				if (token[7][0] == 1 && gameGrid[1][2] != null && token[10] != gameGrid[1][2][10] && battleWalls[3][3] == 0)
				{
					defenderToken = gameGrid[1][2];
					defenders.push(defenderToken);
					defenderGrids.push([1,2,defenderToken[7][3]]);
				}
				if (token[7][4] == 1 && gameGrid[2][0] != null && token[10] != gameGrid[2][0][10] && battleWalls[4][0] == 0)
				{
					defenderToken = gameGrid[2][0];
					defenders.push(defenderToken);
					defenderGrids.push([2,0,defenderToken[7][1]]);
				}
				if (token[7][1] == 1 && gameGrid[2][2] != null && token[10] != gameGrid[2][2][10] && battleWalls[4][1] == 0)
				{
					defenderToken = gameGrid[2][2];
					defenders.push(defenderToken);
					defenderGrids.push([2,2,defenderToken[7][4]]);
				}
			}
			else if (gridX == 2)
			{
				//l,tl,tr
				if (token[7][5] == 1 && gameGrid[1][2] != null && token[10] != gameGrid[1][2][10] && battleWalls[3][4] == 0)
				{
					defenderToken = gameGrid[1][2];
					defenders.push(defenderToken);
					defenderGrids.push([1,2,defenderToken[7][2]]);
				}
				if (token[7][0] == 1 && gameGrid[1][3] != null && token[10] != gameGrid[1][3][10] && battleWalls[3][5] == 0)
				{
					defenderToken = gameGrid[1][3];
					defenders.push(defenderToken);
					defenderGrids.push([1,3,defenderToken[7][3]]);
				}
				if (token[7][4] == 1 && gameGrid[2][1] != null && token[10] != gameGrid[2][1][10] && battleWalls[4][1] == 0)
				{
					defenderToken = gameGrid[2][1];
					defenders.push(defenderToken);
					defenderGrids.push([2,1,defenderToken[7][1]]);
				}
			}
		}
		if (defenders.length > 0)
		{
			doingBattle = true;
			var i = 0;
			//trace("Entering Loop: " + defenders.length);
			while (doingBattle == true)
			{
				if (i < defenders.length)
				//while (i < defenders.length)
				{
					//if (nextBattle == true)
					//{
						//trace("Next battle: " + i);
						nextBattle = false;
						defenderToken = defenders[i];
						if (defenderGrids[i][2] == 1)
						{
							if (token[3] > defenderToken[3])
							{
								this.changeTokenColor(defenderGrids[i][1], defenderGrids[i][0]);
							}
							else if (token[3] == defenderToken[3])
							{
								this.pickRandom(defenderGrids[i][1], defenderGrids[i][0], 1);
							}
						}
						else 
						{
							if (token[3] > defenderToken[4])
							{
								this.changeTokenColor(defenderGrids[i][1], defenderGrids[i][0]);
							}
							else if (token[3] == defenderToken[4])
							{
								this.pickRandom(defenderGrids[i][1], defenderGrids[i][0], 2);
							}
						}
						i = i + 1;
					//}
				}
				else 
				{
					defenderGrids = null;
					defenders = null;
					doingBattle = false;
				}
			}
		}
	}
	
	public function pickRandom(gridX:Int,gridY:Int,buff:Int):Void
	{
		battleRand = Std.random(6);
		battleGridX = gridX;
		battleGridY = gridY;
		battleBuff = buff;
		if (buff == 1)
		{
			//Registry.randomBattleAnim.x = 300;
			//Registry.randomBattleAnim.y = 250;
			if (turnOrder == 1)
			{
				Registry.randomBattleAnim.animation.play("attack");
			}
			else
			{
				Registry.randomBattleAnim.animation.play("attack_enemy");
			}
			//haxe.Timer.delay(delayChangeColor,1000);
			this.delayChangeColor();
		}
		if (buff == 2)
		{
			//Registry.randomBattleAnim.x = 300;
			//Registry.randomBattleAnim.y = 250;
			if (turnOrder == 1)
			{
				Registry.randomBattleAnim.animation.play("defense");
			}
			else
			{
				Registry.randomBattleAnim.animation.play("defense_enemy");
			}
			//haxe.Timer.delay(delayChangeColor,1000);
			this.delayChangeColor();
		}
	}
	
	public function delayChangeColor():Void
	{
		//Registry.randomBattleAnim.animation.gotoAndStop(battleRand);
		Registry.randomBattleAnim.animation.curAnim.stop();
		Registry.randomBattleAnim.animation.curAnim.curFrame = battleRand;
		nextBattle = true;
		switch(battleRand)
		{
			case 0, 2, 3, 5:
				if (battleBuff == 1)
				{
					this.changeTokenColor(battleGridX, battleGridY);
					//Registry.randomBattleAnim.x = -300;
					//Registry.randomBattleAnim.y = -250;
				}
			case 1, 4:
				if (battleBuff == 2)
				{
					this.changeTokenColor(battleGridX, battleGridY);
					//Registry.randomBattleAnim.x = -300;
					//Registry.randomBattleAnim.y = -250;
				}
		}
	}
	
	public function changeTokenColor(gridX:Int,gridY:Int):Void
	{
		var newX:Float = 0;
		var newY:Float = 0;
		if (gridY == 0)
		{
			newY = 105;
			if (gridX == 0)
			{
				newX = 195;
			}
			else if (gridX == 1)
			{
				newX = 315;
			}
			else if (gridX == 2)
			{
				newX = 435;
			}
		}
		else if (gridY == 1)
		{
			newY = 211;
			if (gridX == 0)
			{
				newX = 135;
			}
			else if (gridX == 1)
			{
				newX = 255;
			}
			else if (gridX == 2)
			{
				newX = 375;
			}
			else if (gridX == 3)
			{
				newX = 495;
			}
		}
		else if (gridY == 2)
		{
			newY = 317;
			if (gridX == 0)
			{
				newX = 195;
			}
			else if (gridX == 1)
			{
				newX = 315;
			}
			else if (gridX == 2)
			{
				newX = 435;
			}
		}
		//trace("NewX: " + newX + "; NewY: " + newY);
		//for (i in 0...Registry.boardTokenGroup.length)
		for(objTest in Registry.boardTokenGroup.members)
		{
			//objTest = Registry.boardTokenGroup[i];
			//trace("objX: " + objTest.x + "; objY: " + objTest.y);
			if ((objTest.x - 5) == newX && (objTest.y - 5) == newY)
			{
				//objTest.removeAllFilters();
				if (turnOrder == 1)
				{
					Registry.boardFilterArray[gridY][gridX].removeAllFilters();
					Registry.dktFilter = new FlxSpriteFilter(objTest);
					Registry.dktFilter.addFilter(new GlowFilter(0x0000ff, 1, 10, 10, 2, 1));
					Registry.boardFilterArray[gridY][gridX] = Registry.dktFilter;
					gameGrid[gridY][gridX][10] = 1;
					playerControl = playerControl + 1;
					enemyControl = enemyControl - 1;
				}
				else 
				{
					Registry.boardFilterArray[gridY][gridX].removeAllFilters();
					Registry.dktFilter = new FlxSpriteFilter(objTest);
					Registry.dktFilter.addFilter(new GlowFilter(0xff0000, 1, 10, 10, 2, 1));
					Registry.boardFilterArray[gridY][gridX] = Registry.dktFilter;
					gameGrid[gridY][gridX][10] = 2;
					playerControl = playerControl - 1;
					enemyControl = enemyControl + 1;
				}
			}
		}
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}
		
	private function goToMap():Void
	{
		if (turnOrder == 1 || turnOrder == 2)
		{
			FlxG.switchState(new MapState());
		}
	}
}
