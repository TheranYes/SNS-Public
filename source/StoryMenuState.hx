package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.math.FlxRect;
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

class StoryMenuState extends MusicBeatState
{
	var scoreText:FlxText;

	var weekData:Array<Dynamic> = [
		['Tutorial'],
		['Roots', 'Stem', 'Carving-Session'],
		['Demon-Dancing', 'Attention'],
		['Roll Out', 'Hawty', "R8 It"],
		['Bones', "Cracked", "Chassis"],
		['Pigs In Blankets', 'Dairy Night', 'Soul'],
		['Pink Lemonade', 'Sour', 'Demonic']
	];
	var curDifficulty:Int = 1;

	public static var weekUnlocked:Array<Bool> = [true, true, true, true, false, false, false];

	var weekNames:Array<String> = [
		"",
		"Pumkernickel\nBonding ",
		"Demon\nDancing",
		"T.A.N.K.E.D",
		"Skid\nSkearest",
		"Cookies\n'n Screams",
		"Lemon\nSweet!"
	];

	var weekCovers:Array<String> = [
		"tutorial",
		"pump",
		"spooky",
		"philly",
		"idk",
		"idkeither",
		"f"
	];

	var txtWeekTitle:FlxText;

	var curWeek:Int = 0;

	var txtTracklist:FlxText;

	var grpWeekText:FlxTypedGroup<MenuItem>;

	var grpLocks:FlxTypedGroup<FlxSprite>;

	var yellowBG:FlxSprite;
	var daCover:MenuCover;
	var bumpCover:Bool;

	var difficultySelectors:FlxGroup;
	var sprDifficulty:FlxSprite;
	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;
	var storyTitle:FlxSprite;
	var bg:FlxSprite;

	override function create()
	{
		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Story Mode Menu", null);
		#end

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		if (FlxG.sound.music != null)
		{
			if (!FlxG.sound.music.playing)
				FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		persistentUpdate = persistentDraw = true;

		daCover = new MenuCover(FlxG.width * 0.5, 100);
		var infoBlack:FlxSprite = new FlxSprite(daCover.x + 20, daCover.y + 50).makeGraphic(600, 480, 0xFF000000);
		infoBlack.alpha = 0.7;

		scoreText = new FlxText(daCover.x + 125, daCover.y + daCover.height + 475, 0, "SCORE: 49324858", 36);
		scoreText.setFormat("VCR OSD Mono", 32, 0xFF4683EB, LEFT);

		txtWeekTitle = new FlxText(daCover.x + daCover.width + 380, daCover.y + 80, 0, "", 32);
		txtWeekTitle.setFormat("VCR OSD Mono", 32, 0xFF95B8F4, LEFT);

		var rankText:FlxText = new FlxText(0, 10);
		rankText.text = 'RANK: GREAT';
		rankText.setFormat(Paths.font("vcr.ttf"), 32);
		rankText.size = scoreText.size;
		rankText.screenCenter(X);

		bg = new FlxSprite().loadGraphic(Paths.image('Story_bg'));
		bg.updateHitbox();
		bg.screenCenter();
		add(bg);
		add(infoBlack);
		add(daCover);

		var ui_tex = Paths.getSparrowAtlas('campaign_menu_UI_assets');
		yellowBG = new FlxSprite(FlxG.width * 0.5, 150).makeGraphic(550, 250, 0xFFFFFFFF);
		yellowBG.alpha = 0;
		//made other shit too dependant on yellowBG FUCK

		var blackSquare:FlxSprite = new FlxSprite(FlxG.width * 0.05, 75).makeGraphic(500, 600, 0xFF000000);
		blackSquare.alpha = 0.7;

		grpWeekText = new FlxTypedGroup<MenuItem>();
		add(blackSquare);
		add(grpWeekText);

		grpLocks = new FlxTypedGroup<FlxSprite>();
		add(grpLocks);

		trace("Line 70");

		for (i in 0...weekData.length)
		{
			var weekThing:MenuItem = new MenuItem(0, yellowBG.y - yellowBG.height - 100, i);
			weekThing.y = ((weekThing.y + 20) * i);
			weekThing.targetY = i;
			grpWeekText.add(weekThing);

			weekThing.x = FlxG.width * 0.1;

			if (i == 0)
				weekThing.x -= 5;

			weekThing.antialiasing = true;
			// weekThing.updateHitbox();

			// Needs an offset thingie
			/*if (!weekUnlocked[i])
			{
				var lock:FlxSprite = new FlxSprite(weekThing.width + 10 + weekThing.x);
				lock.frames = ui_tex;
				lock.animation.addByPrefix('lock', 'lock');
				lock.animation.play('lock');
				lock.ID = i;
				lock.antialiasing = true;
				grpLocks.add(lock);
			}*/
		}

		trace("Line 96");
	
		difficultySelectors = new FlxGroup();
		add(difficultySelectors);

		trace("Line 124");

		leftArrow = new FlxSprite(yellowBG.x + yellowBG.width * 0.125, yellowBG.y + yellowBG.height + 70);
		leftArrow.frames = ui_tex;
		leftArrow.animation.addByPrefix('idle', "arrow left");
		leftArrow.animation.addByPrefix('press', "arrow push left");
		leftArrow.animation.play('idle');
		difficultySelectors.add(leftArrow);

		sprDifficulty = new FlxSprite(leftArrow.x + 130, leftArrow.y);
		sprDifficulty.frames = ui_tex;
		sprDifficulty.animation.addByPrefix('easy', 'EASY');
		sprDifficulty.animation.addByPrefix('normal', 'NORMAL');
		sprDifficulty.animation.addByPrefix('hard', 'HARD');
		sprDifficulty.animation.play('easy');
		changeDifficulty();

		difficultySelectors.add(sprDifficulty);

		rightArrow = new FlxSprite(sprDifficulty.x + sprDifficulty.width + 50, leftArrow.y);
		rightArrow.frames = ui_tex;
		rightArrow.animation.addByPrefix('idle', 'arrow right');
		rightArrow.animation.addByPrefix('press', "arrow push right", 24, false);
		rightArrow.animation.play('idle');
		difficultySelectors.add(rightArrow);

		trace("Line 150");

		add(yellowBG);

		txtTracklist = new FlxText(0, daCover.y + 140, 250, "Tracks", 32);
		txtTracklist.alignment = LEFT;
		txtTracklist.font = rankText.font;
		txtTracklist.color = 0xFF4683EB;
		add(txtTracklist);
		// add(rankText);
		add(scoreText);
		add(txtWeekTitle);

		updateText();


		trace("Line 165");

		super.create();

		changeWeek(0);

		Conductor.changeBPM(102);
	}

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;

		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, 0.5));

		scoreText.text = "Week Score: " + lerpScore;

		txtWeekTitle.text = weekNames[curWeek].toUpperCase();

		FlxG.watch.addQuick('font', scoreText.font);

		difficultySelectors.visible = weekUnlocked[curWeek];

		scoreText.visible = weekUnlocked[curWeek];

		grpLocks.forEach(function(lock:FlxSprite)
		{
			lock.y = grpWeekText.members[lock.ID].y;
		});

		if (!movedBack)
		{
			if (!selectedWeek)
			{
				if (controls.UP_P)
				{
					changeWeek(-1);
				}

				if (controls.DOWN_P)
				{
					changeWeek(1);
				}

				if (controls.RIGHT)
					rightArrow.animation.play('press')
				else
					rightArrow.animation.play('idle');

				if (controls.LEFT)
					leftArrow.animation.play('press');
				else
					leftArrow.animation.play('idle');

				if (controls.RIGHT_P)
					changeDifficulty(1);
				if (controls.LEFT_P)
					changeDifficulty(-1);
			}

			if (controls.ACCEPT)
			{
				selectWeek();
			}
		}

		if (controls.BACK && !movedBack && !selectedWeek)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			movedBack = true;
			FlxG.switchState(new MainMenuState());
		}

		super.update(elapsed);
	}

	var movedBack:Bool = false;
	var selectedWeek:Bool = false;
	var stopspamming:Bool = false;

	function selectWeek()
	{
		if (weekUnlocked[curWeek])
		{
			if (stopspamming == false)
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));

				grpWeekText.members[curWeek].startFlashing();
				stopspamming = true;
			}

			PlayState.storyPlaylist = weekData[curWeek];
			PlayState.isStoryMode = true;
			selectedWeek = true;

			var diffic = "";

			switch (curDifficulty)
			{
				case 0:
					diffic = '-easy';
				case 2:
					diffic = '-hard';
			}

			PlayState.storyDifficulty = curDifficulty;

			if (PlayState.storyPlaylist[0].toLowerCase() == 'tutorial') 
			{
				var penisChance:Int = FlxG.random.int(1, 100);
				if (penisChance <= 5) PlayState.storyPlaylist[0] = 'Penis Music';
			}
			PlayState.SONG = Song.loadFromJson(StringTools.replace(PlayState.storyPlaylist[0]," ", "-").toLowerCase() + diffic, StringTools.replace(PlayState.storyPlaylist[0]," ", "-").toLowerCase());
			PlayState.storyWeek = curWeek;
			PlayState.campaignScore = 0;
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				LoadingState.loadAndSwitchState(new PlayState(), true);
			});
		}
	}

	function changeDifficulty(change:Int = 0):Void
	{
		curDifficulty += change;

		if (curDifficulty < 0)
			curDifficulty = 2;
		if (curDifficulty > 2)
			curDifficulty = 0;

		sprDifficulty.offset.x = 0;

		switch (curDifficulty)
		{
			case 0:
				sprDifficulty.animation.play('easy');
				sprDifficulty.offset.x = 20;
			case 1:
				sprDifficulty.animation.play('normal');
				sprDifficulty.offset.x = 70;
			case 2:
				sprDifficulty.animation.play('hard');
				sprDifficulty.offset.x = 20;
		}

		sprDifficulty.alpha = 0;

		// USING THESE WEIRD VALUES SO THAT IT DOESNT FLOAT UP
		sprDifficulty.y = leftArrow.y - 15;
		intendedScore = Highscore.getWeekScore(curWeek, curDifficulty);

		#if !switch
		intendedScore = Highscore.getWeekScore(curWeek, curDifficulty);
		#end

		FlxTween.tween(sprDifficulty, {y: leftArrow.y + 15, alpha: 1}, 0.07);
	}

	var lerpScore:Int = 0;
	var intendedScore:Int = 0;

	function changeWeek(change:Int = 0):Void
	{
		curWeek += change;

		if (curWeek >= weekData.length)
			curWeek = 0;
		if (curWeek < 0)
			curWeek = weekData.length - 1;

		var bullShit:Int = 0;

		for (item in grpWeekText.members)
		{
			item.targetY = bullShit - curWeek;
			if (item.targetY == Std.int(0))
				item.alpha = 1;
			else
			{	
				if (item.targetY < 4 && item.targetY > 0)
					item.alpha = 0.6;
				else
					FlxTween.tween(item, {alpha: 0}, 0.07);
			}
				
			bullShit++;
		}

		FlxG.sound.play(Paths.sound('scrollMenu'));

		updateText();
	}

	function updateText()
	{
		daCover.setCover(weekCovers[curWeek], 0.45);
		daCover.x = FlxG.width + 400;
		bumpCover = false;

		FlxTween.tween(daCover, {x: FlxG.width * 0.5}, 0.7, {
			ease: FlxEase.quadOut,
			onComplete: function(twn:FlxTween)
			{
				bumpCover = true;
			}});

		txtTracklist.text = "Tracks:\n";
		var stringThing:Array<String> = weekData[curWeek];

		for (i in stringThing)
			txtTracklist.text += "\n" + i;

		txtTracklist.screenCenter(X);
		txtTracklist.x = txtWeekTitle.x;

		txtTracklist.text += "\n";

		#if !switch
		intendedScore = Highscore.getWeekScore(curWeek, curDifficulty);
		#end
	}
}
