var mode_initial = (mode_selected != -1) ? mode_selected : mode_prev;

for (var i = -2; i <= 2; i++) {
	var mode_current = (mode_initial + array_length(mode_buttons) + i) % array_length(mode_buttons);
	var button = mode_buttons[mode_current];
	button.pos[0] = 400 + 250 * i + mode_x;
	button.check((mode_selected != -1 && mode_selected == mode_current && mode_selected == mode_target_selected));
	button.draw(0);
}

draw_box(70, 400, 660, 150, c_gray, c_white, 0.5);
language_set_font(global.fntDialogue);
draw_set_color(c_white);
mode_text.set(mode_texts[mode_initial]);
mode_text.draw(80, 410, 640);
controls_text.set(draw_action_small(global.actions.jump) + " " + language_get_text("WORD_GENERIC_MENU_ACCEPT") + "   " + draw_action_small(global.actions.left) + draw_action_small(global.actions.up) + draw_action_small(global.actions.down) + draw_action_small(global.actions.right) + " " + language_get_text("WORD_GENERIC_MENU_MOVE") + "    " + draw_action_small(global.actions.shoot) + " " + language_get_text("WORD_GENERIC_MENU_CANCEL"));
controls_text.draw(420, 580);