package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Paddle extends FlxSprite
{
    private var paddleWidth:Int = 28;
	private var paddleHeight:Int = 160;

    public var paddleSpeed:Int = 450;

    public function new(positionX:Float)
    {
        super();

        makeGraphic(paddleWidth, paddleHeight, FlxColor.WHITE);
        setPosition(positionX, (FlxG.height / 2) - (height / 2));
		immovable = true;
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        checkBoundaries(10);
    }

    public function checkBoundaries(wallHeight:Int)
    {
        if (y <= wallHeight)
			y = wallHeight;

		if (y >= FlxG.height - height - wallHeight)
			y = FlxG.height - height - wallHeight;
    }
}