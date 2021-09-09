package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class Portrait extends FlxSprite
{
    private var characters:Array<String> = ["bf", "pump", "gf", "bnb", "tankmen"];

    public function new(_x:Float, _y:Float, _character:String)
    {
        super(_x, _y);
        defineCharacter(_character);
    }

    function defineCharacter(_character)
    {
        _character = characters.contains(_character) ? _character : 'gf';

        frames = Paths.getSparrowAtlas('portraits/' + _character, 'shared');

        switch(_character)
        {
            case "bf":
                animation.addByPrefix("default", "Default", 0, false);
                animation.addByPrefix("angry", "Angry", 0, false);
                animation.addByPrefix("blush", "Blush", 0, false);
                animation.addByPrefix("embarrased", "Embarrased", 0, false);
                animation.addByPrefix("exclaim", "Exclaim", 0, false);
                animation.addByPrefix("question", "Question", 0, false);
                animation.addByPrefix("really", "Really", 0, false);
                animation.addByPrefix("really2", "Really 2", 0, false);
                animation.addByPrefix("sad", "Sad", 0, false);
                animation.addByPrefix("uh", "Uh", 0, false);
                animation.addByPrefix("sigh", "sigh", 0, false);
                animation.play("default");
            
            case "gf":
                flipX = false;
                animation.addByPrefix("default", "Default", 0, false);
                animation.addByPrefix("eh", "Eh", 0, false);
                animation.addByPrefix("hide", "Hide?", 0, false);
                animation.addByPrefix("itsFine", "Its Fine", 0, false);
                animation.addByPrefix("letsGo", "Lets Go", 0, false);
                animation.addByPrefix("meh", "Meh", 0, false);
                animation.addByPrefix("question", "Question", 0, false);
                animation.addByPrefix("smug", "Smug", 0, false);
                animation.addByPrefix("squish", "Squish", 0, false);
                animation.addByPrefix("squishTalk", "Squish Talk", 24, false);
                animation.addByPrefix("stupid", "Stupid", 0, false);
                animation.addByPrefix("swag", "Swag", 0, false);
                animation.addByPrefix("wannaTalk", "Wanna talk", 0, false);
                animation.addByPrefix("wtf", "Wtf", 0, false);
                animation.play('default');
            
            case "pump":
                animation.addByPrefix("default", "Default", 0, false);
                animation.addByPrefix("happy", "Happy", 0, false);
                animation.addByPrefix("question", "Question", 0, false);
                animation.play('default');
            
            case "bnb":
                animation.addByPrefix("angry", "Angy", 0, false);
                animation.addByPrefix("bothAngry", "Angy Duo", 0, false);
                animation.addByPrefix("bored", "Bored", 0, false);
                animation.addByPrefix("defaultBoss", "Boss Default", 0, false);
                animation.addByPrefix("defaultBrake", "Brake Default", 0, false);
                animation.addByPrefix("lose", "Lose", 0, false);
                animation.addByPrefix("talkBoss", "Talk Boss", 0, false);
                animation.addByPrefix("talkBrake", "Talk Brake", 0, false);
                animation.play('defaultBoss');
            
            case "tankmen":
                animation.addByPrefix("annoy", "Annoy", 0, false);
                animation.addByPrefix("defaultHelm", "Default Helm", 0, false);
                animation.addByPrefix("default", "Default instance", 0, false);
                animation.addByPrefix("edgy", "Edgey", 0, false);
                animation.addByPrefix("giveBirth", "Giving birth", 0, false); //dont worry its not tankman giving birth trust me
                animation.addByPrefix("simpBait", "Simp bait", 0, false);
                animation.addByPrefix("steveDefault", "Steve Default", 0, false);
                animation.addByPrefix("steveFunction", "Steve Function", 0, false);
                animation.addByPrefix("talk", "Talk", 0, false);
                animation.addByPrefix("meh", "meh", 0, false);
                animation.addByPrefix("steveSweat", "steve sweat", 0, false);
                animation.addByPrefix("ugh", "ugh", 0, false);
                animation.play('default');
        }
    }
}