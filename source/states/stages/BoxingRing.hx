package states.stages;

import states.stages.objects.*;

class BoxingRing extends BaseStage
{
	override function create()
	{
		var sky:BGSprite = new BGSprite('boxring/sky', -400, -200, 0.9, 0.9);
		sky.setGraphicSize(Std.int(sky.width * 1.6));
		sky.updateHitbox();
		add(sky);

		var floor:BGSprite = new BGSprite('boxring/stage', -400, 0);
		floor.setGraphicSize((floor.width * 1.6));
		floor.updateHitbox();
		add(floor);
	}
}