package rpg;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class RpgDialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;

	var handSelect:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		box = new FlxSprite(-20, 45);
		var hasDialog = true;
		box.loadGraphic("assets/images/undertale_box.png");
		box.y += 470;

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;
		
		portraitLeft = new FlxSprite(-20, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait', 'week6');
		portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
	//	portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
	//	add(portraitLeft);
		portraitLeft.visible = false;

		portraitRight = new FlxSprite(0, 40);
		portraitRight.frames = Paths.getSparrowAtlas('weeb/bfPortrait', 'week6');
		portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
	//	portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
	//	add(portraitRight);
		portraitRight.visible = false;
		
		//box.animation.play('normalOpen');
		//box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);
		portraitLeft.screenCenter(X);

		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox', 'week6'));
	//	add(handSelect);


		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(402, 542, Std.int(FlxG.width * 0.6), "", 16);
		dropText.setFormat(("assets/pixel.otf"), 30, LEFT, FlxTextBorderStyle.NONE);
	//	dropText.font = 'Pixel Arial 11 Bold';
		dropText.color = 0xFFFFFFFF;
		add(dropText);

		swagDialogue = new FlxTypeText(402, 540, Std.int(FlxG.width * 0.6), "", 16);
		//swagDialogue.font = 'Pixel Arial 11 Bold';
		swagDialogue.setFormat(("assets/pixel.otf"), 30, LEFT, FlxTextBorderStyle.NONE);
	//	swagDialogue.setFormat(("assets/vcr.ttf"));
		swagDialogue.color = 0xFFFFFFFF;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText', 'shared'), 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
	/*	// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		} */

		dropText.text = swagDialogue.text;

		new FlxTimer().start(0.3, function(tmr:FlxTimer)
			{
				dialogueOpened = true;
			});

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}
		#if mobile
		var justTouched:Bool = false;

		for (touch in FlxG.touches.list)
		{
			justTouched = false;
			
			if (touch.justReleased){
				justTouched = true;
			}
		}
		#end

		if (FlxG.keys.justPressed.ANY #if mobile || justTouched #end && dialogueStarted == true)
		{
			remove(dialogue);


			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			case 'dad':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'bf':
				portraitLeft.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
			case 'none':
				portraitLeft.visible = false;
				portraitRight.visible = false;	
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
