package states.stages;

import states.stages.objects.*;

class Foxy extends BaseStage
{
	override function create()
	{
		var bg:BGSprite = new BGSprite('sky', -600, -200);
		add(bg);

		var ground:BGSprite = new BGSprite('ground', -600, -200);
		ground.setGraphicSize(1.2);
		ground.updateHitbox();
		add(ground);

		var clouds:BGSprite = new BGSprite('clouds', -600, -200);
		clouds.setGraphicSize(1.2);
		clouds.updateHitbox();
		add(clouds);
	}
}