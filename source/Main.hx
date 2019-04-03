package;

import flixel.FlxG;
import flixel.FlxGame;
import openfl.display.Sprite;
import flixel.system.scaleModes.FillScaleMode;


class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(1280, 720, MenuState));
		
		// Force fullscreen on Android devices.
		FlxG.scaleMode = new FillScaleMode();

		// Set background color for all states.
		FlxG.cameras.bgColor = 0xFF1F2326;
	}
}
