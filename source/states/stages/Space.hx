package states.stages;

import states.stages.objects.*;

import shaders.WiggleEffect;

class Space extends BaseStage
{
	var wiggleShader:WiggleEffect;
	
	override function create()
	{
		var space:BGSprite = new BGSprite('CoolSpace', -800, -400, 1.3, 1.3);
		space.setGraphicSize(Std.int(space.width * 2.4));
		space.updateHitbox();
		add(space);

		wiggleShader = new WiggleEffect();

		wiggleShader.waveAmplitude = 0.0;
		wiggleShader.waveFrequency = 0;
		wiggleShader.waveSpeed = 0;
		space.shader = wiggleShader.shader;

		if(ClientPrefs.data.shaders)
			wiggleShader.waveAmplitude = 0.1;
			wiggleShader.waveFrequency = 5;
			wiggleShader.waveSpeed = 2;
	}

	override function update(elapsed:Float)
	{
		wiggleShader.update(elapsed);
	}

	override function beatHit()
	{
		if(curBeat == 228)
		{
			FlxTween.tween(boyfriend, {alpha: 0}, 4, {
				ease: FlxEase.linear,
			});
			FlxTween.tween(gf, {alpha: 0}, 5, {
				ease: FlxEase.linear,
			});
		}
	}
}