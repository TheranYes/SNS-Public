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
import io.newgrounds.NG;
import lime.app.Application;

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class MainMenuState extends MusicBeatState
{
	var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;

	#if !switch
	var optionShit:Array<String> = ['story mode', 'freeplay', 'credits', 'options'];
	#else
	var optionShit:Array<String> = ['story mode', 'freeplay'];
	#end

	var newGaming:FlxText;
	var newGaming2:FlxText;
	public static var firstStart:Bool = true;

	public static var nightly:String = "(Saturday Build)";

	public static var kadeEngineVer:String = "1.5.2 " + nightly;
	public static var gameVer:String = "0.2.7.1";

	var magenta:FlxSprite;
	var camFollow:FlxObject;
	public static var finishedFunnyMove:Bool = false;

	var logoSHIT:Int = 0;

	var logo:FlxSprite;
	var hotGf:FlxSprite;
	var girlfriend:Character;

	var isHot:Bool = false;

	var randomBack:Array<String> = ['singUPmiss', 'singRIGHTmiss', 'singLEFTmiss', 'singDOWNmiss'];

	override function create()
	{
		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
			FlxG.sound.music.fadeIn(1, 0, 0.7);
		}

		persistentUpdate = persistentDraw = true;

		var bg:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('theMenuBG'));
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.10;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		magenta.scrollFactor.x = 0;
		magenta.scrollFactor.y = 0.10;
		magenta.setGraphicSize(Std.int(magenta.width * 1.1));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = true;
		magenta.color = 0xFFfd719b;
		add(magenta);
		// magenta.scrollFactor.set();

		var blueTri:FlxSprite = new FlxSprite().loadGraphic(Paths.image('daTriangle'));
		blueTri.scrollFactor.set();
		blueTri.antialiasing = true;
		add(blueTri);

		hotGf = new FlxSprite(FlxG.width * 0.57, 200);
		hotGf.frames = Paths.getSparrowAtlas('hot', 'shared');
		hotGf.antialiasing = true;
		hotGf.animation.addByPrefix('idle', 'idle', 24);
		hotGf.animation.addByPrefix('ded', 'ded', 24, false);
		hotGf.animation.play('idle');
		hotGf.setGraphicSize(Std.int(hotGf.width * 0.7));
		hotGf.scrollFactor.set();

		girlfriend = new Character(FlxG.width * 0.65, 300, "bf-extra", true);
		girlfriend.scrollFactor.set();
		girlfriend.playAnim('idle');

		if (FlxG.random.bool(0.1))
		{
			add(hotGf);
			isHot = true;
		}
		else
			add(girlfriend);

		logo = new FlxSprite(FlxG.width * 0.55, 10);
		logo.frames = Paths.getSparrowAtlas('logoBumpin');
		logo.antialiasing = true;
		logo.animation.addByPrefix('bump', 'logo bumpin', 24);
		logo.animation.play('bump');
		logo.scrollFactor.set();
		logo.setGraphicSize(Std.int(logo.width * 0.7));
		logo.updateHitbox();
		add(logo);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var tex = Paths.getSparrowAtlas('FNF_main_menu_assets');

		for (i in 0...optionShit.length)
		{
			var menuItem:FlxSprite = new FlxSprite(25, FlxG.height * 1.5);
			menuItem.frames = tex;
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.setGraphicSize(Std.int(menuItem.width * 0.95));
			menuItem.ID = i;
			menuItems.add(menuItem);
			menuItem.scrollFactor.set();
			menuItem.antialiasing = true;
			if (firstStart)
				FlxTween.tween(menuItem,{y: 60 + (i * 145)},1 + (i * 0.25) ,{ease: FlxEase.expoInOut, onComplete: function(flxTween:FlxTween)
					{ 
						finishedFunnyMove = true; 
						changeItem();
					}});
			else
				menuItem.y = 60 + (i * 145);
		}

		firstStart = false;

		FlxG.camera.follow(camFollow, null, 0.60 * (60 / FlxG.save.data.fpsCap));

		var versionShit:FlxText = new FlxText(5, FlxG.height - 18, 0, gameVer +  (Main.watermarks ? " FNF - " + kadeEngineVer + " Kade Engine" : ""), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		// NG.core.calls.event.logEvent('swag').send();


		if (FlxG.save.data.dfjk)
			controls.setKeyboardScheme(KeyboardScheme.Solo, true);
		else
			controls.setKeyboardScheme(KeyboardScheme.Duo(true), true);

		changeItem();

		/*#if debug
		FlxG.save.data.character = 0;
		#end*/

		super.create();
		Conductor.changeBPM(102);
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{

		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if (!selectedSomethin)
		{
			if (controls.UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (controls.DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK)
			{
				var missAnim = FlxG.random.int(0, randomBack.length - 1);
				girlfriend.playAnim(randomBack[missAnim]);

				FlxG.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
				if (isHot)
					{
						hotGf.animation.play('ded');
						FlxTween.tween(hotGf, {alpha: 0}, 1, {ease: FlxEase.quadOut});
					}
					
				else
					girlfriend.playAnim('hey', true);

				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('confirmMenu'));
				
				if (FlxG.save.data.flashing)
					FlxFlicker.flicker(magenta, 1.1, 0.15, false);

				if (optionShit[curSelected] == 'story mode')
				{
					if (!isHot)
					{
						girlfriend.playAnim('charge', true);

						new FlxTimer().start(0.5, function(tmr:FlxTimer)
						{
							girlfriend.playAnim('attack', true);
						});
					}
					
				}
				else if (optionShit[curSelected] == 'credits')
				{
					FlxG.sound.music.fadeOut(1, 0, function(urMom:FlxTween)
					{
						FlxG.sound.music.stop();
					});
				}

				menuItems.forEach(function(spr:FlxSprite)
				{
					if (curSelected != spr.ID)
					{
						FlxTween.tween(spr, {alpha: 0}, 1.3, {
							ease: FlxEase.quadOut,
							onComplete: function(twn:FlxTween)
							{
								spr.kill();
							}
						});
					}
					else
					{
						if (FlxG.save.data.flashing)
						{
							FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
							{
								goToState();
							});
						}
						else
						{
							new FlxTimer().start(1, function(tmr:FlxTimer)
							{
								goToState();
							});
						}
					}
				});
			}
		}

		super.update(elapsed);

		/*menuItems.forEach(function(spr:FlxSprite)
		{
			spr.screenCenter(X);
		});*/
	}
	
	function goToState()
	{
		var daChoice:String = optionShit[curSelected];

		switch (daChoice)
		{
			case 'story mode':
				FlxG.switchState(new StoryMenuState());
			case 'freeplay':
				FlxG.switchState(new FreeplayState());
			case 'credits':
				FlxG.switchState(new CreditsMenu());
			case 'options':
				FlxG.switchState(new OptionsMenu());
		}
	}

	function changeItem(huh:Int = 0)
	{
		if (finishedFunnyMove)
		{
			curSelected += huh;

			if (curSelected >= menuItems.length)
				curSelected = 0;
			if (curSelected < 0)
				curSelected = menuItems.length - 1;
		}
		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');

			if (spr.ID == curSelected && finishedFunnyMove)
			{
				spr.animation.play('selected');
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);
			}

			spr.updateHitbox();
		});
	}

	override function beatHit()
	{
		super.beatHit();
	
		if (FlxG.save.data.bump)
		{
			FlxTween.tween(FlxG.camera, {zoom:1.01}, 0.3, {ease: FlxEase.quadOut, type: BACKWARD});
		}
	
		FlxG.log.add(curBeat);

		if (!isHot)
		{
			if(girlfriend.animation.curAnim.name == 'idle')
				girlfriend.playAnim('idle', true);
		}
	
		logoSHIT++;
		if (logoSHIT > 1) {
			logoSHIT = 0;
			logo.animation.play('bump', true);
		}
	}
}
