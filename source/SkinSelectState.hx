package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.effects.FlxFlicker;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.net.curl.CURLCode;

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class SkinSelectState extends MusicBeatState
{

    public var skinList:Array<String> = CoolUtil.coolTextFile("assets/data/skinList.txt");

    var curSkin:Int = 0;

    var coolUI:FlxGroup;
    var rightArrow:FlxSprite;
    var leftArrow:FlxSprite;
    var upperTrap:FlxSprite;
    var lowerTrap:FlxSprite;

    var epicCheckmark:FlxSprite;

    var bg: FlxSprite;
    var magenta:FlxSprite;

    var title:Alphabet;
    var themeName:Alphabet;
    

    var bfGroup:FlxTypedGroup<Character>;
    var gfGroup:FlxTypedGroup<Character>;

    var loading:Bool = true;

    override function create()
    {
        #if windows
        DiscordClient.changePresence("Selecting a Skin", null);
        #end

        transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		if (FlxG.sound.music != null)
		{
			if (!FlxG.sound.music.playing)
				FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		persistentUpdate = persistentDraw = true;

        if (FlxG.save.data.activeSkin == null) 
            FlxG.save.data.activeSkin = 0;

        bg = new FlxSprite().loadGraphic(Paths.image('theMenuBG'));
        bg.updateHitbox();
        bg.screenCenter();
        bg.antialiasing = true;
        add(bg);

        magenta = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = true;
		magenta.color = 0xFFfd719b;
		add(magenta);

        gfGroup = new FlxTypedGroup<Character>();
        add(gfGroup);

        bfGroup = new FlxTypedGroup<Character>();
        add(bfGroup);

        for (i in 0...skinList.length)
        {
            var gfPreview = new Character(240, FlxG.height * 0.5 - 400, "gf", false, skinList[i]);
            gfPreview.setGraphicSize(Std.int(gfPreview.width * 0.85));
            gfPreview.updateHitbox();
            gfPreview.visible = false;
            gfPreview.ID = i;

            if (skinList[i] == skinList[FlxG.save.data.activeSkin])
                gfPreview.visible = true;

            gfGroup.add(gfPreview);
        }

        for (i in 0...skinList.length)
        {
            var bfPreview = new Character(540, FlxG.height * 0.5 - 150, "bf", true, skinList[i]);
            bfPreview.setGraphicSize(Std.int(bfPreview.width * 0.85));
            bfPreview.updateHitbox();  //SNS gf is bfPreview because I WANT TO OK???
            bfPreview.visible = false;
            bfPreview.ID = i;

            if (skinList[i] == skinList[FlxG.save.data.activeSkin])
                bfPreview.visible = true;

            bfGroup.add(bfPreview);
            trace(skinList[i]);
        }

        coolUI = new FlxGroup();
        add(coolUI);

        var tex = Paths.getSparrowAtlas('skinselect/skinMenu_assets');

        rightArrow = new FlxSprite(FlxG.width - 75);
        rightArrow.frames = tex;
        rightArrow.animation.addByPrefix('idle', 'Arrow idle');
        rightArrow.animation.addByPrefix('press', 'Arrow Press');
        rightArrow.animation.play('idle');
        rightArrow.screenCenter(Y);
        rightArrow.flipX = true;
        coolUI.add(rightArrow);

        leftArrow = new FlxSprite(20);
        leftArrow.frames = tex;
        leftArrow.animation.addByPrefix('idle', 'Arrow idle');
        leftArrow.animation.addByPrefix('press', 'Arrow Press');
        leftArrow.animation.play('idle');
        leftArrow.screenCenter(Y);
        coolUI.add(leftArrow);

        upperTrap = new FlxSprite(0, -20).loadGraphic(Paths.image('skinselect/upperTrapezoidtest'));
        upperTrap.screenCenter(X);
        coolUI.add(upperTrap);

        lowerTrap = new FlxSprite(0, FlxG.height * 0.85).loadGraphic(Paths.image('skinselect/lowerTrapezoidtest'));
        lowerTrap.screenCenter(X);
        coolUI.add(lowerTrap);

        title = new Alphabet(0, upperTrap.getGraphicMidpoint().y - 30, "Skin Select", true, false, true);
        title.screenCenter(X);
        add(title);

        themeName = new Alphabet(0, lowerTrap.getGraphicMidpoint().y - 30, skinList[FlxG.save.data.activeSkin], true, false, true);
        themeName.screenCenter(X);
        add(themeName);

        epicCheckmark = new FlxSprite(0, themeName.y - 25);
        epicCheckmark.frames = tex;
        epicCheckmark.animation.addByPrefix('idle', 'Checkmark idle');
        epicCheckmark.animation.addByPrefix('press', 'Checkmark Press');
        epicCheckmark.animation.play('idle');
        epicCheckmark.visible = false;
        add(epicCheckmark);

        curSkin = FlxG.save.data.activeSkin;
        displaySkin(skinList[curSkin]);

        super.create();

		Conductor.changeBPM(102);
    }

    var movedBack:Bool = false;
    var selectedSkin:Bool = false;
    var noSpammingPls:Bool = false;
    

    override function update(elapsed:Float)
    {
            if (!movedBack)
            {
                if (!selectedSkin)
                {
                    if (controls.RIGHT)
                        rightArrow.animation.play('press')
                    else
                        rightArrow.animation.play('idle');
    
                    if (controls.LEFT)
                        leftArrow.animation.play('press');
                    else
                        leftArrow.animation.play('idle');

                    if (controls.RIGHT_P)
                    {
                        browseSkin(1);
                    }

                    if (controls.LEFT_P)
                    {
                        browseSkin(-1);
                    }
                }

                if (controls.ACCEPT)
                {
                    selectSkin();
                    epicCheckmark.animation.play('press');
                }
                else
                {
                    epicCheckmark.animation.play('idle');
                }
            }

        if (controls.BACK && !movedBack)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			movedBack = true;
			FlxG.switchState(new MainMenuState());
		}

		super.update(elapsed);
    }

    function browseSkin(change:Int = 0):Void
    {
        FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

        curSkin += change;

        if (curSkin < 0) curSkin = skinList.length - 1;
        if (curSkin >= skinList.length) curSkin = 0;

        if (change >= 1)
        {
            switchSkin(gfGroup, -500, FlxG.width + 400, 240, true);
            switchSkin(bfGroup, -400, FlxG.width + 200, 540, true);
        }
        else if (change <= -1)
        {
            switchSkin(gfGroup, FlxG.width + 400, -500, 240, false);
            switchSkin(bfGroup, FlxG.width + 200, -400, 540, false);
        }

        displaySkin(skinList[curSkin]);
    }

    function selectSkin()
    {
        FlxG.sound.play(Paths.sound('confirmMenu'));

        selectedSkin = true;

        bfGroup.forEach(function(theBoy:Character)
        {
            if (theBoy.ID == curSkin)
                theBoy.playAnim('hey', true);
        });

        new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			selectedSkin = false;
            /*bfGroup.forEach(function(theBoy:Character)
            {
                if (theBoy.ID == curSkin)
                    theBoy.playAnim('idle');
            });*/
		});

        FlxG.save.data.activeSkin = curSkin;
        trace(FlxG.save.data.activeSkin);

        displaySkin(skinList[FlxG.save.data.activeSkin]);

        // COL EFFET!1!1!!11!11
        if (FlxG.save.data.flashing)
        {
            FlxFlicker.flicker(magenta, 1.5, 0.15, false, false);
            FlxG.camera.flash(FlxColor.WHITE, 1.1);
        }
    }

    function displaySkin(skinName:String):Void
    {   
        remove(themeName);

        themeName = new Alphabet(0, lowerTrap.getGraphicMidpoint().y - 30, skinName, true, false, true);
        themeName.screenCenter(X);
        add(themeName);

        if (themeName.text == skinList[FlxG.save.data.activeSkin])
        {
            epicCheckmark.x = themeName.x + themeName.text.length * 46;
            epicCheckmark.visible = true;
        }
        else epicCheckmark.visible = false;
    }

    function switchSkin(group:FlxTypedGroup<Character>, moveX:Int, newX:Int, targetX:Int, fromRight:Bool)
    {
        var butt:Int;
            
        group.forEach(function(woah:Character)
        {
            if (fromRight)
            {
                butt = woah.ID + 1;
                if (butt >= skinList.length)
                    butt = 0;
            }
            else
            {
                butt = woah.ID - 1;
                if (butt < 0)
                    butt = skinList.length - 1;
            }
            
            if (curSkin == butt)
            {
                woah.visible = true;
                FlxTween.tween(woah, {x: moveX}, 0.5, {ease: FlxEase.quadIn, onComplete: function(flxTween:FlxTween)
                {
                    woah.visible = false;
                }});
            }
            else
            {
                woah.visible = false;
                woah.x = newX;
                new FlxTimer().start(0.5, function(tmr:FlxTimer)
                {
                    if (curSkin == woah.ID)
                    {
                        FlxTween.tween(woah, {x: targetX}, 0.5, {ease: FlxEase.quadOut});
                        woah.visible = true;
                    }
                });
            }
                
        });
    }

    override function beatHit()
    {
        super.beatHit();

        gfGroup.forEach(function(gf:Character)
        {
            gf.dance();
        });

        if (!selectedSkin)
        {
            bfGroup.forEach(function(bf:Character)
            {
                bf.playAnim('idle', true);
            });
        }

    }
}