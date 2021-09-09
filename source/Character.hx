package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import sys.FileSystem;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';
	public var activeSkin:String = 'Swappin';

	public var holdTimer:Float = 0;

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false, ?skin:String = 'Swappin')
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;
		activeSkin = StringTools.replace(skin.toLowerCase(), " ", "-");

		var tex:FlxAtlasFrames;
		antialiasing = true;

		switch (curCharacter)
		{
			case 'gf':
				tex = findPath("BF_Boombox");
				frames = tex;

				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				switch(activeSkin)
				{
					default: 
						animation.addByIndices('singLEFT', 'GF Dancing Beat', [0], "", 24, false);
						animation.addByIndices('singRIGHT', 'GF Dancing Beat', [0], "", 24, false);
						animation.addByIndices('singUP', 'GF Dancing Beat', [0], "", 24, false);
						animation.addByIndices('singDOWN', 'GF Dancing Beat', [0], "", 24, false);

						addOffset('cheer', -2, -9);
						addOffset('hairBlow', 0, -6);
					case 'funkin':
						animation.addByPrefix('singLEFT', 'GF left note', 24, false);
						animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
						animation.addByPrefix('singUP', 'GF Up Note', 24, false);
						animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);

						addOffset('cheer');
						addOffset('hairBlow', 45, -8);
				}
				
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset('hairFall', 0, -9);
				addOffset('scared', -2, -17);

				playAnim('danceRight');

			case 'gf-hat':
				tex = Paths.getSparrowAtlas('characters/tutorial_boombox');
				frames = tex;
				animation.addByIndices('singUP', 'GF Dancing Beat instance 1', [0], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat instance 1', [29, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat instance 1', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				addOffset('danceLeft', 0, -200);
				addOffset('danceRight', 0, -200);
			
				playAnim('danceRight');

			case 'gf-christmas':
				tex = findPath('gfChristmas');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');

			case 'steve':

				tex = Paths.getSparrowAtlas('characters/Steve');
				frames = tex;
				
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByIndices('singLEFT', 'GF Dancing Beat', [0], "", 24, false);
				animation.addByIndices('singRIGHT', 'GF Dancing Beat', [0], "", 24, false);
				animation.addByIndices('singUP', 'GF Dancing Beat', [0], "", 24, false);
				animation.addByIndices('singDOWN', 'GF Dancing Beat', [0], "", 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);

				addOffset('cheer', -2, -4);
				addOffset('sad', -2, -4);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset('hairBlow', 0, -9);
				addOffset('hairFall', 0, -9);

				playAnim('danceRight');

			case 'gf-car':
				tex = findPath('Gf_Car');
				frames = tex;
				animation.addByIndices('singUP', 'GF Dancing Beat Hair blowing', [0], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat Hair blowing', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat Hair blowing', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24,
					false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);

				playAnim('danceRight');

			case 'gf-pixel':
				tex = findPath('gfPixel');
				frames = tex;
				animation.addByIndices('singUP', 'GF IDLE', [2], "", 24, false);
				animation.addByIndices('danceLeft', 'GF IDLE', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF IDLE', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);

				playAnim('danceRight');

				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				updateHitbox();
				antialiasing = false;

			case 'gf-tut':
				tex = Paths.getSparrowAtlas('characters/Tutorial');
				frames = tex;

				animation.addByPrefix('idle', "Idle Dance", 24, false);
				animation.addByPrefix('singUP', "Up note", 24, false);
				animation.addByPrefix('singDOWN', "Down Note", 24, false);
				animation.addByPrefix('singLEFT', 'Left Note', 24, false);
				animation.addByPrefix('singRIGHT', 'Right note', 24, false);

				addOffset('idle');
				addOffset('singUP', 8, 25);
				addOffset('singDOWN', -11, -9);
				addOffset('singLEFT', 10);
				addOffset('singRIGHT', -7, -2);

				playAnim('idle');

			case 'dad':
				// DAD ANIMATION LOADING CODE
				tex = findPath('DADDY_DEAREST');
				frames = tex;
				addOffset('idle');

				switch(activeSkin)
				{
					default:
						animation.addByPrefix('idle', 'pump idle', 24);
						animation.addByPrefix('singUP', 'Pump up', 24);
						animation.addByPrefix('singRIGHT', 'Pump right', 24);
						animation.addByPrefix('singDOWN', 'Pump down', 24);
						animation.addByPrefix('singLEFT', 'Pump Left', 24);

						addOffset('singUP', 61, 8);
						addOffset('singRIGHT', 63, 8);
						addOffset('singDOWN', 61, 9);
						addOffset('singLEFT', 57, 8);
					case 'funkin':
						animation.addByPrefix('idle', 'Dad idle dance', 24);
						animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
						animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
						animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
						animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);

						addOffset('singUP', -6, 50);
						addOffset('singRIGHT', 0, 27);
						addOffset('singDOWN', 0, -30);
						addOffset('singLEFT', -10, 10);
				}
				

				playAnim('idle');

			case 'brakenboss':
				tex = findPath('Brake_and_Boss');
				frames = tex;

				animation.addByPrefix('singUP', 'spooky UP NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'spooky DOWN note', 24, false);
				animation.addByPrefix('singLEFT', 'note sing left', 24, false);
				animation.addByPrefix('singRIGHT', 'spooky sing right', 24, false);

				switch(activeSkin)
				{
					default:

						animation.addByIndices('danceLeft', 'spooky dance idle', [5, 4, 3, 2, 1, 0, 2, 4], "", 24, false); //7, 8, 6, 0, 3, 8
						animation.addByIndices('danceRight', 'spooky dance idle', [6, 7, 8, 9, 10, 11, 7], "", 24, false); //7, 7, 8, 9, 10, 14, 15, 17, 18, 19, 20, 21, 22

						addOffset('danceLeft');
						addOffset('danceRight');
		
						addOffset("singUP", -15, -16);
						addOffset("singRIGHT", -69, 11);
						addOffset("singLEFT", -20, -50);
						addOffset("singDOWN", -10, -149);

						setGraphicSize(Std.int(width * 0.8));
						updateHitbox();
					case 'funkin':
						animation.addByIndices('danceLeft', 'spooky dance idle', [0, 2, 6], "", 12, false);
						animation.addByIndices('danceRight', 'spooky dance idle', [8, 10, 12, 14], "", 12, false);

						addOffset('danceLeft');
						addOffset('danceRight');
		
						addOffset("singUP", -20, 26);
						addOffset("singRIGHT", -130, -14);
						addOffset("singLEFT", 130, -10);
						addOffset("singDOWN", -50, -130);
				}

				playAnim('danceRight');
				
			case 'monster-christmas':
				tex = findPath('monsterChristmas');
				frames = tex;
				animation.addByPrefix('idle', 'monster idle', 24, false);
				animation.addByPrefix('singUP', 'monster up note', 24, false);
				animation.addByPrefix('singDOWN', 'monster down', 24, false);
				animation.addByPrefix('singLEFT', 'Monster left note', 24, false);
				animation.addByPrefix('singRIGHT', 'Monster Right note', 24, false);

				addOffset('idle');
				addOffset("singUP", -20, 50);
				addOffset("singRIGHT", -51);
				addOffset("singLEFT", -30);
				addOffset("singDOWN", -40, -94);
				playAnim('idle');

			case 'pico':
				tex = Paths.getSparrowAtlas('characters/Pico_FNF_assetss');
				frames = tex;
				animation.addByPrefix('idle', "Pico Idle Dance", 24);
				animation.addByPrefix('singUP', 'pico Up note0', 24, false);
				animation.addByPrefix('singDOWN', 'Pico Down Note0', 24, false);
				if (isPlayer)
				{
					animation.addByPrefix('singLEFT', 'Pico NOTE LEFT0', 24, false);
					animation.addByPrefix('singRIGHT', 'Pico Note Right0', 24, false);
					animation.addByPrefix('singRIGHTmiss', 'Pico Note Right Miss', 24, false);
					animation.addByPrefix('singLEFTmiss', 'Pico NOTE LEFT miss', 24, false);
				}
				else
				{
					// Need to be flipped! REDO THIS LATER!
					animation.addByPrefix('singLEFT', 'Pico Note Right0', 24, false);
					animation.addByPrefix('singRIGHT', 'Pico NOTE LEFT0', 24, false);
					animation.addByPrefix('singRIGHTmiss', 'Pico NOTE LEFT miss', 24, false);
					animation.addByPrefix('singLEFTmiss', 'Pico Note Right Miss', 24, false);
				}

				animation.addByPrefix('singUPmiss', 'pico Up note miss', 24);
				animation.addByPrefix('singDOWNmiss', 'Pico Down Note MISS', 24);

				addOffset('idle');
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -68, -7);
				addOffset("singLEFT", 65, 9);
				addOffset("singDOWN", 200, -70);
				addOffset("singUPmiss", -19, 67);
				addOffset("singRIGHTmiss", -60, 41);
				addOffset("singLEFTmiss", 62, 64);
				addOffset("singDOWNmiss", 210, -28);

				playAnim('idle');

				flipX = true;

			case 'tankman':
				tex = findPath('Tank');
				frames = tex;

				animation.addByPrefix('idle', "Tank Idle Dance", 24);
				animation.addByPrefix('singUP', 'Tank Up note', 24, false);
				animation.addByPrefix('singDOWN', 'Tank Down Note', 24, false);
				animation.addByPrefix('singLEFT', 'Tank NOTE LEFT', 24, false); 
				animation.addByPrefix('singRIGHT', 'Tank Note Right', 24, false);
				animation.addByPrefix('ugh', 'Ugh', 24, false);
				animation.addByPrefix('ugly', "You're Ugly", 24, false);

				switch(activeSkin)
				{
					default:
						animation.addByPrefix('laugh', 'Laugh', 24, false);

						addOffset('idle');
						addOffset("singUP", 34, -6);
						addOffset("singRIGHT", 37, -16);
						addOffset("singLEFT", 33, -45);
						addOffset("singDOWN", 63, -134);
						addOffset('ugh', -17, -7);
						addOffset('laugh', 1, -7);
						addOffset('ugly', 3, -2);
					case 'funkin':						
						addOffset('idle');
						addOffset("singUP", -69, -7);
						addOffset("singRIGHT", -32, 19);
						addOffset("singLEFT", -37, 14);
						addOffset("singDOWN", -27, -109);
						addOffset('ugh', -45, -7);
						addOffset('ugly', -122, -32);
						flipX = true;
				}

				/*trace('assets/shared/images/skins/' + curCharacter + '/' + StringTools.replace(activeSkin.toLowerCase(), " ", "-") + '-offsets');
				var offsetTxt:Array<String> = CoolUtil.coolTextFile('assets/shared/images/skins/' + curCharacter + '/' + StringTools.replace(activeSkin.toLowerCase(), " ", "-") + '-offsets.txt');
				trace(offsetTxt);
				var animations:Array<String> = [];
				var offsetX:Array<Float> = [];
				var offsetY:Array<Float> = [];
				for(i in offsetTxt)
				{
					var amog:Array<String> = i.split(":");
					animations.push(amog[0]);
					offsetX.push(Std.parseFloat(amog[1]));
					offsetY.push(Std.parseFloat(amog[2]));
				}

				for (i in 0...animations.length)
				{
					addOffset(animations[i], offsetX[i], offsetY[i]);
				}*/
				setGraphicSize(Std.int(width * 0.8));
				updateHitbox();

				playAnim('idle');

			case 'bf':
				var tex = findPath("BOYFRIEND");
				frames = tex;	
				trace(tex.frames.length);
				switch (activeSkin)
				{
					
					case 'funkin':
						animation.addByPrefix('idle', 'BF idle dance', 24, false);
						animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
						animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
						animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
						animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
						animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
						animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
						animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
						animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
						animation.addByPrefix('hey', 'BF HEY', 24, false);

						animation.addByPrefix('firstDeath', "BF dies", 24, false);
						animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
						animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

						animation.addByPrefix('scared', 'BF idle shaking', 24);

						addOffset('idle', -5);
						addOffset("singUP", -29, 27);
						addOffset("singRIGHT", -38, -7);
						addOffset("singLEFT", 12, -6);
						addOffset("singDOWN", -20, -47);
						addOffset("singUPmiss", -29, 27);
						addOffset("singRIGHTmiss", -30, 24);
						addOffset("singLEFTmiss", 16, 24);
						addOffset("singDOWNmiss", -11, -19);
						addOffset("hey", -6, 4);
						addOffset('firstDeath', 37, 11);
						addOffset('deathLoop', 37, 5);
						addOffset('deathConfirm', 37, 69);
						addOffset('scared', -4);

					default:
						animation.addByPrefix('idle', 'BF idle dance', 24, false);
						animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
						animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
						animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
						animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
						animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
						animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
						animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
						animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
						animation.addByPrefix('hey', 'BF HEY!!', 24, false);

						animation.addByPrefix('scared', 'BF idle shaking', 24);

						addOffset('idle', -5);
						addOffset("singUP", -40, 23);
						addOffset("singRIGHT", -53, -6);
						addOffset("singLEFT", 0, -6);
						addOffset("singDOWN", -23, -45);
						addOffset("singUPmiss", -38, 20);
						addOffset("singRIGHTmiss", -43, 30);
						addOffset("singLEFTmiss", 11, 20);
						addOffset("singDOWNmiss", -35, -17);
						addOffset("hey", -7, 5);
						addOffset('scared', -5, 2);
				}

					playAnim('idle');

					flipX = true;
			
			case 'bf-dead':
				var tex = Paths.getSparrowAtlas('characters/Death_Anim');
				frames = tex;
				animation.addByPrefix('singUP', "BF dies", 24, false);
				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);
				animation.play('firstDeath');

				addOffset('firstDeath', 0, 310);
				addOffset('deathLoop', -14, -12);
				addOffset('deathConfirm', -5, 60);
				playAnim('firstDeath');

				flipX = true;

			case 'bf-christmas':
				var tex = findPath('bfChristmas');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);

				playAnim('idle');

				flipX = true;

			case 'bf-pixel':
				frames = findPath('bfPixel');
				animation.addByPrefix('idle', 'BF IDLE', 24, false);
				animation.addByPrefix('singUP', 'BF UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'BF LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'BF RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'BF DOWN NOTE', 24, false);
				animation.addByPrefix('singUPmiss', 'BF UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF DOWN MISS', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				addOffset("singUPmiss");
				addOffset("singRIGHTmiss");
				addOffset("singLEFTmiss");
				addOffset("singDOWNmiss");

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				width -= 100;
				height -= 100;

				antialiasing = false;

				flipX = true;
			case 'bf-pixel-dead':
				frames = Paths.getSparrowAtlas('characters/bfPixelsDEAD');
				animation.addByPrefix('singUP', "BF Dies pixel", 24, false);
				animation.addByPrefix('firstDeath', "BF Dies pixel", 24, false);
				animation.addByPrefix('deathLoop', "Retry Loop", 24, true);
				animation.addByPrefix('deathConfirm', "RETRY CONFIRM", 24, false);
				animation.play('firstDeath');

				addOffset('firstDeath');
				addOffset('deathLoop', -37);
				addOffset('deathConfirm', -37);
				playAnim('firstDeath');
				// pixel bullshit
				setGraphicSize(Std.int(width * 6));
				updateHitbox();
				antialiasing = false;
				flipX = true;

			case 'bf-extra':
				var tex = Paths.getSparrowAtlas('characters/BoyFriend_Assets', 'shared');
				frames = tex;

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY!!', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);
				animation.addByPrefix('charge', 'boyfriend pre attack', 24, true);
				animation.addByPrefix('attack', 'boyfriend attack', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -33, 24);
				addOffset("singRIGHT", -59, 17);
				addOffset("singLEFT", -8, 13);
				addOffset("singDOWN", -29, -24);
				addOffset("singUPmiss", -44, 34);
				addOffset("singRIGHTmiss", -41, 17);
				addOffset("singLEFTmiss", -8, 13); 
				addOffset("singDOWNmiss", -20, -19);
				addOffset("hey", -5, 7);
				addOffset('firstDeath', 33, 6);
				addOffset('deathLoop', 25, 1);
				addOffset('deathConfirm', 34, 64); 
				addOffset('charge', 139, -32);
				addOffset('scared', -12, -3);
				addOffset('attack', 305, 307); 

				playAnim('idle');

				flipX = true;

			/* case 'senpai':
				frames = findPath('senpai');
				animation.addByPrefix('idle', 'Senpai Idle', 24, false);
				animation.addByPrefix('singUP', 'SENPAI UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'SENPAI LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'SENPAI RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'SENPAI DOWN NOTE', 24, false);

				addOffset('idle');
				addOffset("singUP", 5, 37);
				addOffset("singRIGHT");
				addOffset("singLEFT", 40);
				addOffset("singDOWN", 14);

				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false; */
			case 'yandere':
				frames = findPath('yandere');

				switch(activeSkin)
				{
					default:
						animation.addByPrefix('idle', 'Angry Senpai Idle', 24, false);
						animation.addByPrefix('singUP', 'Angry Senpai UP NOTE', 24, false);
						animation.addByPrefix('singLEFT', 'Angry Senpai LEFT NOTE', 24, false);
						animation.addByPrefix('singRIGHT', 'Angry Senpai RIGHT NOTE', 24, false);
						animation.addByPrefix('singDOWN', 'Angry Senpai DOWN NOTE', 24, false);

						addOffset('idle');
						addOffset("singUP", 0, 37);
						addOffset("singRIGHT");
						addOffset("singLEFT", 6, 6);
						addOffset("singDOWN", 6, 6);

						setGraphicSize(Std.int(width * 6));
						updateHitbox();
						antialiasing = false;

					case 'funkin':
						animation.addByPrefix('idle', 'monster idle', 24, false);
						animation.addByPrefix('singUP', 'monster up note', 24, false);
						animation.addByPrefix('singDOWN', 'monster down', 24, false);
						animation.addByPrefix('singLEFT', 'Monster left note', 24, false);
						animation.addByPrefix('singRIGHT', 'Monster Right note', 24, false);

						addOffset('idle');
						addOffset("singUP", -20, 50);
						addOffset("singRIGHT", -51);
						addOffset("singLEFT", -30);
						addOffset("singDOWN", -30, -40);
				}
				playAnim('idle');				

			case 'spirit':
				frames = findPath('spirit');
				animation.addByPrefix('idle', "idle spirit_", 24, false);
				animation.addByPrefix('singUP', "up_", 24, false);
				animation.addByPrefix('singRIGHT', "right_", 24, false);
				animation.addByPrefix('singLEFT', "left_", 24, false);
				animation.addByPrefix('singDOWN', "spirit down_", 24, false);

				addOffset('idle', -220, -280);
				addOffset('singUP', -220, -240);
				addOffset("singRIGHT", -220, -280);
				addOffset("singLEFT", -200, -280);
				addOffset("singDOWN", 170, 110);

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				antialiasing = false;

			case 'parents-christmas':
				frames = findPath('mom_dad_christmas_assets');
				animation.addByPrefix('idle', 'Parent Christmas Idle', 24, false);
				animation.addByPrefix('singUP', 'Parent Up Note Dad', 24, false);
				animation.addByPrefix('singDOWN', 'Parent Down Note Dad', 24, false);
				animation.addByPrefix('singLEFT', 'Parent Left Note Dad', 24, false);
				animation.addByPrefix('singRIGHT', 'Parent Right Note Dad', 24, false);

				animation.addByPrefix('singUP-alt', 'Parent Up Note Mom', 24, false);

				animation.addByPrefix('singDOWN-alt', 'Parent Down Note Mom', 24, false);
				animation.addByPrefix('singLEFT-alt', 'Parent Left Note Mom', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'Parent Right Note Mom', 24, false);

				addOffset('idle');
				addOffset("singUP", -47, 24);
				addOffset("singRIGHT", -1, -23);
				addOffset("singLEFT", -30, 16);
				addOffset("singDOWN", -31, -29);
				addOffset("singUP-alt", -47, 24);
				addOffset("singRIGHT-alt", -1, -24);
				addOffset("singLEFT-alt", -30, 15);
				addOffset("singDOWN-alt", -30, -27);

				playAnim('idle');
		}

		/*trace('skins/' + curCharacter + '/' + StringTools.replace(activeSkin.toLowerCase(), " ", "-"));
		trace(Paths.imageExists('skins/' + curCharacter + '/' + StringTools.replace(activeSkin.toLowerCase(), " ", "-"), "shared"));
		if(Paths.imageExists('skins/' + curCharacter + '/' + StringTools.replace(activeSkin.toLowerCase(), " ", "-"), "shared"))
		{
		}else
		{
			switch(curCharacter)
			{
				case 'bf':
					if(Paths.imageExists('skins/player/' + StringTools.replace(activeSkin.toLowerCase(), " ", "-"), "shared"))
					{
						tex = Paths.getSparrowAtlas('skins/player/' + StringTools.replace(activeSkin.toLowerCase(), " ", "-"), 'shared');
						frames = tex;
					}
				case 'gf':
					if(Paths.imageExists('skins/metronome/' + StringTools.replace(activeSkin.toLowerCase(), " ", "-"), "shared"))
					{
						tex = Paths.getSparrowAtlas('skins/metronome/' + StringTools.replace(activeSkin.toLowerCase(), " ", "-"), 'shared');
						frames = tex;
					}
			}
		}*/

		dance();

		if (isPlayer)
		{
			flipX = !flipX;

			// Doesn't flip for BF, since his are already in the right place???
			if (!curCharacter.startsWith('bf'))
			{
				// var animArray
				var oldRight = animation.getByName('singRIGHT').frames;
				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').frames = oldRight;

				// IF THEY HAVE MISS ANIMATIONS??
				if (animation.getByName('singRIGHTmiss') != null)
				{
					var oldMiss = animation.getByName('singRIGHTmiss').frames;
					animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
					animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}
		}
	}

	override function update(elapsed:Float)
	{
		if (!curCharacter.startsWith('bf'))
		{
			if (animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}

			var dadVar:Float = 4;

			if (curCharacter == 'dad')
				dadVar = 6.1;
			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
			{
				//trace('dance');
				dance();
				holdTimer = 0;
			}
		}

		switch (curCharacter)
		{
			case 'gf':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
					playAnim('danceRight');
			case 'steve':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished || animation.curAnim.name == 'cheer' && animation.curAnim.finished)
					playAnim('danceRight');
			case 'tankman':
				//if ((animation.curAnim.name == 'laugh' || animation.curAnim.name == 'ugly') && animation.curAnim.finished)
					//playAnim('idle');
		}

		super.update(elapsed);
	}

	private var danced:Bool = false;

	/**
	 * FOR GF DANCING SHIT
	 */
	public function dance()
	{
		if (!debugMode)
		{
			switch (curCharacter)
			{
				case 'gf':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-christmas':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'steve':
					if (!animation.curAnim.name.startsWith('hair') || animation.curAnim.name == 'cheer')
					{
						danced = !danced;
	
						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-car':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}
				case 'gf-pixel':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-hat':
					if (!animation.curAnim.name.startsWith('hair'))
						{
							danced = !danced;
	
							if (danced)
								playAnim('danceRight');
							else
								playAnim('danceLeft');
						}

				case 'brakenboss':
					danced = !danced;

					if (danced)
						playAnim('danceRight');
					else
						playAnim('danceLeft');

				case 'tankman':
					if (animation.curAnim.name == 'laugh' || animation.curAnim.name == 'ugly')
					{
						trace(animation.curAnim.name);
					}
					else
						playAnim('idle');

				default:
					playAnim('idle');
			}
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
		else
			offset.set(0, 0);

		if (curCharacter == 'gf')
		{
			if (AnimName == 'singLEFT')
			{
				danced = true;
			}
			else if (AnimName == 'singRIGHT')
			{
				danced = false;
			}

			if (AnimName == 'singUP' || AnimName == 'singDOWN')
			{
				danced = !danced;
			}
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}

	private function findPath(?fileName:String = 'BOYFRIEND'):FlxAtlasFrames
	{
		var xml;
		if(FileSystem.exists('assets/shared/images/characters/' + activeSkin + '/' + fileName + '.xml'))
		{
			xml = Paths.getSparrowAtlas('characters/' + activeSkin + '/' + fileName, 'shared');
		}
			
		else
			xml = Paths.getSparrowAtlas('characters/swappin/' + fileName, 'shared');
		return xml;
	}
}
