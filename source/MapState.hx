package;

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

class MapState extends FlxState
{
	
	override public function create():Void
	{
		#if !neko
		//FlxG.bgColor = 0xff131c1b;
		#else
		//FlxG.camera.bgColor = {rgb: 0x131c1b, a: 0xff};
		#end		
		
		Registry.init();
		FlxG.mouse.show(Registry.pointer);
		
		add(Registry.tileMap);
		#if (cpp || neko)
		Registry.tileMap.atlas = atlas;
		#end
		
		for (i in 0...Registry.trees.length )
		{
			if(Registry.trees[i][0] == 'P')
			{
				Registry.sprite = new FlxSprite(Registry.trees[i][1]*32,Registry.trees[i][2]*32,Registry.TreePath);
			}
			else
			{
				Registry.sprite = new FlxSprite(Registry.trees[i][1]*32,Registry.trees[i][2]*32,Registry.TreesImg);
			}
			add(Registry.sprite);
		}
		
		for (i in 0...Registry.mountains.length )
		{
			if(Registry.mountains[i][0] == 'P')
			{
				Registry.sprite = new FlxSprite(Registry.mountains[i][1]*32,Registry.mountains[i][2]*32,Registry.MountainPath);
			}
			else if(Registry.mountains[i][0] == 'C')
			{
				Registry.sprite = new FlxSprite(Registry.mountains[i][1]*32,Registry.mountains[i][2]*32,Registry.MountainCave);
			}
			else
			{
				Registry.sprite = new FlxSprite(Registry.mountains[i][1]*32,Registry.mountains[i][2]*32,Registry.MountainsImg);
			}
			add(Registry.sprite);
		}
		
		Registry.sprite = new FlxSprite(128,256,Registry.Castle);
		add(Registry.sprite);	
		
		Registry.sprite = new FlxSprite(576,448,Registry.House);
		add(Registry.sprite);
		
		Registry.sprite = new FlxSprite(384,160,Registry.BrokenBridge);
		add(Registry.sprite);
		
		for (i in 0...Registry.Nodes.length )
		{
			if(Registry.Nodes[i][0] == 'G')
			{
				Registry.sprite = new FlxSprite(Registry.Nodes[i][1],Registry.Nodes[i][2],Registry.GoodNodeImg);
			}
			else
			{
				Registry.sprite = new FlxSprite(Registry.Nodes[i][1],Registry.Nodes[i][2],Registry.BadNodeImg);
			}
			add(Registry.sprite);
		}
		
		Registry.sprite = new FlxSprite(0,0,Registry.frameImg);
		add(Registry.sprite);
		
		Registry.right_border = new FlxButton(743,0,"");
		Registry.right_border.setOnOverCallback(expandMenu);
		Registry.right_border.setOnOutCallback(retractMenu);
		Registry.right_border.loadGraphic(Registry.window125x576Img);
		add(Registry.right_border);
		
		Registry.battlebtn = new FlxButton(804, 32, "", goToBattle);
		Registry.battlebtn.loadGraphic(Registry.RandBattleImg);
		add(Registry.battlebtn);
		
		Registry.inventorybtn = new FlxButton(804, 128, "", goToInventory);
		Registry.inventorybtn.loadGraphic(Registry.InventoryImg);
		add(Registry.inventorybtn);
		
		Registry.buybtn = new FlxButton(804, 224, "", goToStore);
		Registry.buybtn.loadGraphic(Registry.StoreImg);
		add(Registry.buybtn);
		
		Registry.helpbtn = new FlxButton(804, 320, "", goToHelp);
		Registry.helpbtn.loadGraphic(Registry.HelpImg);
		add(Registry.helpbtn);
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{
		super.update();
	}	
		
	public function expandMenu():Void 
	{
		if(FlxG.mouse.x < 800)
		{
			Registry.right_border.x = 643;
			Registry.battlebtn.x = 675;
			Registry.inventorybtn.x = 675;
			Registry.buybtn.x = 675;
			Registry.helpbtn.x = 675;
		}
	}
	
	public function retractMenu():Void 
	{
		Registry.right_border.x = 743;
		Registry.battlebtn.x = 804;
		Registry.inventorybtn.x = 804;
		Registry.buybtn.x = 804;
		Registry.helpbtn.x = 804;
	}
		
	private function goToHelp():Void
	{
		//FlxG.switchState(new HelpState());
	}
	
	private function goToBattle():Void
	{
		FlxG.switchState(new BattleState());
	}
	
	private function goToStore():Void
	{
		//FlxG.switchState(new StoreState());
	}
	
	private function goToInventory():Void
	{
		FlxG.switchState(new InventoryState());
	}
}
