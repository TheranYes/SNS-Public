package;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxG;

class MenuCover extends FlxSprite
{
    public function new(x:Float, y:Float)
    {
        super(x, y);
        antialiasing = true;
    }

    public function setCover(cover:String, scale:Float)
    {
        setGraphicSize(Std.int(width * scale));
		updateHitbox();

        switch(cover)
        {
            case "tutorial":
                loadGraphic(Paths.image('covers/tutorialCover', 'shared'));
            case "pump":
                loadGraphic(Paths.image('covers/pumpCover', 'shared'));
            case "spooky":
                loadGraphic(Paths.image('covers/spookyCover', 'shared'));
            case "philly":
                loadGraphic(Paths.image('covers/phillyCover', 'shared'));
            default:
                if (FlxG.random.bool(5))
                    loadGraphic(Paths.image('covers/unknownCover', 'shared'));
                else
                    loadGraphic(Paths.image('covers/lockedCover', 'shared'));
        }
    }
}