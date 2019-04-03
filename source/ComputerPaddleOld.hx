package;

import flixel.FlxG;

class ComputerPaddle extends Paddle
{
    var midPoint:Float;

    public function new()
    {
        super(x);

        midPoint = (FlxG.height / 2) - (height / 2);

        setPosition(25, midPoint);
        color = 0xFF0090BC;
        paddleSpeed = 450;
        drag.y = 2000;
        maxVelocity.y = 450;

    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }

    public function computerControls(ball:Ball, powerUp:PowerUp, state:PlayState)
    {
        var midScreen:Float = (FlxG.width / 2) - (ball.width / 2);
        acceleration.y = 0;

        //var impactZone:Float = 

        //velocity.y = 0;

     //   if (powerUp.x <= midScreen && ball.x >= midScreen)
      //      controlY(powerUp);
/*         else if (powerUp.x >= midScreen && ball.x >= midScreen)
        {
            if (y + (height / 2) > midPoint)
                velocity.y -= paddleSpeed;
            else if (y + (height / 2) < midPoint)
                velocity.y += paddleSpeed;
        }   */ 
       // else
            state.ballGroup.forEachAlive(function (member)
            {	
                controlY(member);
            }, false);
    }

    function controlY(object:MoveableObject)
    {

        
        if (object.y >= y + (height / 2))
       {
            acceleration.y += paddleSpeed;

       }
        else if (object.y <= y + (height / 2))
        {
            acceleration.y -= paddleSpeed;  
             //   if (object.velocity.y < velocity.y)
              //      velocity.y = 0;
        }
        else
        {
            velocity.y = 0;
        } 


/*         if (y >= object.y || y <= object.y)
            y = object.y; */


  /*       if (FlxG.keys.pressed.S)
            acceleration.y = paddleSpeed;
        if (FlxG.keys.pressed.W)
            acceleration.y = -paddleSpeed;  */
    }
}