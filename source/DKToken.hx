package;


import flash.display.BitmapData;
import flash.filters.BitmapFilter;
import flixel.addons.display.FlxExtendedSprite;
//import flixel.plugin.photonstorm.FlxExtendedSprite;

class DKToken extends FlxExtendedSprite
{
	public var token_id:Int;
	public var TokenName:String;
	public var class_id:Int;
	public var attack:Int;
	public var defense:Int;
	public var element_id:Int;
	public var directions:Array<Int>;
	public var owner:Int;
	
	public var tokenInfo:Array<Dynamic>;
	
	public function new(X:Float, Y:Float, tid:Int, name:String, cid:Int, att:Int, def:Int, image:String, eid:Int, dirs:Array<Int>, cont:Int)
	{
		super(X, Y, image);
		
		token_id = tid;
		TokenName = name;
		class_id = cid;
		attack = att;
		defense = def;
		element_id = eid;
		directions = dirs;
		owner = cont;
	}
	
	public	function getTokenInfo():Array<Dynamic>
	{
		tokenInfo = [token_id,attack,defense,element_id,directions,owner];
		return tokenInfo;
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