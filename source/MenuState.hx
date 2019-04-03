package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.ui.FlxSpriteButton;

import Random;

class MenuState extends FlxState
{
    var ball:Ball;
    var ballTwo:Ball;
    var ballDirectionX:Int = 0;
    var ballDirectionY:Int = 0;

    var aboutText:FlxText;
    var singlePlayerBtn:FlxSpriteButton;
    var multiPlayerBtn:FlxSpriteButton;

    override public function create():Void
    {
        super.create();

        FlxG.sound.playMusic(AssetPaths.battle_theme__ogg, 0.7, true);
        #if (web || desktop)
        FlxG.mouse.useSystemCursor = true;
        #end

        ball = new Ball(Random.float(0, FlxG.width - 32), Random.float(0, FlxG.height - 32), 500, Random.int(25, 200), this);
        ball.color = FlxColor.GRAY;
        ball.trail.color = FlxColor.GRAY;
        add(ball);

        CommonMethods.displayLogo(-125, this);

        singlePlayerBtn = new FlxSpriteButton(145, 550, singlePlayer);
        singlePlayerBtn.makeGraphic(300,75, 0xFF0090BC);
        singlePlayerBtn.createTextLabel("1 PLAYER", AssetPaths.product_sans_bold__ttf, 48, FlxColor.WHITE);
        singlePlayerBtn.setPosition((FlxG.width / 2) - (singlePlayerBtn.width / 2), 400);
        add(singlePlayerBtn);

        multiPlayerBtn = new FlxSpriteButton(550, 550, multiPlayer);
        multiPlayerBtn.makeGraphic(300,75, 0xFFF7523C);
        multiPlayerBtn.createTextLabel("2 PLAYERS", AssetPaths.product_sans_bold__ttf, 48, FlxColor.WHITE);
        multiPlayerBtn.setPosition((FlxG.width / 2) - (singlePlayerBtn.width / 2), 525);
        add(multiPlayerBtn);

        aboutText = new FlxText(0, FlxG.height - 50, FlxG.width);
        aboutText.setFormat(AssetPaths.product_sans_regular__ttf, 20, FlxColor.WHITE);
        aboutText.alignment = FlxTextAlign.CENTER;
        aboutText.text = "Made with HaxeFlixel by Brandon Clementson";
        add(aboutText);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        ball.objectBounds();
    }

    function singlePlayer()
    {
        FlxG.switchState(new PlayState(false));
    }

    function multiPlayer()
    {
        FlxG.switchState(new PlayState(true));
    }

}