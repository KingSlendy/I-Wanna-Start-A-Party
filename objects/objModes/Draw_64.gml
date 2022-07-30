for (var i = 0; i < array_length(mode_buttons); i++) {
	var button = mode_buttons[i];
		
	if (button == null) {
		continue;
	}
		
	button.check(mode_selected == i);
	button.draw(0);
}

text = new Text(fntControls);
text.set(draw_action_small(global.actions.jump) + " Accept   " + draw_action_small(global.actions.left) + draw_action_small(global.actions.up) + draw_action_small(global.actions.down) + draw_action_small(global.actions.right) + " Move    " + draw_action_small(global.actions.shoot) + " Cancel");
text.draw(420, 580);