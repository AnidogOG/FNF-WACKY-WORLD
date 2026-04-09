package states.stages;

import states.stages.objects.*;

class Field extends BaseStage
{
	override function create()
	{
		var sky:BGSprite = new BGSprite('field/sky', -400, -200, 0.9, 0.9);
		sky.setGraphicSize(Std.int(sky.width * 1.6));
		sky.updateHitbox();
		add(sky);

		var ground:BGSprite = new BGSprite('field/ground', -400, -180);
		ground.setGraphicSize((ground.width * 1.6));
		ground.updateHitbox();
		add(ground);

		var clouds:BGSprite = new BGSprite('field/clouds', -180, -300, 0.6, 0.6);
		clouds.setGraphicSize(Std.int(clouds.width * 1.35));
		clouds.updateHitbox();
		add(clouds);
	}
}