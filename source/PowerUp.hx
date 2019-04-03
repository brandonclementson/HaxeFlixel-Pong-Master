package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.system.FlxSound;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxTimer;

import Random;

class PowerUp extends MoveableObject
{
    var powerUP:FlxSprite;
    var timer:FlxTimer;

    // Variables for Paddle scaling.
    var scaleY:Float = 2;
    var toY:Float;
    var toHeight:Float;
    var offsetY:Float = 0;

    var multiballOne:Ball;
    var multiballTwo:Ball;
    var multiballThree:Ball;
    var ballDirection:Int;

    var extendPaddleSFX:FlxSound;
    var shortenPaddleSFX:FlxSound;
    var multiBallSFX:FlxSound;


    public function new()
    {
        super();

        loadGraphic(AssetPaths.powerup_animation__png, true, 32, 32);
        animation.add('flicker', [0, 1, 2, 3, 4, 5], 6, true);
        
        speed = 250;
        angle = 45;
        angularVelocity = 100;
        maxVelocity.x = 250;
        resetObject();

        timer = new FlxTimer();
        extendPaddleSFX = FlxG.sound.load(AssetPaths.extend_paddle_sfx__wav);
        shortenPaddleSFX = FlxG.sound.load(AssetPaths.shorten_paddle_sfx__wav);
        multiBallSFX = FlxG.sound.load(AssetPaths.multiball_sfx__wav);

    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        animation.play('flicker');
    }

    override public function resetObject()
    {
    	setPosition(Random.int(450, FlxG.width - 450), Random.int(150, FlxG.height - 150));
        directionX = Random.int(-1, 1);
        directionY = Random.int(-1, 1);
		velocity.x = speed * directionX;
        velocity.y = speed * directionY;
		if (velocity.x == 0 || velocity.y == 0)
			resetObject();
    }

    public function paddlePowerUp(powerUP:PowerUp, paddle:Paddle, state:PlayState)
    {
        kill();
        
        // Choose random number that will become power up.
        var powerUpPicker:Int = Random.int(1,3);

        if (powerUpPicker == 1)
            extendPaddle(paddle);
        else if (powerUpPicker == 2)
            shortenPaddle(paddle);
        else if (powerUpPicker == 3)
            multiBall(state, paddle);
    }

    function extendPaddle(paddle:Paddle)
    {
        extendPaddleSFX.play();

        tweenPaddle(paddle, 2);

        timer.start(5 ,normalSize.bind(_, paddle), 1);
    }
    
    // Power up function that will shorten paddle and call a timer.
    function shortenPaddle(paddle:Paddle)
    {
        shortenPaddleSFX.play();

        tweenPaddle(paddle, 0.5);

        timer.start(5 ,normalSize.bind(_, paddle), 1);
    }

    function multiBall(state:PlayState, paddle:Paddle)
    {
        multiBallSFX.play();

        if (paddle.x <= FlxG.width / 2)
             ballDirection = -1;
        else if (paddle.x >= FlxG.width / 2)
             ballDirection = 1; 

        multiballOne = new Ball(paddle.x - width * ballDirection, paddle.y, 500 * -ballDirection, -45, state);
        state.ballGroup.add(multiballOne);

        multiballTwo = new Ball(paddle.x - width * ballDirection, paddle.y + (paddle.height / 2) - (height / 2), 500 * -ballDirection, 0, state);
        state.ballGroup.add(multiballTwo);

        multiballThree = new Ball(paddle.x - width * ballDirection, (paddle.y + paddle.height) - height, 500 * -ballDirection, 45, state);
        state.ballGroup.add(multiballThree);
    }

    // Function called after the tween is complete to update the hitbox to the transformed paddle size.
    private function tweenPaddle(paddle:Paddle, scale:Float):Void
    {
        scaleY = scale;
        toHeight = paddle.height * scaleY;
        offsetY = -((toHeight - paddle.height) / 2);
        toY = paddle.y + offsetY;
    
        FlxTween.tween(paddle, { y: toY, height: toHeight, "scale.y": scaleY, "offset.y": offsetY }, 0.3, { ease:FlxEase.elasticInOut });
    }

    // Function called after timer ends to reset paddle back to normal size.
    private function normalSize(timer:FlxTimer, paddle:Paddle):Void
    {
        toHeight = paddle.height / scaleY;
        toY = paddle.y + ((paddle.height - toHeight) / 2);
        scaleY = 1;
        offsetY = 0;

        FlxTween.tween(paddle, { y: toY, height: toHeight, "scale.y": scaleY, "offset.y": offsetY }, 0.3, { ease:FlxEase.elasticInOut });
    }
}