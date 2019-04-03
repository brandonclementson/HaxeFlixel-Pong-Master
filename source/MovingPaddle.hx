package;

import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class MovingPaddle extends Paddle
{
    public function new(positionX:Float, positionY:Float, endPositionY:Float) 
    {
        super(x);

        paddleWidth = 24;
        paddleHeight = 125;

        makeGraphic(paddleWidth, paddleHeight, FlxColor.GRAY);
		setPosition(positionX, positionY);
		FlxTween.tween(this, { y: endPositionY }, 3, { type: PINGPONG });
    }
}