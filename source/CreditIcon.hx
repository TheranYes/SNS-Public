package;

import flixel.FlxSprite;
import flixel.FlxG;

class CreditIcon extends FlxSprite
{
	/**
	 bitch you though i was going to put effort into this? fuck you B)
	 */
	public var sprTracker:FlxSprite;

	public function new(char:String = 'moxxie', isPlayer:Bool = false)
	{
		super();

		loadGraphic(Paths.image('Credits_icons'), true, 150, 150);

		antialiasing = true;
		animation.add('moxxie', [0], 0, false, isPlayer);
		animation.add('moopy', [1], 0, false, isPlayer);
		animation.add('mori', [2], 0, false, isPlayer);
		animation.add('iflicky', [3], 0, false, isPlayer);
		animation.add('chillinraptor', [4], 0, false, isPlayer);
		animation.add('flan-the-man', [5], 0, false, isPlayer);
		animation.add('sirj445', [6], 0, false, isPlayer);
		animation.add('theran', [7], 0, false, isPlayer);
		animation.add('koharu', [8], 0, false, isPlayer);
		animation.add('commanderwasp', [9], 0, false, isPlayer);
		animation.add('camron-the-macamroon', [10], 0, false, isPlayer);
		animation.add('recd', [11], 0, false, isPlayer);
		animation.add('daniyt', [12], 0, false, isPlayer);
		animation.add('danvoltz', [13], 0, false, isPlayer);
		animation.add('xsddinox', [14], 0, false, isPlayer);
		animation.add('dusty', [15], 0, false, isPlayer);
		animation.add('fuego', [16], 0, false, isPlayer);
		animation.play(char);

		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}
