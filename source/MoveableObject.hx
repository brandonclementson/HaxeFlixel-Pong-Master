package;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxState;
import flixel.system.FlxSound;

import Random;

class MoveableObject extends FlxSprite
{
    private var state:FlxState;
    private var velocityX:Float;
    private var velocityY:Float;

    public var speed:Int = 500;
    private var speedModifier:Int = 200;
    public var directionX:Int = 1;
    private var directionY:Int = 1;

    public var paddlePosition:String;

    var ballPaddleSFX:FlxSound;
    var ballWallSFX:FlxSound;

    public function new()
    {
        super();

        ballPaddleSFX = FlxG.sound.load(AssetPaths.ball_paddle_sfx__wav);
        ballWallSFX = FlxG.sound.load(AssetPaths.ball_wall_sfx__wav);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        maxVelocity.y = 500;
    }

    public function resetObject()
    {
        setPosition((FlxG.width / 2) - 16, ((FlxG.height / 2) - 16));
        speed = 500;
        velocity.y = 0;
        directionX = Random.int(-1, 1);
        velocity.x = speed * directionX;
        if (velocity.x == 0)
            resetObject();
    }	

    public function collidePaddles(object:MoveableObject, paddle:Paddle)
    {
        ballPaddleSFX.play();
        FlxObject.separate(object, paddle);

        speed = speed + 25;

        if (directionX == 1)
            directionX = -1;
        else if (directionX == -1)
            directionX = 1;

        if (isTouching(FlxObject.UP) && directionX == 1)
        {
            FlxObject.separate(object, paddle);
            paddlePosition = "Down Left";
            velocity.x = speed * directionX + speedModifier;
            velocity.y =  500;
        }
        else if (isTouching(FlxObject.DOWN) && directionX == 1)
        {
            FlxObject.separate(object, paddle);
            paddlePosition = "Up Left";
            velocity.x = speed * directionX + speedModifier;
            velocity.y =  -500;
        }
        else if (isTouching(FlxObject.UP) && directionX == -1)
        {
            FlxObject.separate(object, paddle);
            paddlePosition = "Down Right";
            velocity.x = speed * directionX - speedModifier;
            velocity.y =  500;
        } 
        else if (isTouching(FlxObject.DOWN) && directionX == -1)
        {
            FlxObject.separate(object, paddle);
            paddlePosition = "Up Right";
            velocity.x = speed * directionX - speedModifier;
            velocity.y = -500;
        }  
        else if (isTouching(FlxObject.LEFT) || (isTouching(FlxObject.RIGHT)))
        {
            velocity.x = speed * directionX;
        }

        detectCollisionAngle(object, paddle);
    }

    function detectCollisionAngle(object:MoveableObject, paddle:Paddle)
    {
        var paddleMidPoint:Int = Std.int(paddle.y) + Std.int(paddle.height / 2);
        var ballMidPoint:Int = Std.int(object.y) + 16;
        var difference:Int;

        if (ballMidPoint < paddleMidPoint)
        {
    // Ball is on the left of the bat
            difference = paddleMidPoint - ballMidPoint;
            velocity.y = velocity.y - 2.5 * difference;
        }
        else
        {
    // Ball on the right of the bat
            difference = ballMidPoint - paddleMidPoint;
            object.velocity.y = object.velocity.y + 2.5 * difference;
        }
    }

    public function collideWalls(object:MoveableObject, wall:FlxSprite)
    {
        var previousVelocityY:Float = velocity.y;

        ballWallSFX.play();
        FlxObject.separate(object, wall);

        if (directionY == 1)
            directionY = -1;
        else if (directionY == -1)
            directionY = 1;

        velocity.y = previousVelocityY * directionY;
    }

    public function objectBounds()
    {
        if (x <= 0)
            velocity.x = speed * 1;
        else if (x >= FlxG.width - width)
            velocity.x = speed * -1;
        else if (y <= 0)
            velocity.y = speed * 1;
        else if (y >= FlxG.height - height)
            velocity.y = speed * -1;
    }
}