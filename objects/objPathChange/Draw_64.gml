if (instance_exists(objMapLook)) {
	exit;
}

var text = new Text(global.fntControls);
text.set(draw_action_small(global.actions.jump) + " " + language_get_text("WORD_GENERIC_MENU_SELECT") + "\n" + draw_action_small(global.actions.left) + draw_action_small(global.actions.up) + draw_action_small(global.actions.down) + draw_action_small(global.actions.right) + " " + language_get_text("WORD_GENERIC_MENU_MOVE"));
text.draw(350, 350);