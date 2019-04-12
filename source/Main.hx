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
		
		#if mobile
		// Force fullscreen on mobile devices.
		FlxG.scaleMode = new FillScaleMode();
		#end
	}
}
