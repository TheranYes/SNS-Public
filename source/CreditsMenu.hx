package;

import openfl.display.BitmapData;
import openfl.system.System;
import flixel.util.FlxTimer;
import flixel.math.FlxRandom;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxTween;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.addons.transition.FlxTransitionableState;
#if windows 
import Discord.DiscordClient;
#end 
using StringTools;

//Definetely not copying this from the softmod bc im lazy THANK YOUUUUUU D;

class CreditsMenu extends MusicBeatState
{
	var selector:FlxText;
	var curSelected:Int = 0;

	private var grpSongs:FlxTypedGroup<Alphabet>;
	private var idle:Bool = true;
	
	private var iconArray:Array<CreditIcon> = [];
	private var credits:Array<String> = [];
	private var links:Array<String> = [];

	override function create()
	{
		var creditsList = CoolUtil.coolTextFile(Paths.txt('creditsList'));

		for (i in 0...creditsList.length)
		{
			var data:Array<String> = creditsList[i].split(';'); //had to change it from : bc links have them PFFFFT
			credits.push(data[0]);
			links.push(data[1]);
		}
	
		//FlxG.sound.cache('assets/data/senpai/confirmSound.ogg');

		// Updating Discord Rich Presence 
		#if windows 
		DiscordClient.changePresence("Looking at the Credits", null);
                #end
		FlxG.sound.playMusic(Paths.music("breakfast", 'shared'));
        FlxG.sound.music.fadeIn(1, 0, 0.7);
		
		FlxG.autoPause = false;
	
		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuBGBlue'));
		add(bg);

		selector = new FlxText();

		selector.size = 40;
		selector.text = ">";
		// add(selector);

		grpSongs = new FlxTypedGroup<Alphabet>();
		add(grpSongs);

		for (i in 0...credits.length)
		{
			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, new EReg('_', 'g').replace(new EReg('0', 'g').replace(credits[i], 'O'), ' '), true, false);
			songText.isMenuItem = true;
			songText.targetY = i;

			if(credits[i].contains("~")){
				songText.color = 0xFFDD6A99; //im at my fucking limit choosing ~ as an identifier LMAO
			}
            else if (credits[i].contains('Twitter'))
                songText.color = 0xFFBFE6F7;
			else if (credits[i] != '' && credits[i] != 'sex')
			{
				var icon:CreditIcon = new CreditIcon(StringTools.replace(credits[i], " ", "-").toLowerCase());
				icon.sprTracker = songText;
				iconArray.push(icon);
				add(icon);
			}

			grpSongs.add(songText);

			// songText.x += 40;
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
			//songText.screenCenter(X);
		}

		changeSelection();

		// FlxG.sound.playMusic(Paths.music('title'), 0);
		// FlxG.sound.music.fadeIn(2, 0, 0.8);
		selector = new FlxText();

		selector.size = 40;
		selector.text = ">";
		// add(selector);

		var swag:Alphabet = new Alphabet(1, 0, "swag");

		Conductor.changeBPM(160);
		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		
		if (FlxG.keys.justPressed.F)
		{
		FlxG.fullscreen = !FlxG.fullscreen;
		}

		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		var upP = controls.UP_P;
		var downP = controls.DOWN_P;
		var accepted = controls.ACCEPT;

		if (upP)
		{
			changeSelection(-1);
			idle = false;
		}
		if (downP)
		{
			changeSelection(1);
			idle = false;
		}
		

		if (controls.BACK)
		{
            FlxG.sound.music.fadeOut(0.5, 0, function(urMom:FlxTween)
            {
                FlxG.sound.music.stop();
            });
			FlxG.autoPause = true;
			FlxG.switchState(new MainMenuState());
		}

		if (accepted)
		{
			trace(curSelected);
			if (links[curSelected] != "")
				fancyOpenURL(links[curSelected]);
			else if (credits[curSelected] == "sex")
			{
				PlayState.SONG = Song.loadFromJson("penis-music-hard", "penis-music");
				LoadingState.loadAndSwitchState(new PlayState(), true);
			}
		}
	}

	override function beatHit()
	{
		super.beatHit();

		FlxG.log.add(curBeat);
		if (curBeat % 8 == 0 && idle)
			changeSelection(1);
	}

	function changeSelection(change:Int = 0)
	{

		curSelected += change;

		if (curSelected < 0)
			curSelected = credits.length - 1;
		if (curSelected >= credits.length)
			curSelected = 0;

		var changeTest = curSelected;

		if(credits[curSelected] == "" || credits[curSelected].contains("~") && credits[curSelected] != "Press Enter For Social~"){
			changeSelection(change == 0 ? 1 : change);
		}

		if(changeTest == curSelected){
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		}
		

		var bullShit:Int = 0;

		for (i in 0...iconArray.length)
		{
			

			if (iconArray[i].animation.curAnim.name == StringTools.replace(credits[curSelected], " ", "-").toLowerCase())
				iconArray[i].alpha = 1;
			else
			{
				iconArray[i].alpha = 0.6;
			}
				
		}

		trace(credits[curSelected] + ': text');

		for (item in grpSongs.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}

	}
}
