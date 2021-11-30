package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.graphics.frames.FlxAtlasFrames;

class BoyfriendRpg extends FlxSprite
{
    var speed:Int = 250;
    var tex:FlxAtlasFrames;

	private var controls(get, never):Controls;

	inline function get_controls():Controls
		return PlayerSettings.player1.controls;
    
    public function new(xPos:Int = 0, yPos:Int = 0) {
        super(xPos, xPos);
        tex = Paths.getSparrowAtlas('boyfriendrpg');
        frames = tex;
        animation.addByPrefix('UP', 'boyfriend_up', 24, false);
        animation.addByPrefix('DOWN', 'boyfriend_down', 24, false);
        animation.addByPrefix('LEFT', 'boyfriend_left', 24, false);
        animation.addByPrefix('RIGHT', 'boyfriend_right', 24, false); 
        setGraphicSize(Std.int(width * 0.3));   
        drag.x = speed * 4;
        drag.y = speed * 4;

        animation.play("DOWN");
    }
    function movement(){
        var upP = controls.UP;
        var downP = controls.DOWN;
        var leftP = controls.LEFT;
        var rightP = controls.RIGHT;
    
        var upR = controls.UP_R;
        var downR = controls.DOWN_R;
        var leftR = controls.LEFT_R;
        var rightR = controls.RIGHT_R;

        if (upP && downP && !MainMenuState.inCutscene){
            velocity.y = 0;
        } 
        if (upP && leftP || downP && leftP && !MainMenuState.inCutscene){
            animation.play("LEFT");
        }  
        if (upP && leftP || downP && leftP && !MainMenuState.inCutscene){
            animation.play("RIGHT");
        }                     
        else if (upP && !MainMenuState.inCutscene){
            animation.play("UP");
            velocity.y = - speed;
            flipX = false;
        }
        else if (downP && !MainMenuState.inCutscene){
            animation.play("DOWN");
            velocity.y = speed;
            flipX = false;
        } 

        if (leftP && rightP && !MainMenuState.inCutscene){
            velocity.x = 0;
        }   
        else if (rightP && !MainMenuState.inCutscene){
            animation.play("RIGHT");
            velocity.x = speed;
        }
        else if (leftP && !MainMenuState.inCutscene){
            animation.play("LEFT");
            velocity.x = - speed;
        } 
    }
    override public function update(elapsed:Float):Void {
        super.update(elapsed);
        movement();
    }
}