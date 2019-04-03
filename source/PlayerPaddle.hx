package;

import flixel.FlxG;
import flixel.input.touch.FlxTouchManager;
import flixel.input.touch.FlxTouch;

class PlayerPaddle extends Paddle
{
    public function new(positionX:Float)
    {
        super(x);

        x = positionX;
        paddleSpeed = 500;
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

                velocity.y = 0;
    }

    public function leftPaddleControls(paddle:Paddle)
    {
        if (FlxG.keys.pressed.W)
            velocity.y = -paddleSpeed;

        if (FlxG.keys.pressed.S)
            velocity.y = paddleSpeed;

        #if (mobile || web)
        for (touch in FlxG.touches.list)
        {   
            if (touch.x <= FlxG.width / 2)
            y = touch.y - (height / 2);
        } 
        #end
    }

    public function rightPaddleControls(paddle:Paddle)
    {
        if (FlxG.keys.pressed.UP)
            velocity.y = -paddleSpeed;

        if (FlxG.keys.pressed.DOWN)
            velocity.y = paddleSpeed;


        #if (mobile || web)
        for (touch in FlxG.touches.list)
        {   
            if (touch.x >= FlxG.width / 2)
            y = touch.y - (height / 2);
        } 
        #end
    }
}