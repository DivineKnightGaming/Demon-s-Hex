package;

import haxe.xml.Fast;
import openfl.Assets;
import flash.geom.Rectangle;
import flash.net.SharedObject;

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

import flixel.addons.display.FlxExtendedSprite;

class PerfectState extends FlxState
{
	public var tokenspr:FlxSprite;
	
	override public function create():Void
	{
		#if !neko
		//FlxG.bgColor = 0xff131c1b;
		#else
		//FlxG.camera.bgColor = {rgb: 0x131c1b, a: 0xff};
		#end		
		
		Registry.init();
		FlxG.mouse.show(Registry.pointer);
		
		Registry.sprite = new FlxSprite(0,0,Registry.window768x576Img);
		add(Registry.sprite);
		Registry.sprite = new FlxSprite(0,0,Registry.window768x125Img);
		add(Registry.sprite);
		
		Registry.button = new FlxButton(325, 425, "Play Again", goToBattle);
		Registry.button.loadGraphic(Registry.buttonImg,true,false,160,40);
		Registry.button.label = new FlxText(0,0,160,"Play Again");
		Registry.button.label.setFormat(null, 24, 0xffffff, "center");
		add(Registry.button);
		
		Registry.button = new FlxButton(325, 485, "Return to Menu", goToMenu);
		Registry.button.loadGraphic(Registry.buttonImg,true,false,160,40);
		Registry.button.label = new FlxText(0,0,160,"Return to Menu");
		Registry.button.label.setFormat(null, 20, 0xffffff, "center");
		add(Registry.button);
		
		Registry.text = new FlxText(84,30,300,"Perfect Win!");
		Registry.text.size = 30;
		add(Registry.text); 
		
		Registry.text = new FlxText(84,200,300,"You captured every tokens!");
		Registry.text.size = 30;
		add(Registry.text); 
		
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{
		super.update();
	}	
		
	private function goToMenu():Void
	{
		FlxG.switchState(new MenuState());
	}
		
	private function goToBattle():Void
	{
		FlxG.switchState(new BattleState());
	}
}
