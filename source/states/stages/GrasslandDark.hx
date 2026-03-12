package states.stages;

import states.stages.objects.*;

import openfl.filters.ShaderFilter;
import shaders.RainShader;

import flixel.addons.display.FlxTiledSprite;

class GrasslandDark extends BaseStage
{
	var rainShader:RainShader;
	var rainShaderStartIntensity:Float = 0;
	var rainShaderEndIntensity:Float = 0;

	var scrollingSky:FlxTiledSprite;

	override function create()
	{
		var sky:BGSprite = new BGSprite('dark/skyDark', -400, -200, 0.9, 0.9);
		sky.setGraphicSize(Std.int(sky.width * 1.6));
		sky.updateHitbox();
		add(sky);

		var ground:BGSprite = new BGSprite('dark/groundDark', -400, -180);
		ground.setGraphicSize((ground.width * 1.6));
		ground.updateHitbox();
		add(ground);

		var clouds:BGSprite = new BGSprite('dark/cloudsDark', -190, -300, 0.6, 0.6);
		clouds.setGraphicSize(Std.int(clouds.width * 1.35));
		clouds.updateHitbox();
		add(clouds);

		if(ClientPrefs.data.shaders)
			setupRainShader();
	}

	function setupRainShader()
	{
		rainShader = new RainShader();
		rainShader.scale = FlxG.height / 200;
		rainShaderStartIntensity = 0.2;
		rainShaderEndIntensity = 0.4;
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