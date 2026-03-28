package states.stages;

import states.stages.objects.*;

class Forest extends BaseStage
{
	override function create()
	{
		var sky:BGSprite = new BGSprite('forest/sky', -400, -180, 0.9, 0.9);
		sky.setGraphicSize(Std.int(sky.width * 1.7));
		sky.updateHitbox();
		add(sky);

		var foreground:BGSprite = new BGSprite('forest/foreground', -400, -200);
		foreground.setGraphicSize((foreground.width * 1.7));
		foreground.updateHitbox();
		add(foreground);

		var trees:BGSprite = new BGSprite('forest/trees', -400, -180);
		trees.setGraphicSize(Std.int(trees.width * 1.7));
		trees.updateHitbox();
		add(trees);

		var ground:BGSprite = new BGSprite('forest/ground', -400, -200);
		ground.setGraphicSize((ground.width * 1.7));
		ground.updateHitbox();
		add(ground);
	}
}