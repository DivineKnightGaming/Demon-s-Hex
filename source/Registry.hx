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
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.effects.FlxSpriteFilter;

import flixel.addons.display.FlxExtendedSprite;
//import flixel.plugin.photonstorm.fx.StarfieldFX;
 
class Registry
{
		
	public static var frameImg = "assets/gfx/768x576_frame.png";
	public static var window768x576Img = "assets/gfx/768x576_window.png";
	public static var window768x125Img = "assets/gfx/768x125_window.png";
	public static var window125x576Img = "assets/gfx/125x576_window.png";
	public static var window150x300Img = "assets/gfx/150x300_window.png";
	public static var window150x175Img = "assets/gfx/150x175_window.png";
	
	public static var backgroundImg = "assets/gfx/background.png";
	public static var titleImg = "assets/gfx/title.png";
	public static var dragonImg = "assets/gfx/small_dragon.png";
	public static var knightImg = "assets/gfx/small_helmet.png";
	
	public static var arrowLeftImg = "assets/gfx/sm_arrow_l.png";
	public static var arrowRightImg = "assets/gfx/sm_arrow_r.png";
	public static var arrowLeftImgSmall = "assets/gfx/small_arrow_l.png";
	public static var arrowRightImgSmall = "assets/gfx/small_arrow_r.png";
	public static var tokenBackSmall = "assets/gfx/token_back_small.png";
	
	public static var pointer = "assets/gfx/pointer.png";
	public static var buttonImg = "assets/gfx/buttondk.png";
		
	public static var RandBattleImg = "assets/gfx/random_battle.png";
	public static var InventoryImg = "assets/gfx/inventory.png";
	public static var HelpImg = "assets/gfx/help.png";
	public static var StoreImg = "assets/gfx/buy.png";
	
	public static var TreesImg = "assets/gfx/trees.png";
	public static var TreePath="assets/gfx/trees_opening.png";
	public static var MountainsImg="assets/gfx/mountains.png";
	public static var MountainPath="assets/gfx/mountains_path.png";
	public static var MountainCave="assets/gfx/mountains_cave.png";
	
	public static var Castle="assets/gfx/castle.png";
	public static var House="assets/gfx/house.png";
	public static var Bridge="assets/gfx/bridge.png";
	public static var BrokenBridge="assets/gfx/delap_bridge.png";
	public static var EvilTower="assets/gfx/tower_evil.png";
	
	public static var MapTiles="assets/gfx/map_tiles.png";
	
	public static var GoodNodeImg="assets/gfx/node_good.png";
	public static var BadNodeImg="assets/gfx/node_bad.png";
	
	public static var boardSpace="assets/gfx/board_space_outdoor.png";
	public static var gameBoard="assets/gfx/gameboard.png";
	public static var tokenBack="assets/gfx/token_back.png";
	public static var randomAnimation="assets/gfx/random_battle_animations.png";
	public static var wallVertical="assets/gfx/board_wall_vertical.png";
	public static var wallHorizontalNE="assets/gfx/board_wall_horizontal_ne.png";
	public static var wallHorizontalNW="assets/gfx/board_wall_horizontal_nw.png";
	
	public static var sprite:FlxSprite;
	public static var extSprite:FlxExtendedSprite;
	public static var dktSprite:DKToken;
	public static var dktFilter:FlxSpriteFilter;
	public static var text:FlxText;
	public static var button:FlxButton;
	public static var playerScore:FlxText;
	public static var enemyScore:FlxText;
	public static var randomBattleAnim:FlxSprite;
	
	public static var map:Array<Int>;
	public static var battleBackground:Array<Int>;
	public static var tileMap:FlxTilemap;
	public static var battleMap:FlxTilemap;
	public static var trees:Array<Dynamic>;
	public static var mountains:Array<Dynamic>;
	
	public static var right_border:FlxButton;
	public static var buybtn:FlxButton;
	public static var battlebtn:FlxButton;
	public static var helpbtn:FlxButton;
	public static var inventorybtn:FlxButton;
	public static var backbtn:FlxButton;
	
	public static var Nodes:Array<Dynamic>;
	
	public static var tokens:String;
	public static var heroTokens:Array<Dynamic>;
	public static var monsterTokens:Array<Dynamic>;
	public static var npcTokens:Array<Dynamic>;
	public static var bossTokens:Array<Dynamic>;
	
	public static var playerTokenGroup:FlxGroup;
	public static var enemyTokenGroup:FlxGroup;
	public static var boardTokenGroup:FlxTypedGroup<FlxExtendedSprite>;
	public static var boardFilterArray:Array<Dynamic>;
	
	public static var playerTurnInd:FlxSprite;
	public static var enemyTurnInd:FlxSprite;
	
	public static var walls:Array<Dynamic>;
	
	public static var score:Int;
		
	public static function init()
	{
		map = [
				0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,
				0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,5 ,5 ,5 ,2 ,0 ,0 ,0 ,0 ,0 ,
				0 ,0 ,0 ,0 ,1 ,5 ,5 ,5 ,5 ,5 ,5 ,2 ,0 ,0 ,7 ,19,19,19,10,5 ,2 ,0 ,0 ,0 ,
				0 ,0 ,0 ,0 ,7 ,19,19,19,19,19,19,10,13,5 ,9 ,19,19,19,19,19,8 ,0 ,0 ,0 ,
				0 ,0 ,0 ,0 ,7 ,19,19,19,19,19,19,19,14,19,19,19,19,19,19,12,4 ,0 ,0 ,0 ,
				0 ,0 ,1 ,5 ,9 ,19,19,19,19,19,19,19,14,19,19,19,19,19,19,8 ,0 ,0 ,0 ,0 ,
				0 ,0 ,7 ,19,19,19,19,19,19,19,19,19,14,19,19,19,19,19,19,8 ,0 ,0 ,0 ,0 ,
				0 ,0 ,7 ,19,19,19,19,19,19,16,15,15,17,19,19,19,19,19,19,8 ,0 ,0 ,0 ,0 ,
				0 ,0 ,7 ,19,19,19,19,19,19,14,19,19,19,19,19,19,19,19,19,8 ,0 ,0 ,0 ,0 ,
				0 ,0 ,7 ,19,19,19,19,19,19,14,19,19,19,19,19,19,19,19,19,8 ,0 ,0 ,0 ,0 ,
				0 ,0 ,7 ,19,19,19,19,19,19,18,19,19,19,19,19,19,19,19,19,8 ,0 ,0 ,0 ,0 ,
				0 ,0 ,7 ,19,19,19,19,19,19,19,19,19,19,19,12,6 ,6 ,6 ,6 ,4 ,0 ,0 ,0 ,0 ,
				0 ,0 ,3 ,11,19,19,19,19,19,19,19,19,19,19,8 ,0 ,1 ,5 ,5 ,2 ,0 ,0 ,0 ,0 ,
				0 ,0 ,0 ,3 ,11,12,6 ,6 ,6 ,6 ,11,19,19,12,4 ,0 ,7 ,19,19,10,5 ,2 ,0 ,0 ,
				0 ,0 ,0 ,0 ,3 ,4 ,0 ,0 ,0 ,0 ,3 ,6 ,6 ,4 ,0 ,0 ,7 ,19,19,19,19,8 ,0 ,0 ,
				0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,11,19,19,12,4 ,0 ,0 ,
				0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,6 ,6 ,4 ,0 ,0 ,0 ,
				0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
				];
		
		tileMap = new FlxTilemap();
		tileMap.loadMap(
			FlxTilemap.arrayToCSV(map, 24), 
			MapTiles, 
			32, 
			32, 0,0,0,
			FlxTilemap.OFF 
		);
		battleBackground = [
				19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,
				19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,
				19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,
				19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,
				19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,
				19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,
				19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,
				19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,
				19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,
				19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,
				19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,
				19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,
				19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,
				19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,
				19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,
				19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,
				19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,
				19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19
				];
		
		battleMap = new FlxTilemap();
		battleMap.loadMap(
			FlxTilemap.arrayToCSV(battleBackground, 24), 
			MapTiles, 
			32, 
			32, 0,0,0,
			FlxTilemap.OFF 
		);
		
		trees = [['T',6,3],['T',7,3],['T',8,3],['P',9,3],
				['T',5,4],['T',6,4],['T',7,4],['T',8,4],
				['T',5,5],['T',6,5],['T',7,5],['T',8,5],
				['T',3,6],['T',4,6],['T',5,6],['T',6,6],['P',7,6],
				['T',3,7]];
		
		mountains = [['M',15,2],['M',16,2],
					['P',15,3],['M',17,3],
					['M',17,4],
					['M',16,5],['M',17,5],
					['M',13,6],['M',14,6],['M',15,6],['M',16,6],['M',17,6],
					['M',13,7],['M',14,7],['M',15,7],['M',16,7],
					['M',10,8],['M',11,8],['M',12,8],['M',13,8],['M',14,8],['C',15,8],
					['M',10,9],['M',11,9],
					['M',10,10]];
		
		Nodes = [['G',184,384],['G',584,488],['B',264,264],['B',512,152],['B',520,312]];
		
		//0=token_id, 1=name, 2=class_id, 3=attack, 4=defense, 5=image, 6=element, 7=array[directions: tr,r,br,bl,l,tl], 8=Xposition
		heroTokens = [ 
						[6,'Acolyte',1,1,3,'acolyte.png',0,[0,1,0,1,0,0],0],
						[7,'Acolyte',1,1,3,'acolyte_girl.png',0,[0,0,1,0,1,0],0],
						[20,'Archer',1,4,2,'archer.png',0,[1,0,1,0,0,1],0],
						[21,'Archer',1,4,2,'archer_girl.png',0,[0,1,0,1,1,0],0],
						[58,'Bard',1,3,5,'bard_girl.png',0,[0,0,1,0,1,0],0],
						[57,'Bard',1,3,5,'bard.png',0,[0,1,0,0,1,0],0],
						[2,'Dark Knight',1,7,4,'dark_knight.png',0,[1,0,1,0,0,1],0],
						[26,'Dark Knight',1,7,4,'dark_knight_girl.png',0,[1,0,0,1,1,0],0],
						[18,'Footman',1,3,3,'footman.png',0,[1,1,0,0,1,1],0],
						[19,'Footman',1,3,3,'footman_girl.png',0,[1,1,1,0,0,1],0],
						[59,'Jester',1,3,5,'jester.png',0,[0,1,0,1,1,1],0],
						[60,'Jester',1,3,5,'jester_girl.png',0,[1,1,1,0,0,1],0],
						[46,'Knight of Blood',1,6,5,'knight_of_blood_girl.png',0,[1,0,1,1,0,0],0],
						[45,'Knight of Blood',1,6,5,'knight_of_blood.png',0,[0,1,1,0,1,0],0],
						[47,'Knight of Darkness',1,5,6,'knight_of_darkness.png',0,[1,0,0,1,0,1],0],
						[48,'Knight of Darkness',1,5,6,'knight_of_darkness_girl.png',0,[1,0,1,0,1,0],0],
						[27,'Paladin',1,5,6,'paladin.png',0,[0,1,0,1,0,0],0],
						[28,'Paladin',1,5,6,'paladin_girl.png',0,[0,0,0,1,0,1],0],
						[29,'Priest',1,3,5,'priest.png',0,[0,1,1,0,1,0],0],
						[49,'Priest of Blood',1,5,5,'priest_of_blood.png',0,[1,0,0,0,1,1],0],
						[51,'Priest of Darkness',1,6,4,'priest_of_darkness.png',0,[0,1,0,0,1,1],0],
						[30,'Priestess',1,3,5,'priestess.png',0,[1,1,0,1,0,0],0],
						[50,'Priestess of Blood',1,5,5,'priestess_of_blood.png',0,[0,1,1,1,0,0],0],
						[52,'Priestess of Darkness',1,6,4,'priestess_of_darkness.png',0,[0,0,1,1,0,1],0],
						[54,'Sorcerer',1,5,3,'sorcerer.png',0,[0,0,1,0,1,0],0],
						[53,'Sorceress',1,5,3,'sorceress.png',0,[0,1,0,1,0,0],0],
						[56,'Spearman',1,5,3,'spearman_girl.png',0,[0,0,0,1,1,0],0],
						[55,'Spearman',1,5,3,'spearman.png',0,[1,1,0,0,0,0],0],
						[9,'Squire',1,3,2,'squire_girl.png',0,[0,1,1,0,1,1],0],
						[8,'Squire',1,3,2,'squire.png',0,[1,1,0,1,1,0],0],
						[33,'Thief',1,4,3,'thief.png',0,[0,0,1,1,1,0],0],
						[34,'Thief',1,4,3,'thief_girl.png',0,[1,1,1,0,0,0],0],
						[31,'Wizard',1,5,2,'wizard.png',0,[0,1,1,0,0,1],0],
						[32,'Wizard',1,5,2,'wizard_girl.png',0,[1,0,0,1,0,1],0],
					];
		monsterTokens = [ 
						[17,'Bat',3,4,3,'bat.png',0,[0,0,0,1,1,1],0],
						[61,'Bat Skeleton',3,4,2,'bat_skeleton.png',0,[0,1,1,0,1,0],0],
						[35,'Blood Skeleton',3,4,2,'blood_skeleton.png',0,[0,0,1,1,0,1],0],
						[63,'Death Knight',3,5,6,'death_knight.png',0,[0,1,1,0,0,1],0],
						[64,'Death Knight',3,5,6,'death_knight_girl.png',0,[0,0,1,1,0,1],0],
						[42,'Demon',3,5,3,'demon.png',0,[1,0,1,0,1,1],0],
						[65,'Demon Skeleton',3,4,4,'demon_skeleton.png',0,[0,1,0,0,1,0],0],
						[12,'Earth Elemental',3,6,6,'earth_elemental.png',4,[0,1,1,1,0,0],0],
						[11,'Fire Elemental',3,6,5,'fire_elemental.png',2,[1,0,1,0,1,0],0],
						[66,'Ghost',3,3,3,'ghost.png',0,[0,0,1,0,0,0],0],
						[67,'Ghost Armor',3,4,5,'ghost_armor.png',0,[0,0,1,0,1,0],0],
						[68,'Ghost Mage',3,5,4,'ghost_mage.png',0,[1,0,0,1,0,0],0],
						[16,'Glop',3,2,3,'glop.png',0,[0,1,0,0,0,0],0],
						[22,'Goblin',3,3,1,'goblin.png',0,[0,0,1,1,1,0],0],
						[37,'Heads',3,3,3,'heads.png',0,[0,1,0,0,0,1],0],
						[36,'Imp',3,2,5,'imp.png',0,[1,0,0,1,1,0],0],
						[40,'Living Armor',3,3,5,'living_armor.png',0,[1,1,0,0,0,1],0],
						[24,'Ogre',3,5,3,'ogre.png',0,[1,0,0,1,0,1],0],
						[23,'Orc',3,4,3,'orc.png',0,[1,1,0,0,1,0],0],
						[43,'Skeleton Knight',3,5,2,'skeleton_knight.png',0,[1,1,0,0,1,0],0],
						[15,'Slime',3,2,1,'slime.png',0,[1,0,0,0,0,0],0],
						[44,'Snake',3,2,3,'snake.png',0,[0,1,1,0,0,0],0],
						[25,'Snake',3,3,2,'snake.png',0,[0,0,0,0,1,1],0],
						[38,'Spider',3,3,2,'spider.png',0,[0,1,1,1,0,0],0],
						[14,'Water Elemental',3,5,5,'water_elemental.png',1,[0,1,0,1,1,0],0],
						[39,'Whelp',3,4,2,'whelp.png',0,[1,1,0,1,0,0],0],
						[13,'Wind Elemental',3,4,6,'wind_elemental.png',3,[1,0,0,1,0,0],0],
						[41,'Zombie',3,2,4,'zombie.png',0,[0,0,0,1,0,0],0],
					];
		bossTokens = [
					[10, 'Winged Devil', 4, 8, 6, 'devil_winged.png', 0, [1,1,0,1,1,1]]
						];
		npcTokens = [
					[4, 'Divine Knight', 2, 9, 9, 'divine_knight_girl.png', 0, [1,1,1,1,1,1]],
					[1, 'Divine Knight', 2, 9, 9, 'divine_knight.png', 0, [1,1,1,1,1,1]],
					[3, 'Pacifist', 2, 9, 9, 'pacfist.png', 0, [0,0,0,0,0,0]],
					[5, 'Pacifist', 2, 9, 9, 'pacifist_woman.png', 0, [0,0,0,0,0,0]]
						];
		
		tokens = "<token_list>
					<token id='6' name='Acolyte' class_id='1' attack='1' defense='3' image='acolyte.png' element='0' directions='0,1,0,1,0,0'></token>
					<token id='7' name='Acolyte' class_id='1' attack='1' defense='3' image='acolyte_girl.png' element='0' directions='0,1,0,1,0,0'></token>
					<token id='20' name='Archer' class_id='1' attack='4' defense='2' image='archer.png' element='0' directions='1,0,1,0,0,1'></token>
					<token id='21' name='Archer' class_id='1' attack='4' defense='2' image='archer_girl.png' element='0' directions='1,0,1,0,0,1'></token>
					<token id='17' name='Bat' class_id='3' attack='4' defense='3' image='bat.png' element='0' directions='0,0,0,1,1,1'></token>
					<token id='18' name='Footman' class_id='1' attack='3' defense='3' image='footman.png' element='0' directions='1,1,0,0,1,1'></token>
					<token id='19' name='Footman' class_id='1' attack='3' defense='3' image='footman_girl.png' element='0' directions='1,1,0,0,1,1'></token>
					<token id='16' name='Glop' class_id='3' attack='2' defense='3' image='glop.png' element='0' directions='0,1,0,0,0,0'></token>
					<token id='22' name='Goblin' class_id='3' attack='3' defense='1' image='goblin.png' element='0' directions='0,0,1,1,1,0'></token>
					<token id='24' name='Ogre' class_id='3' attack='5' defense='3' image='ogre.png' element='0' directions='1,0,0,1,0,1'></token>
					<token id='23' name='Orc' class_id='3' attack='4' defense='3' image='orc.png' element='0' directions='1,1,0,0,1,0'></token>
					<token id='15' name='Slime' class_id='3' attack='2' defense='1' image='slime.png' element='0' directions='1,0,0,0,0,0'></token>
					<token id='25' name='Snake' class_id='3' attack='3' defense='2' image='snake.png' element='0' directions='0,0,0,0,1,1'></token>
					<token id='9' name='Squire' class_id='1' attack='3' defense='2' image='squire_girl.png' element='0' directions='1,1,0,1,1,0'></token>
					<token id='8' name='Squire' class_id='1' attack='3' defense='2' image='squire.png' element='0' directions='1,1,0,1,1,0'></token>
					<token id='12' name='Earth Elemental' class_id='3' attack='6' defense='6' image='earth_elemental.png' element='4' directions='0,1,1,1,0,0'></token>
					<token id='11' name='Fire Elemental' class_id='3' attack='6' defense='5' image='fire_elemental.png' element='2' directions='1,0,1,0,1,0'></token>
					<token id='14' name='Water Elemental' class_id='3' attack='5' defense='5' image='water_elemental.png' element='1' directions='0,1,0,1,1,0'></token>
					<token id='13' name='Wind Elemental' class_id='3' attack='4' defense='6' image='wind_elemental.png' element='3' directions='1,0,0,1,0,0'></token>
					<token id='2' name='Dark Knight' class_id='1' attack='7' defense='4' image='dark_knight.png' element='0' directions='1,0,1,0,0,1'></token>
					<token id='10' name='Winged Devil' class_id='4' attack='8' defense='6' image='devil_winged.png' element='0' directions='1,1,0,1,1,1'></token>
					<token id='4' name='Divine Knight' class_id='2' attack='9' defense='9' image='divine_knight_girl.png' element='0' directions='1,1,1,1,1,1'></token>
					<token id='1' name='Divine Knight' class_id='2' attack='9' defense='9' image='divine_knight.png' element='0' directions='1,1,1,1,1,1'></token>
					<token id='3' name='Pacifist' class_id='2' attack='9' defense='9' image='pacfist.png' element='0' directions='0,0,0,0,0,0'></token>
					<token id='5' name='Pacifist' class_id='2' attack='9' defense='9' image='pacifist_woman.png' element='0' directions='0,0,0,0,0,0'></token>
			  < / token_list > ";
			  
		walls = [
					[
					 [1, 0],
					 [0, 0, 0, 0, 0, 1],
					 [0, 0, 0],
					 [1, 0, 0, 0, 0, 0],
					 [0, 1]
					],
					[
					 [0, 1],
					 [1, 0, 0, 0, 0, 0],
					 [0, 0, 0],
					 [0, 0, 0, 0, 0, 1],
					 [1, 0]
					],
					[
					 [1, 1],
					 [0, 0, 0, 0, 0, 0],
					 [1, 0, 1],
					 [0, 0, 0, 0, 0, 0],
					 [1, 1]
					],
					[
					 [1, 1],
					 [0, 0, 0, 0, 0, 0],
					 [0, 0, 0],
					 [0, 0, 0, 0, 0, 0],
					 [1, 1]
					],
					[
					 [0, 0],
					 [0, 0, 0, 0, 0, 0],
					 [1, 1, 1],
					 [0, 0, 0, 0, 0, 0],
					 [0, 0]
					],
					[
					 [0, 0],
					 [0, 0, 1, 1, 0, 0],
					 [0, 1, 0],
					 [0, 0, 1, 1, 0, 0],
					 [0, 0]
					],
					[
					 [0, 0],
					 [1, 0, 1, 0, 1, 0],
					 [0, 0, 0],
					 [1, 0, 1, 0, 1, 0],
					 [0, 0]
					],
					[
					 [0, 0],
					 [0, 1, 0, 1, 0, 1],
					 [0, 0, 0],
					 [0, 1, 0, 1, 0, 1],
					 [0, 0]
					],
					[
					 [0, 0],
					 [1, 0, 1, 0, 1, 0],
					 [0, 0, 0],
					 [0, 1, 0, 1, 0, 1],
					 [0, 0]
					],
					[
					 [0, 0],
					 [0, 1, 0, 1, 0, 1],
					 [0, 0, 0],
					 [1, 0, 1, 0, 1, 0],
					 [0, 0]
					],
					[
					 [0, 1],
					 [1, 0, 0, 0, 0, 0],
					 [0, 1, 0],
					 [0, 0, 0, 0, 0, 1],
					 [1, 0]
					],
					[
					 [1, 0],
					 [0, 0, 0, 0, 0, 1],
					 [0, 1, 0],
					 [1, 0, 0, 0, 0, 0],
					 [0, 1]
					],
					[
					 [1, 0],
					 [0, 1, 0, 0, 0, 0],
					 [0, 1, 0],
					 [0, 0, 0, 0, 1, 0],
					 [0, 1]
					],
					[
					 [0, 0],
					 [1, 0, 1, 0, 0, 1],
					 [0, 0, 0],
					 [1, 0, 0, 1, 0, 1],
					 [0, 0]
					],
					[
					 [0, 0],
					 [1, 0, 0, 1, 0, 1],
					 [0, 0, 0],
					 [1, 0, 1, 0, 0, 1],
					 [0, 0]
					],
					[
					 [0, 0],
					 [1, 0, 0, 0, 0, 1],
					 [0, 1, 0],
					 [1, 0, 0, 0, 0, 1],
					 [0, 0]
					],
					[
					 [0, 0],
					 [0, 1, 0, 0, 1, 0],
					 [0, 1, 0],
					 [0, 1, 0, 0, 1, 0],
					 [0, 0]
					],
				];
		playerTokenGroup = new FlxGroup();
		enemyTokenGroup = new FlxGroup();
		boardTokenGroup = new FlxTypedGroup();
		boardFilterArray = new Array();
		boardFilterArray.push([null,null,null]);
		boardFilterArray.push([null,null,null,null]);
		boardFilterArray.push([null,null,null]);
		
		randomBattleAnim = new FlxSprite( 0, 0);
		randomBattleAnim.loadGraphic(Registry.randomAnimation, true, false, 128, 128);
		randomBattleAnim.animation.add("attack", [0, 1, 2, 3, 4, 5], 16, true);
		randomBattleAnim.animation.add("attack_enemy", [6, 7, 8, 9, 10, 11], 16, true);
		randomBattleAnim.animation.add("attack_even", [12, 13, 14, 15, 16, 17], 16, true);
		randomBattleAnim.animation.add("defense", [18, 19, 20, 21, 22, 23], 16, true);
		randomBattleAnim.animation.add("defense_enemy", [24, 25, 26, 27, 28, 29], 16, true);
		randomBattleAnim.animation.add("defense_even", [30, 31, 32, 33, 34, 35], 16, true);
		randomBattleAnim.animation.add("turnorder", [36, 37, 38, 39, 40, 41], 16, true);
		randomBattleAnim.animation.add("idle", [0], 16, false);
	}
}
