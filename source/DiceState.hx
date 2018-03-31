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

class DiceState extends FlxState
{
	private var button:FlxButton;
	private var ran:Int;
	private var rolling:Bool;
	private var randomFilter:FlxSpriteFilter;
	
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
		
		Registry.randomBattleAnim.x = 325;
		Registry.randomBattleAnim.y = 100;
		add(Registry.randomBattleAnim);
		
		button = new FlxButton(215, 305, "Roll Attack", rollAttack);
		button.loadGraphic(Registry.buttonImg,true,false,160,40);
		button.label = new FlxText(0,0,160,"Roll Attack");
		button.label.setFormat(null, 20, 0xffffff, "center");
		add(button);
		
		button = new FlxButton(215, 365, "Roll Enemy Attack", rollEnemyAttack);
		button.loadGraphic(Registry.buttonImg,true,false,160,40);
		button.label = new FlxText(0,0,160,"Roll Enemy Attack");
		button.label.setFormat(null, 16, 0xffffff, "center");
		add(button);
		
		button = new FlxButton(215, 425, "Roll Even Attack", rollEvenAttack);
		button.loadGraphic(Registry.buttonImg,true,false,160,40);
		button.label = new FlxText(0,0,160,"Roll Even Attack");
		button.label.setFormat(null, 16, 0xffffff, "center");
		add(button);
		
		button = new FlxButton(395, 305, "Roll Defense", rollDefense);
		button.loadGraphic(Registry.buttonImg,true,false,160,40);
		button.label = new FlxText(0,0,160,"Roll Defense");
		button.label.setFormat(null, 20, 0xffffff, "center");
		add(button);
		
		button = new FlxButton(395, 365, "Roll Enemy Defense", rollEnemyDefense);
		button.loadGraphic(Registry.buttonImg,true,false,160,40);
		button.label = new FlxText(0,0,160,"Roll Enemy Defense");
		button.label.setFormat(null, 16, 0xffffff, "center");
		add(button);
		
		button = new FlxButton(395, 425, "Roll Even Defense", rollEvenDefense);
		button.loadGraphic(Registry.buttonImg,true,false,160,40);
		button.label = new FlxText(0,0,160,"Roll Even Defense");
		button.label.setFormat(null, 16, 0xffffff, "center");
		add(button);
		
		button = new FlxButton(325, 485, "Roll Turn Order", rollTurnOrder);
		button.loadGraphic(Registry.buttonImg,true,false,160,40);
		button.label = new FlxText(0,0,160,"Roll Turn Order");
		button.label.setFormat(null, 16, 0xffffff, "center");
		add(button);
		
		Registry.backbtn = new FlxButton(32, 256, "", goToMenu);
		Registry.backbtn.loadGraphic(Registry.arrowLeftImg);
		add(Registry.backbtn);
		
		Registry.sprite = new FlxSprite(0,0,Registry.frameImg);
		add(Registry.sprite);
		
		rolling = false;
		ran = 0;
	}
	
	private function rollAttack():Void
	{
		if (rolling == false)
		{
			ran = Std.random(6);
			Registry.randomBattleAnim.animation.play("attack");
			rolling = true;
			haxe.Timer.delay(endAnimation, 2000);
		}
	}
	
	private function rollEnemyAttack():Void
	{
		if (rolling == false)
		{
			ran = Std.random(6);
			Registry.randomBattleAnim.animation.play("attack_enemy");
			rolling = true;
			haxe.Timer.delay(endAnimation, 2000);
		}
	}
	
	private function rollEvenAttack():Void
	{
		if (rolling == false)
		{
			ran = Std.random(6);
			Registry.randomBattleAnim.animation.play("attack_even");
			rolling = true;
			haxe.Timer.delay(endAnimation, 2000);
		}
	}
	
	private function rollDefense():Void
	{
		if (rolling == false)
		{
			ran = Std.random(6);
			Registry.randomBattleAnim.animation.play("defense");
			rolling = true;
			haxe.Timer.delay(endAnimation, 2000);
		}
	}
	
	private function rollEnemyDefense():Void
	{
		if (rolling == false)
		{
			ran = Std.random(6);
			Registry.randomBattleAnim.animation.play("defense_enemy");
			rolling = true;
			haxe.Timer.delay(endAnimation, 2000);
		}
	}
	
	private function rollEvenDefense():Void
	{
		if (rolling == false)
		{
			ran = Std.random(6);
			Registry.randomBattleAnim.animation.play("defense_even");
			rolling = true;
			haxe.Timer.delay(endAnimation, 2000);
		}
	}
	
	private function rollTurnOrder():Void
	{
		if (rolling == false)
		{
			ran = Std.random(6);
			Registry.randomBattleAnim.animation.play("turnorder");
			rolling = true;
			haxe.Timer.delay(endAnimation, 2000);
		}
	}
	
	private function endAnimation():Void
	{
		rolling = false;
	}
	
	private function goToMenu():Void
	{
		FlxG.switchState(new MenuState());
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{
		super.update();
		
		if (rolling == false)
		{
			if(Registry.randomBattleAnim.animation.curAnim != null && Registry.randomBattleAnim.animation.curAnim.curFrame == ran)
			{
				Registry.randomBattleAnim.animation.curAnim.stop();
				Registry.randomBattleAnim.animation.curAnim.curFrame = ran;
			}
		}
		
	}	
}
