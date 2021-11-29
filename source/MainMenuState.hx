package;

import Controls.KeyboardScheme;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import BoyfriendRpg;
import flixel.tile.FlxTilemap;
import flixel.FlxCamera;
import rpg.Menu;

using StringTools;

class MainMenuState extends MusicBeatState
{
	var player:BoyfriendRpg;
	var tile:FlxTilemap;
	var map:Menu;

	var cam:FlxCamera;

	public static var kadeEngineVer:String = "1.5.1";
	public static var gameVer:String = "0.2.7.1";

	override function create()
	{
		bgColor = 0xFF000000;

        tile = new FlxTilemap();
        tile.loadMapFromCSV("assets/data/menu.txt", "assets/images/tiles16.png", 16, 16, 0, 1);
		tile.color = 0xFF000000;
		add(tile);

		map = new Menu();
		add(map);

		#if mobileC
		addVirtualPad(UP_DOWN, A_B);
		#end


		player = new BoyfriendRpg();
		add(player);
		FlxG.camera.follow(player);

		super.create();
	}

	override function update(elapsed:Float)
	{
	//FlxG.collide(player, tile);	
	super.update(elapsed);
	}
	
	
}
