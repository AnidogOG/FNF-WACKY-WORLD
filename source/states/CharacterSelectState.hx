package states;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.text.FlxText;
import flixel.system.FlxSoundGroup;
import flixel.math.FlxPoint;
import openfl.geom.Point;
import flixel.*;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.math.FlxMath;
import flixel.util.FlxStringUtil;
import objects.Character;
import objects.HealthIcon;

using StringTools;

class CharacterInSelect
{
	public var names:Array<String>;
	public var polishedNames:Array<String>;

	public function new(names:Array<String>, polishedNames:Array<String>)
	{
		this.names = names;
		this.polishedNames = polishedNames;
	}
}

class CharacterSelectState extends MusicBeatState
{
	public var boyfriend:Character;
	public var current:Int = 0;
	public var curForm:Int = 0;
	public var characterText:FlxText;

	public var funnyIconMan:HealthIcon;

	var notestuffs:Array<String> = ['LEFT', 'DOWN', 'UP', 'RIGHT'];

	public var isDebug:Bool = false; //CHANGE THIS TO FALSE BEFORE YOU COMMIT RETARDS

	public var PressedTheFunny:Bool = false;

	var selectedCharacter:Bool = false;

	var currentSelectedCharacter:CharacterInSelect;

	var noteMsTexts:FlxTypedGroup<FlxText> = new FlxTypedGroup<FlxText>();

	//it goes left,right,up,down
	
	public var characters:Array<CharacterInSelect> = 
	[
		new CharacterInSelect(['bf'], ["Boyfriend"]),
		new CharacterInSelect(['gf'], ["Girlfriend"]),
	];
	public function new() 
	{
		super();
	}
	
	override public function create():Void 
	{
		super.create();

		currentSelectedCharacter = characters[current];

		FlxG.sound.playMusic(Paths.music("paws-music"),1,true);
		
		//create stage
		var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('stageback'));
		bg.antialiasing = true;
		bg.scrollFactor.set(0.9, 0.9);
		bg.active = false;
		add(bg);

		var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('stagefront'));
		stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
		stageFront.updateHitbox();
		stageFront.antialiasing = true;
		stageFront.scrollFactor.set(0.9, 0.9);
		stageFront.active = false;
		add(stageFront);

		var stageCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('stagecurtains'));
		stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
		stageCurtains.updateHitbox();
		stageCurtains.antialiasing = true;
		stageCurtains.scrollFactor.set(1.3, 1.3);
		stageCurtains.active = false;
		add(stageCurtains);

		FlxG.camera.zoom = 0.75;

		//create character
		boyfriend = new Character(FlxG.width / 2, FlxG.height / 2, "bf");
		boyfriend.screenCenter();
		add(boyfriend);
		
		characterText = new FlxText((FlxG.width / 9) - 50, (FlxG.height / 8) - 225, "Boyfriend");
		characterText.font = 'Comic Sans MS Bold';
		characterText.setFormat(Paths.font("comic.ttf"), 90, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		characterText.autoSize = false;
		characterText.fieldWidth = FlxG.width;
		characterText.borderSize = 7;
		characterText.screenCenter(X);
		add(characterText);

		funnyIconMan = new HealthIcon('bf', true);
		funnyIconMan.screenCenter(X);
		funnyIconMan.y = characterText.y + 100;
		add(funnyIconMan);

		var tutorialThing:FlxSprite = new FlxSprite().loadGraphic(Paths.image('charSelectGuide'));
		tutorialThing.setGraphicSize(Std.int(tutorialThing.width * 1.5));
		tutorialThing.antialiasing = true;
		tutorialThing.y += tutorialThing.height / 2;
		add(tutorialThing);
	}

	override public function update(elapsed:Float):Void 
	{
		Conductor.songPosition = FlxG.sound.music.time;

		super.update(elapsed);
		//FlxG.camera.focusOn(FlxG.ce);

		if (FlxG.keys.justPressed.ESCAPE)
		{
			LoadingState.loadAndSwitchState(new FreeplayState());
		}

		if(controls.UI_UP_P && !PressedTheFunny)
		{
			boyfriend.playAnim('singUP', true);
		}
		if(controls.UI_DOWN_P && !PressedTheFunny)
		{
			boyfriend.playAnim('singDOWN', true);
		}
		
		if(boyfriend.animation.curAnim.name.contains('idle') || boyfriend.animation.curAnim.name.contains('dance'))
		{
			fuckyWucky = true;
		}
		else
		{
			fuckyWucky = boyfriend.animation.finished;
		}
		
		if (controls.ACCEPT || FlxG.keys.justPressed.ENTER)
		{
			PressedTheFunny = true;
			selectedCharacter = true;
			if(boyfriend.animation.getByName("hey") != null)
			{
				boyfriend.playAnim('hey', true);
			}
			else if(boyfriend.animation.getByName("cheer") != null)
			{
				boyfriend.playAnim('cheer', true);
			}
			else if(boyfriend.animation.getByName("stand") != null)
			{
				boyfriend.playAnim('stand', true);
			}
			else
			{
				boyfriend.playAnim('singUP', true);
			}
			FlxG.sound.music.stop();
			FlxG.sound.play(Paths.music('gameOverEnd'));
			new FlxTimer().start(1.9, endIt);
		}
		if (FlxG.keys.justPressed.LEFT && !selectedCharacter)
		{
			curForm = 0;
			current--;
			if (current < 0)
			{
				current = characters.length - 1;
			}
			UpdateBF();
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		}

		if (FlxG.keys.justPressed.RIGHT && !selectedCharacter)
		{
			curForm = 0;
			current++;
			if (current > characters.length - 1)
			{
				current = 0;
			}
			UpdateBF();
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		}
		if (FlxG.keys.justPressed.DOWN && !selectedCharacter)
		{
			curForm--;
			if (curForm < 0)
			{
				curForm = characters[current].names.length - 1;
			}
			UpdateBF();
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		}

		if (FlxG.keys.justPressed.UP && !selectedCharacter)
		{
			curForm++;
			if (curForm > characters[current].names.length - 1)
			{
				curForm = 0;
			}
			UpdateBF();
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		}
	}

	public function UpdateBF()
	{
		funnyIconMan.color = FlxColor.WHITE;
		currentSelectedCharacter = characters[current];
		characterText.text = currentSelectedCharacter.polishedNames[curForm];
		boyfriend.destroy();
		boyfriend = new Character(FlxG.width / 2, FlxG.height / 2, currentSelectedCharacter.names[curForm]);
		boyfriend.screenCenter();
		boyfriend.y = 450;
		boyfriend.screenCenter();
		add(boyfriend);
		funnyIconMan.changeIcon(boyfriend.healthIcon);
		characterText.screenCenter(X);
	}

	var fuckyWucky:Bool = true;

	override function beatHit()
	{
		super.beatHit();
		if (boyfriend != null && !selectedCharacter && fuckyWucky)
		{
			boyfriend.dance();
		}
	}
	
	
	public function endIt(e:FlxTimer = null)
	{
		trace("ENDING");
		LoadingState.loadAndSwitchState(new PlayState());
	}
	
}