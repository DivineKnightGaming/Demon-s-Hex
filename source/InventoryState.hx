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

class InventoryState extends FlxState
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
		
		Registry.backbtn = new FlxButton(32, 32, "", goToMap);
		Registry.backbtn.loadGraphic(Registry.arrowLeftImg);
		add(Registry.backbtn);
		
		Registry.text = new FlxText(84,30,300,"Inventory State!");
		Registry.text.size = 30;
		add(Registry.text); 
		
		loadInventory();
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{
		super.update();
	}	
		
	private function loadInventory():Void
	{
        //var filePath:String = "http://localhost/demonshex/server/user/get_inventory.php";

        //var xmlString:String = sys.io.File.getContent(filePath);
        
        /*var service = "http://localhost/demonshex/server/user/get_inventory.php";
		var _call = new haxe.Http(service);
		_call.onData = onComplete;
		_call.onError = onError;
		_call.request(false);*/
		
        var myXml:Xml = Xml.parse(Registry.tokens).firstElement();
		var location = "assets/gfx/tokens/";
		var x = 32;
		var y = 128;
		var count1 = 0;
		var count2 = 1;
		for( child in myXml.elements() ) {
			tokenspr = new FlxSprite(x,y,location+child.get("image"));
			add(tokenspr);
			x = x + 128;
			count1 = count1 +1;
			if(count1 == 5)
			{
				count1 = 0;
				count2 = count2 + 1;
				y = y + 96;
				if(count2 % 2 == 0)
				{
					x = 96;
				}
				else
				{
					x = 32;
				}
				
			}
		}
        
	}
	
	function onComplete(the_data:String)
	{
		var myXml:Xml = Xml.parse(the_data).firstElement();
		//var myRule:haxe.xml.Rule;
		//myRule = RNode('token_list',[],RNode('token',[],RData()));
		var location = "assets/gfx/tokens/";
		
		for( child in myXml ) {
			tokenspr = new FlxSprite(32,128,location+child.get("image"));
		}
	}
	
	function onError(msg:String) 
	{
		trace("ERROR "+msg);
	}
		
	private function goToMap():Void
	{
		FlxG.switchState(new MapState());
	}
}
