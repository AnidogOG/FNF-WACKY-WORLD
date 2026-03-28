package states.stages;

import states.stages.objects.*;

import openfl.filters.ShaderFilter;
import shaders.RainShader;

import flixel.addons.display.FlxTiledSprite;

class Road extends BaseStage
{
	var rainShader:RainShader;
	var rainShaderStartIntensity:Float = 0;
	var rainShaderEndIntensity:Float = 0;

	var scrollingSky:FlxTiledSprite;

	override function create()
	{
		var sky:BGSprite = new BGSprite('road/sky', -400, -200, 0.9, 0.9);
		sky.setGraphicSize(Std.int(sky.width * 1.6));
		sky.updateHitbox();
		add(sky);

		var buildings:BGSprite = new BGSprite('road/buildings', -400, -200);
		buildings.setGraphicSize((buildings.width * 1.6));
		buildings.updateHitbox();
		add(buildings);

		var ground:BGSprite = new BGSprite('road/road', -400, -200);
		ground.setGraphicSize((ground.width * 1.6));
		ground.updateHitbox();
		add(ground);

		var clouds:BGSprite = new BGSprite('road/clouds', -400, -200, 0.8, 0.8);
		clouds.setGraphicSize(Std.int(clouds.width * 1.6));
		clouds.updateHitbox();
		add(clouds);

		if(ClientPrefs.data.shaders)
			setupRainShader();
	}

	function setupRainShader()
	{
		rainShader = new RainShader();
		rainShader.scale = FlxG.height / 200;
		rainShaderStartIntensity = 0.1;
		rainShaderEndIntensity = 0.3;
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