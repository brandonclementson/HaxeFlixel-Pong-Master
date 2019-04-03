package;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.group.FlxGroup;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.group.FlxSpriteGroup;

class CommonMethods
{
    public static var wallGroup:FlxTypedGroup<FlxSprite>;

    // Common method to draw the logo from any state.
    public static function displayLogo(heightModifier:Float, state:FlxState)
    {
        var titleGroup = new FlxSpriteGroup();

        var titleText = new FlxText(0, (FlxG.height / 2) - 120, FlxG.width);
        titleText.setFormat(AssetPaths.product_sans_bold__ttf, 132, FlxColor.WHITE);
        titleText.alignment = FlxTextAlign.CENTER;
        titleText.text = "PONG";
        titleGroup.add(titleText);
        state.add(titleText);

        var subtitleText = new FlxText(0, (FlxG.height / 2) + 20, FlxG.width);
        subtitleText.setFormat(AssetPaths.azonix__otf, 45, FlxColor.WHITE);
        subtitleText.alignment = FlxTextAlign.CENTER;
        subtitleText.text = "M  A  S  T  E  R";
        titleGroup.add(subtitleText);
        state.add(subtitleText);

        var leftPaddleLogo = new FlxSprite();
        leftPaddleLogo.makeGraphic(28, 160, 0xFF0090BC);
        leftPaddleLogo.setPosition((FlxG.width / 2) - 265, (FlxG.height / 2) - 120);
        titleGroup.add(leftPaddleLogo);
        state.add(leftPaddleLogo);
                
        var rightPaddleLogo = new FlxSprite();
        rightPaddleLogo.makeGraphic(28, 160, 0xFFF7523C);
        rightPaddleLogo.setPosition((FlxG.width / 2) + 240, (FlxG.height / 2) - 70);
        titleGroup.add(rightPaddleLogo);
        state.add(rightPaddleLogo); 
        state.add(titleGroup);

        titleGroup.y = heightModifier;
    }

    // Common method to draw the walls of the state -- can be expanded for different game modes.
    public static function buildStage(wallHeight:Int, state:FlxState) 
    {
        wallGroup = new FlxTypedGroup();

        var upperWall = new FlxSprite();
        upperWall.makeGraphic(FlxG.width, wallHeight, 0xFF404040);
        upperWall.setPosition(0, 0);
        upperWall.immovable = true;
        wallGroup.add(upperWall);
        state.add(upperWall);

        var lowerWall = new FlxSprite();
        lowerWall.makeGraphic(FlxG.width, wallHeight, 0xFF404040);
        lowerWall.setPosition(0, FlxG.height - wallHeight);
        lowerWall.immovable = true;  
        wallGroup.add(lowerWall);
        state.add(lowerWall);

        var middleLine = new FlxSprite();
        middleLine.makeGraphic(wallHeight, FlxG.height, 0xFF404040);
        middleLine.setPosition(FlxG.width / 2 - 5, 0);
        state.add(middleLine);

        state.add(wallGroup);
    }
}