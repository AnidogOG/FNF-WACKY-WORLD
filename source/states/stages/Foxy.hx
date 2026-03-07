package states.stages;

import states.stages.objects.*;

class Foxy extends BaseStage
{
	override function create()
	{
		var bg:BGSprite = new BGSprite('sky', -400, -200, 0.9, 0.9);
		bg.setGraphicSize(Std.int(bg.width * 1.6));
		bg.updateHitbox();
		add(bg);

		var ground:BGSprite = new BGSprite('ground', -400, -180);
		ground.setGraphicSize((ground.width * 1.6));
		ground.updateHitbox();
		add(ground);

		var clouds:BGSprite = new BGSprite('clouds', -160, -200, 0.6, 0.6);
		clouds.setGraphicSize(Std.int(clouds.width * 1.3));
		clouds.updateHitbox();
		add(clouds);
	}
}