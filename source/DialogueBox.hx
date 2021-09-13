package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';
	var curAnim:String = '';
	var orientation:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;
	var skipText:FlxText;

	var skipCounter:Int = 0;

	public var finishThing:Void->Void;

	var portraitBF:Portrait;
	var portraitGF:Portrait;
	var portraitPUMP:Portrait;
	var portraitBNB:Portrait;
	var portraitTANK:Portrait;

	var lastPortrait:Portrait;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		if (PlayState.isStoryMode)
		{
			switch (PlayState.storyWeek)
			{
				default:
					FlxG.sound.playMusic(Paths.music('Lunchbox', 'week6'), 0);
				case 1:
					FlxG.sound.playMusic(Paths.inst("Roots"), 0);
				case 2:
					FlxG.sound.playMusic(Paths.inst("Demon Dancing"), 0);
				case 3:
					FlxG.sound.playMusic(Paths.inst("Roll Out"), 0);
			}

			FlxG.sound.music.fadeIn(1, 0, 0.8);
		}
		

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);
			
			default:
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByPrefix('normal', 'speech bubble normal', 24, true);
				box.y += 320;
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;

		if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'roses' || PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			
			portraitLeft = new FlxSprite(-20, 40);
			portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait', 'week6');
			portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
			portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
			portraitLeft.updateHitbox();
			portraitLeft.scrollFactor.set();
			portraitLeft.visible = false;
		
			portraitRight = new FlxSprite(0, 40);
			portraitRight.frames = Paths.getSparrowAtlas('weeb/bfPortrait', 'week6');
			portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
			portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
			portraitRight.updateHitbox();
			portraitRight.scrollFactor.set();
			portraitRight.visible = false;
	
			handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox', 'week6'));
			add(handSelect);
	
			box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
			portraitLeft.screenCenter(X);

			add(portraitLeft);
			add(portraitRight);
			add(box);
			box.animation.play('normalOpen');
			box.updateHitbox();
			box.screenCenter(X);
		}
		else
		{
			portraitBF = new Portrait(25, 185, "bf"); //fucking disaster of code cry about it B)) (yeah apparently i can only move them after initializing them)
			portraitBF.visible = false;

			portraitGF = new Portrait(0, 175, "gf");
			portraitGF.visible = false;

			portraitPUMP = new Portrait(-50, 145, "pump");
			portraitPUMP.visible = false;

			portraitBNB = new Portrait(50, 0, "bnb");
			portraitBNB.visible = false;

			portraitTANK = new Portrait(50, 0, "tankmen");
			portraitTANK.visible = false;

			add(portraitGF);
			portraitGF.x += 700;
			portraitGF.y -= 115;

			add(portraitBF);
			portraitBF.x += 65;
			portraitBF.y -= 95;

			add(portraitPUMP);
			portraitPUMP.y -= 50;
			portraitPUMP.x += 120;

			add(portraitBNB);
			portraitBNB.y += 100;
			portraitBNB.x += 50;

			add(portraitTANK);
			portraitTANK.y += 100;
			portraitTANK.x += 75;

			add(box);
			box.animation.play('normalOpen');
			box.updateHitbox();
			box.screenCenter(X);
			box.x += 50;
		}

		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(222, 502, Std.int(FlxG.width * 0.6), "", 32);
		if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'roses' || PlayState.SONG.song.toLowerCase() == 'thorns')
			dropText.font = 'Pixel Arial 11 Bold';
		else
			dropText.font = 'SmackAttack BB';
		dropText.color = 0xFFD89494;
		add(dropText);

		swagDialogue = new FlxTypeText(220, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = dropText.font;
		swagDialogue.color = 0xFF3F2021;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);

		skipText = new FlxText(0, 675, 0, "Press Shift to Skip Dialogue", 30);
		skipText.font = dropText.font;
		skipText.alpha = 0.8;
		skipText.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 2);
		skipText.screenCenter(X);
		add(skipText);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (FlxG.keys.justPressed.SHIFT && !isEnding && dialogueStarted)
		{
			isEnding = true;
			endDialogue();
		}

		if (FlxG.keys.justPressed.ANY  && dialogueStarted == true && !FlxG.keys.justPressed.SHIFT)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;
					endDialogue();
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

	function endDialogue():Void
	{
		if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'roses' || PlayState.SONG.song.toLowerCase() == 'thorns')
			{
				new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);
				
				if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
				{
					FlxG.sound.music.fadeOut(2.2, 0);
				}
			}
			
			FlxTween.tween(box, {alpha: 0}, 1.2, {ease: FlxEase.circInOut});
			FlxTween.tween(bgFade, {alpha: 0}, 1.2, {ease: FlxEase.circInOut});
			FlxTween.tween(swagDialogue, {alpha: 0}, 1.2, {ease: FlxEase.circInOut});
			FlxTween.tween(dropText, {alpha: 0}, 1.2, {ease: FlxEase.circInOut});
			FlxTween.tween(skipText, {alpha: 0}, 1.2, {ease: FlxEase.circInOut});
			FlxTween.tween(lastPortrait, {alpha: 0}, 1.2, {ease: FlxEase.circInOut});

			new FlxTimer().start(1.2, function(tmr:FlxTimer)
			{
				finishThing();
				kill();
			});
	}

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		if (skipCounter >= 2)
			FlxTween.tween(skipText, {alpha: 0}, 1.2, {ease: FlxEase.circInOut});
		else
			skipCounter++;

		switch (curCharacter)
		{
			case 'dad':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'boyfriend':
				portraitLeft.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
			case 'bf':
				playChar(portraitBF);
				box.flipX = true;
				changeSound('bf', 0.6);
				changeColour(0xFF4596F9, 0xFF001833);
			case 'gf':
				playChar(portraitGF);
				box.flipX = false;
				changeSound('gf', 0.6);
				changeColour(0xFFED6D82, 0xFF470301);
			case 'pump':
				playChar(portraitPUMP);
				box.flipX = true;
				changeSound('pump', 0.6);
				changeColour(0xFFF9B657, 0xFF562C0C);
			case 'bnb':
				playChar(portraitBNB);
				box.flipX = true;
				changeColour(0xFFBF81C6, 0xFF641436);
				
				if (curAnim.toLowerCase().contains('brake') || curAnim == 'angry')
					changeSound('brake', 0.8);
				else if (curAnim.toLowerCase().contains('boss') || curAnim.contains('bored'))
					changeSound('boss', 0.6);
				else
					changeSound('bnb', 0.6);
			case 'tankmen':
				playChar(portraitTANK);
				box.flipX = true;
				if (curAnim.toLowerCase().contains('steve') || curAnim.contains('simp'))
				{
					trace(swagDialogue.text);
					var volume:Float = 0.5;
					if (dialogueList[0].contains('FUNCTION'))
					{
						volume = 0;
						FlxG.sound.play(Paths.sound('dialogue/how_function'));
					}
					changeSound('steve', volume);
					changeColour(0xFFCE6BC4, 0xFF000000);
				}	
				else
				{
					changeSound('tankman', 0.7);
					changeColour(0xFF73D7B6, 0xFF000000);
				}
					
		}
	}

	function playChar(charShown:Portrait)
	{
		var allPortraits:Array<Portrait> = [portraitBF, portraitGF, portraitPUMP, portraitBNB, portraitTANK];
		allPortraits.remove(charShown);
		for (i in allPortraits)
		{
			i.visible = false;
		}
		if (curAnim == 'hidden')
		{
			charShown.visible = false;
		}
		else
		{
			charShown.visible = true;
			charShown.animation.play(curAnim);
		}
		lastPortrait = charShown;
	}

	function cleanDialog():Void
	{
		/*while(dialogueList[0] == ""){
			dialogueList.remove(dialogueList[0]);
		}
		*/
		
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		curAnim = splitName[2];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + splitName[2].length  + 3).trim();
	}

	function changeSound(sound:String, volume:Float)
	{
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('dialogue/' + sound), volume)];
	}

	function changeColour(?dropColor:FlxColor = 0xFFD89494, ?swagColor:FlxColor = 0xFF3F2021) //british moment
	{
		dropText.color = dropColor;
		swagDialogue.color = swagColor;
	}
}
