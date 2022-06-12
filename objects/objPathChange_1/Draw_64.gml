if (instance_exists(objMapLook)) {
	exit;
}

var text = new Text(fntControls);
text.set(draw_action_small(global.actions.jump) + " Select\n\n" + draw_action_small(global.actions.left) + draw_action_small(global.actions.up) + draw_action_small(global.actions.down) + draw_action_small(global.actions.right) + " Move\n\n" + draw_action_small(global.actions.shoot) + " Map");
text.draw(350, 350);
