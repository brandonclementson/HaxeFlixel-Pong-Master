package;

import flixel.FlxState;
import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.addons.effects.FlxTrail;
import Random;


class Ball extends MoveableObject
{
    public var trail:FlxTrail;

    public function new(positionX:Float, poistionY:Float, velocityX:Float, velocityY:Float, state:FlxState)
    {
        super();

        x= positionX;
        y = poistionY;
        velocity.x = velocityX;
        velocity.y = velocityY;
        this.state = state;

        makeGraphic(32, 32, FlxColor.WHITE);

        trail = new FlxTrail(this);
		state.add(trail);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }

    // Resets position of ball back to the center of the screen and gives it a random X direction.
    override public function resetObject()
	{
		setPosition((FlxG.width / 2) - 16, ((FlxG.height / 2) - 16));
        speed = 500;
		velocity.y = 0;
        directionX = Random.int(-1, 1);
		velocity.x = speed * directionX;
		if (velocity.x == 0)
			resetObject();
	}	
}