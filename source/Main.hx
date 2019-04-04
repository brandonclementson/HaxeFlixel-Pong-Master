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
		
		#if android
		// Force fullscreen on Android devices.
		FlxG.scaleMode = new FillScaleMode();
		#end
	}
}
