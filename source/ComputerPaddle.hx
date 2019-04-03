package;

import flixel.FlxObject;
import flixel.FlxG;

class ComputerPaddle extends Paddle
{
    var midPoint:Float;
    var closest:MoveableObject = null;

    public function new()
    {
        super(x);

        midPoint = (FlxG.height / 2) - (height / 2);

        setPosition(75, midPoint);
        color = 0xFF0090BC;
        paddleSpeed = 350;
        maxVelocity.y = 350;
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }

    public function computerControls(ball:Ball, powerUp:PowerUp, state:PlayState)
    {
        var midScreen:Float = (FlxG.width / 2) - (ball.width / 2);

        if (powerUp.x <= midScreen && ball.x >= midScreen)
            controlY(powerUp);
        else
            state.ballGroup.forEachAlive(function (member)
            {	
                if (closest == null || Math.abs(x - member.x) < Math.abs(closest.x - member.x))
                    closest = member;
                    controlY(closest);
            }, false);
    }

    function controlY(object:MoveableObject)
    {
        if (object.y + (object.height / 2) >= y + height - 75)
             velocity.y = paddleSpeed;
        else if (object.y + (object.height / 2) <= y + 75)
            velocity.y = -paddleSpeed;  
        else if (object.y + (object.height / 2) >= y && object.y + (object.height / 2) <= y + height)
            velocity.y = 0;  
        
       if (Math.abs(object.velocity.y) <= Math.abs(velocity.y))
          acceleration.y = object.velocity.y * 2;
    }
}