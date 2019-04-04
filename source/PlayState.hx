package;

import flixel.ui.FlxSpriteButton;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
import flixel.system.FlxSound;

class PlayState extends FlxState
{
	public var multiplayer:Bool;
	
	var paddles = new FlxGroup();
	var leftPaddle:PlayerPaddle;
	var rightPaddle:PlayerPaddle;
	var computerPaddle:ComputerPaddle;

	public var ballGroup:FlxTypedGroup<Ball>;
	var ball:Ball;

	var movingPaddles:FlxGroup;
	var movingPaddleLeft:MovingPaddle;
	var movingPaddleRight:MovingPaddle;

	public var leftPaddleScore:Int = 0;
	public var rightPaddleScore:Int = 0;
	public var maxScore:Int = 5;
	public var matchInProgress:Bool = true;

	var hud:HUD;
	var powerUp:PowerUp;
	var timer:FlxTimer;


	var goalSFX:FlxSound;

	override public function new(checkPlayers:Bool)
	{
		super();
		multiplayer = checkPlayers;
	}

	override public function create():Void
	{
		super.create();

		#if (web || desktop)
		FlxG.mouse.visible = false;
		#end
		
		CommonMethods.buildStage(10, this);
		
		// Check game type and load in appropiate assets.
		if (multiplayer)
		{
			leftPaddle = new PlayerPaddle(75);
			leftPaddle.color = 0xFF0090BC;
			paddles.add(leftPaddle);
			add(leftPaddle);
		}
		else if (!multiplayer)
		{
			computerPaddle = new ComputerPaddle();
			paddles.add(computerPaddle);
			add(computerPaddle);
		}

		// Load player's paddle.
		rightPaddle = new PlayerPaddle((FlxG.width - 75) - 28);
		rightPaddle.color = 0xFFF7523C;

		// Add all paddle elements to FlxGroup for simpler collision logic.
		paddles.add(rightPaddle);

		movingPaddles = new FlxGroup();
		movingPaddleLeft = new MovingPaddle(432, 100, 550);
		movingPaddleRight = new MovingPaddle(825, 550, 100);

		movingPaddles.add(movingPaddleLeft);
		movingPaddles.add(movingPaddleRight);

		ballGroup = new FlxTypedGroup();
		ball = new Ball(0, 0, 0, 0, this);
		ballGroup.add(ball);
		ball.resetObject();
		
		if (!multiplayer)
			ball.velocity.x = ball.speed;

		goalSFX = FlxG.sound.load(AssetPaths.goal_sfx__wav);

		powerUp = new PowerUp();
		timer = new FlxTimer();
		hud = new HUD();

		add(hud); 

		add(movingPaddleLeft);
		add(movingPaddleRight);

		add(rightPaddle);
		add(ballGroup);

		timer.start(8, powerUpGenerator.bind(_), 0);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		menuControls();
		rightPaddle.rightPaddleControls(rightPaddle, this);

		if (multiplayer)
			leftPaddle.leftPaddleControls(leftPaddle);
		else if (!multiplayer)
			computerPaddle.computerControls(ball, powerUp, this);
		
		getScore();

		hud.displayScore(leftPaddleScore, rightPaddleScore);
		hud.debugPanel(ball);

 		FlxG.overlap(ballGroup, paddles, collisionPaddle);
		FlxG.overlap(ballGroup, movingPaddles, collisionPaddle);
		FlxG.overlap(ballGroup, CommonMethods.wallGroup, collisionWall);
		FlxG.overlap(powerUp, CommonMethods.wallGroup, collisionWallPowerUp);
		FlxG.overlap(powerUp, movingPaddles, collisionPaddlePowerUp);
		FlxG.overlap(powerUp, paddles, paddlePowerUp);

		if (matchInProgress)
		{
			scoreTracker(leftPaddleScore, rightPaddleScore);
		}
	}

	function menuControls()
	{
		if (FlxG.keys.justPressed.ESCAPE)
			backToMenu();
		if (FlxG.keys.justPressed.F1)
			hud.debugPanelSwitch = hud.debugPanelSwitch ? false : true;
	}

	function collisionPaddle(ball:Ball, paddle:Paddle)
	{
		ball.collidePaddles(ball, paddle);
	}

	function collisionWall(ball:Ball, wall:FlxSprite)
	{
		ball.collideWalls(ball, wall);
	}

	function paddlePowerUp(powerUp:PowerUp, paddle:Paddle)
	{
		powerUp.paddlePowerUp(powerUp, paddle, this);
	}

	function collisionWallPowerUp(powerUp:PowerUp, wall:FlxSprite)
	{
		powerUp.collideWalls(powerUp, wall);
	}

	function collisionPaddlePowerUp(powerUp:PowerUp, paddle:Paddle)
	{
		powerUp.collidePaddles(powerUp, paddle);
	}

	function scoreTracker(leftPaddleScore:Int, rightPaddleScore:Int)
	{
		if (leftPaddleScore >= maxScore)
		{
			matchInProgress = false;
			gameOver("BLUE", 0xFF0090BC);
		}
		else if (rightPaddleScore >= maxScore)
		{
			matchInProgress = false;
			gameOver("RED", 0xFFF7523C);
		}
	}

	function gameOver(winner:String, winnerColor:FlxColor)
	{
		ballGroup.forEachAlive(function (member)
		{	
			member.kill();
			member.trail.kill();
		}, false);

		ballGroup.kill();
		CommonMethods.wallGroup.kill();

		FlxG.camera.flash(FlxColor.WHITE, 0.3);

		#if (web || desktop)
		FlxG.mouse.useSystemCursor = true;
		#end

		var background = new FlxSprite();
		background.makeGraphic(FlxG.width, FlxG.height, 0xFF1F2326);
		add(background);

		CommonMethods.displayLogo(-200, this);

		var winBannerBorder = new FlxSprite();
		winBannerBorder.makeGraphic(2, 110, 0xFF404040);
		winBannerBorder.setPosition(FlxG.width / 2, (FlxG.height / 2) - (winBannerBorder.height / 2));
		FlxTween.tween(winBannerBorder, { "scale.x": FlxG.width }, 0.5, { ease: FlxEase.quadInOut });
		add(winBannerBorder);

		var winBanner = new FlxSprite();
		winBanner.makeGraphic(2, 100, winnerColor);
		winBanner.setPosition(FlxG.width / 2, (FlxG.height / 2) - (winBanner.height / 2));
		FlxTween.tween(winBanner, { "scale.x": FlxG.width }, 0.5, { ease: FlxEase.quadInOut });
		add(winBanner);

		var winText = new FlxText(0, (FlxG.height / 2) - 40, FlxG.width);
		winText.setFormat(AssetPaths.product_sans_bold__ttf, 64, FlxColor.WHITE);
		winText.alignment = FlxTextAlign.CENTER;
		winText.text = winner + " PLAYER WINS";
		add(winText);

		var playAgainBtn = new FlxSpriteButton(145, 550, playAgain);
		playAgainBtn.makeGraphic(350, 75, FlxColor.GRAY);
		playAgainBtn.createTextLabel("PLAY AGAIN", AssetPaths.product_sans_bold__ttf, 48, FlxColor.WHITE);
		playAgainBtn.setPosition((FlxG.width / 2) - (playAgainBtn.width / 2), 465);
		add(playAgainBtn);

		var backToMenuBtn = new FlxSpriteButton(550, 550, backToMenu);
		backToMenuBtn.makeGraphic(350, 75, 0xFF404040);
		backToMenuBtn.createTextLabel("MAIN MENU", AssetPaths.product_sans_bold__ttf, 48, FlxColor.WHITE);
		backToMenuBtn.setPosition((FlxG.width / 2) - (backToMenuBtn.width / 2), 590);
		add(backToMenuBtn);
	}

	function powerUpGenerator(timer:FlxTimer)
	{
		if (matchInProgress)
		{
			powerUp = new PowerUp();
			add(powerUp);
		}
	}

	function getScore()
	{
		// Loop through each active ball in the Ball Group to check for goals.
		ballGroup.forEachAlive(function (member)
		{	
			// Calculate if ball has touched the right edge of the screen and increment the left paddle's score.
			if (member.x >= FlxG.width - ball.width)
			{
				member.kill();
				member.trail.kill();
				leftPaddleScore++;
				goalSFX.play();
				FlxG.camera.shake(0.01, 0.2);  
			}
			// Calculate if ball has touched the left edge of the screen and increment the right paddle's score.
			else if (member.x <= 0)
			{
				member.kill();
				member.trail.kill();
				rightPaddleScore++;
				goalSFX.play();
				FlxG.camera.shake(0.01, 0.2);  
			}
		}, false);

		// Keeps track of the number of active balls in the Ball Group.
		// If the number is zero, than revive and reset the original ball object.
		var deadBalls = ballGroup.countLiving();

		if (deadBalls <= 0)
		{
			ball.revive();
			ball.trail.revive();
			ball.resetObject();
		}	
	}

	function playAgain()
	{
		FlxG.switchState(new PlayState(multiplayer));
	}

	function backToMenu()
	{
		FlxG.switchState(new MenuState());
	}
}