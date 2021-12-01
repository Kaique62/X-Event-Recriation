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
import rpg.RpgDialogueBox;

using StringTools;

class MainMenuState extends MusicBeatState
{
	var player:BoyfriendRpg;
	var tile:FlxTilemap;
	var map:Menu;
	var storyMode:FlxSprite;
	var freeplay:FlxSprite;
	var options:FlxSprite;

	var cam:FlxCamera;

	public static var inCutscene:Bool = false;

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
		addVirtualPad(FULL, A_B);
		#end


		player = new BoyfriendRpg();
		add(player);
		FlxG.camera.follow(player);

		storyMode = new FlxSprite(650, 240);
		storyMode.visible = false;
		storyMode.color = 0xFF008000;
		add(storyMode);

		freeplay = new FlxSprite(200, 240);
		freeplay.visible = false;
		freeplay.color = 0xFF008000;
		add(freeplay);

		options = new FlxSprite(900, 240);
		options.visible = false;
		options.color = 0xFF008000;
		add(options);

		super.create();
	}
	function chooseStoryMode(player:FlxSprite, storyMode:FlxSprite):Void {
		if (player.exists && storyMode.exists && controls.ACCEPT && !inCutscene){
			var dialogue:Array<String> = [':none: The light blinds you'];
		    var doof = new RpgDialogueBox(false, dialogue);
			doof.finishThing = goToStoryMode;
			doof.scrollFactor.set();
			addDialogueBox(doof);
		}
	}
	function chooseFreePlay(player:FlxSprite, freeplay:FlxSprite):Void {
		if (player.exists && freeplay.exists && controls.ACCEPT){
			
			FlxG.switchState(new FreeplayState());
		}
	}
	function chooseOptions(player:FlxSprite, options:FlxSprite):Void {
		if (player.exists && options.exists && controls.ACCEPT){
			
			FlxG.switchState(new OptionsMenu());
		}
	}	
	function addDialogueBox(?dialogueBox:RpgDialogueBox):Void{
	new FlxTimer().start(0.3, function(tmr:FlxTimer)
	  {
		if (dialogueBox != null){
			inCutscene = true;
			add(dialogueBox);
		}
	  });
	}
	function goToStoryMode():Void {
		FlxG.switchState(new StoryMenuState());
		inCutscene = false; 
	}
	override function update(elapsed:Float)
		{
		//FlxG.collide(player, tile);
		FlxG.overlap(player, storyMode, chooseStoryMode);	
		FlxG.overlap(player, freeplay, chooseFreePlay);
		FlxG.overlap(player, options, chooseOptions);	
		super.update(elapsed);
		}		
}
