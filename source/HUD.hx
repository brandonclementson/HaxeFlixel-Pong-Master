package;

import flixel.FlxG;
import flixel.group.FlxSpriteGroup; 
import flixel.text.FlxText;
import flixel.util.FlxColor;

class HUD extends FlxSpriteGroup 
{
    var leftPaddleScoreText:FlxText;
	var rightPaddleScoreText:FlxText;

	public var debugPanelSwitch:Bool = false;
	var ballVelocityX:FlxText;
    var ballVelocityY:FlxText;
    var ballSpeed:FlxText;

	var ballDirectionX:FlxText;
	var ballDirectionY:FlxText;
	var paddlePositionText:FlxText;


    public function new()
    {
        super();

		// Score
        leftPaddleScoreText = new FlxText(525, 30);
		leftPaddleScoreText.setFormat(AssetPaths.block_merged__ttf, 64, FlxColor.GRAY);

		rightPaddleScoreText = new FlxText(FlxG.width - 594, 30);
		rightPaddleScoreText.setFormat(AssetPaths.block_merged__ttf, 64, FlxColor.GRAY);

		// Debug Panel
		ballVelocityX = new FlxText(50, FlxG.height - 65);
		ballVelocityX.setFormat(AssetPaths.product_sans_regular__ttf, 18, FlxColor.WHITE);
		
		ballVelocityY = new FlxText(150, FlxG.height - 65);
		ballVelocityY.setFormat(AssetPaths.product_sans_regular__ttf, 18, FlxColor.WHITE);

        ballSpeed = new FlxText(250, FlxG.height - 65);
		ballSpeed.setFormat(AssetPaths.product_sans_regular__ttf, 18, FlxColor.WHITE);

		ballDirectionX = new FlxText(50, FlxG.height - 35);
		ballDirectionX.setFormat(AssetPaths.product_sans_regular__ttf, 18, FlxColor.WHITE);
		
		ballDirectionY = new FlxText(150, FlxG.height - 35);
		ballDirectionY.setFormat(AssetPaths.product_sans_regular__ttf, 18, FlxColor.WHITE);

		paddlePositionText = new FlxText(250, FlxG.height - 35);
		paddlePositionText.setFormat(AssetPaths.product_sans_regular__ttf, 18, FlxColor.WHITE);

        add(leftPaddleScoreText);
		add(rightPaddleScoreText);

		add(ballVelocityX);
		add(ballVelocityY);
        add(ballSpeed);

		add(ballDirectionX);
		add(ballDirectionY);

		add(paddlePositionText);
    }

    public function displayScore(leftPaddleScore:Int, rightPaddleScore:Int)
    {
		leftPaddleScoreText.text = Std.string(leftPaddleScore);
		rightPaddleScoreText.text = Std.string(rightPaddleScore);
    }

    public function debugPanel(ball:Ball)
	{
		if (debugPanelSwitch)
		{
			ballVelocityX.text = "X: " + Std.string(ball.velocity.x);
			ballVelocityY.text = "Y: " + Std.string(ball.velocity.y);
            ballSpeed.text = "Ball Speed: " + Std.string(ball.speed);

//			ballDirectionX.text = "X: " + Std.string(ball.directionX);
//			ballDirectionY.text = "Y: " + Std.string(ball.directionY);

			paddlePositionText.text = ball.paddlePosition;
		}
	}
}
