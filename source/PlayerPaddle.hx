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

    public function rightPaddleControls(paddle:Paddle, state:PlayState)
    {   
        // Check play mode and add multiple control options if in single player mode.
        if (state.multiplayer)
        {
            if (FlxG.keys.pressed.UP)
                velocity.y = -paddleSpeed;
            if (FlxG.keys.pressed.DOWN)
                velocity.y = paddleSpeed;
        }
        else 
        {
            if (FlxG.keys.pressed.UP || FlxG.keys.pressed.W)
                velocity.y = -paddleSpeed;
            if (FlxG.keys.pressed.DOWN || FlxG.keys.pressed.S)
                velocity.y = paddleSpeed;
        }

        #if (mobile || web)
        for (touch in FlxG.touches.list)
        {   
            if (touch.x >= FlxG.width / 2)
            y = touch.y - (height / 2);
        } 
        #end
    }
}