package states.stages;

import states.stages.objects.*;

import openfl.filters.ShaderFilter;
import shaders.RainShader;

import flixel.addons.display.FlxTiledSprite;

class GrasslandRain extends BaseStage
{
	var rainShader:RainShader;
	var rainShaderStartIntensity:Float = 0;
	var rainShaderEndIntensity:Float = 0;

	var scrollingSky:FlxTiledSprite;

	override function create()
	{
		var sky:BGSprite = new BGSprite('night/skyNight', -400, -200, 0.9, 0.9);
		sky.setGraphicSize(Std.int(sky.width * 1.6));
		sky.updateHitbox();
		add(sky);

		var stars:BGSprite = new BGSprite('night/Stars', -400, -200, 0.8, 0.8);
		stars.setGraphicSize(Std.int(stars.width * 1.6));
		stars.updateHitbox();
		add(stars);

		var ground:BGSprite = new BGSprite('night/groundNight', -400, -180);
		ground.setGraphicSize((ground.width * 1.6));
		ground.updateHitbox();
		add(ground);

		var clouds:BGSprite = new BGSprite('night/cloudsNight', -190, -200, 0.6, 0.6);
		clouds.setGraphicSize(Std.int(clouds.width * 1.35));
		clouds.updateHitbox();
		add(clouds);


		if(ClientPrefs.data.shaders)
			setupRainShader();
	}

	override function beatHit()
	{
		if(curBeat == 272)
		{
			var foxy:BGSprite = new BGSprite('night/FoxyStandby', -400, 100, 0.9, 0.9);
			foxy.setGraphicSize(Std.int(foxy.width * 0.5));
			foxy.updateHitbox();
			add(foxy);

			var whiteScreen:FlxSprite = new FlxSprite().makeGraphic(Std.int(FlxG.width * 5), Std.int(FlxG.height * 5), FlxColor.WHITE);
			whiteScreen.scrollFactor.set();
			whiteScreen.setGraphicSize(Std.int(whiteScreen.width * 1.2));
			whiteScreen.blend = ADD;
			add(whiteScreen);
			FlxTween.tween(whiteScreen, {alpha: 0}, 1, {
				startDelay: 0.1,
				ease: FlxEase.linear,
				onComplete: function(twn:FlxTween)
				{
					remove(whiteScreen);
					whiteScreen.destroy();
				}
			});
		}
	}

	function setupRainShader()
	{
		rainShader = new RainShader();
		rainShader.scale = FlxG.height / 200;
		rainShaderStartIntensity = 0.6;
		rainShaderEndIntensity = 0.1;
		rainShader.intensity = rainShaderStartIntensity;
		FlxG.camera.setFilters([new ShaderFilter(rainShader)]);
	}

	override function update(elapsed:Float)
	{
		if(scrollingSky != null) scrollingSky.scrollX -= elapsed * 22;

		if(rainShader != null)
		{
			var remappedIntensityValue:Float = FlxMath.remapToRange(Conductor.songPosition, 0, (FlxG.sound.music != null ? FlxG.sound.music.length : 0), rainShaderStartIntensity, rainShaderEndIntensity);
			rainShader.intensity = remappedIntensityValue;
			rainShader.updateViewInfo(FlxG.width, FlxG.height, FlxG.camera);
			rainShader.update(elapsed);
		}
	}
}