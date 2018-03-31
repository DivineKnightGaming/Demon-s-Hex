package;

import openfl.Assets;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.util.FlxPath;
import flixel.util.FlxSave;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxPoint;
import Registry;

class MenuState extends FlxState
{
	
	override public function create():Void
	{
		#if !neko
		//FlxG.bgColor = 0xff0000ff;
		#else
		//FlxG.bgColor = {rgb: 0x0000ff, a: 0xff};
		#end		
		Registry.init();
		FlxG.mouse.show(Registry.pointer);
		
		Registry.sprite = new FlxSprite(0,0,Registry.backgroundImg);
		add(Registry.sprite);
		
		Registry.sprite = new FlxSprite(0,0,Registry.frameImg);
		add(Registry.sprite);
		
		Registry.sprite = new FlxSprite(75,65,Registry.titleImg);
		add(Registry.sprite);
		
		Registry.sprite = new FlxSprite(475,368,Registry.knightImg);
		add(Registry.sprite);
		
		Registry.sprite = new FlxSprite(155,368,Registry.dragonImg);
		add(Registry.sprite);
		
		Registry.button = new FlxButton(305, 365, "Random Battle", goToBattle);
		Registry.button.loadGraphic(Registry.buttonImg,true,false,160,40);
		Registry.button.label = new FlxText(0,0,160,"Random Battle");
		Registry.button.label.setFormat(null, 22, 0xffffff, "center");
		add(Registry.button);
		
		Registry.button = new FlxButton(305, 425, "Story Mode", goToGame);
		Registry.button.loadGraphic(Registry.buttonImg,true,false,160,40);
		Registry.button.label = new FlxText(0,0,160,"Story Mode");
		Registry.button.label.setFormat(null, 24, 0xffffff, "center");
		add(Registry.button);
		
		Registry.button = new FlxButton(305, 485, "Dice Test", goToDice);
		Registry.button.loadGraphic(Registry.buttonImg,true,false,160,40);
		Registry.button.label = new FlxText(0,0,160,"Dice Test");
		Registry.button.label.setFormat(null, 24, 0xffffff, "center");
		add(Registry.button);
	}
	
	private function goToGame():Void
	{
		FlxG.switchState(new MapState());
	}
	
	private function goToBattle():Void
	{
		FlxG.switchState(new BattleState());
	}
	
	private function goToDice():Void
	{
		FlxG.switchState(new DiceState());
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{
		super.update();
	}	
}
