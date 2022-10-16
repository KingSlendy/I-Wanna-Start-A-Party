var mode_initial = (mode_selected != -1) ? mode_selected : mode_prev;

for (var i = -2; i <= 2; i++) {
	var mode_current = (mode_initial + array_length(mode_buttons) + i) % array_length(mode_buttons);
	var button = mode_buttons[mode_current];
	button.pos[0] = 400 + 250 * i + mode_x;
	button.check((mode_selected != -1 && mode_selected == mode_current && mode_selected == mode_target_selected));
	button.draw(0);
}

draw_box(70, 400, 660, 150, c_gray, c_aqua, 0.5);
draw_set_font(fntDialogue);
draw_set_color(c_white);
draw_text_ext_outline(80, 410, mode_texts[mode_initial], -1, 640, c_black);
controls_text.set(draw_action_small(global.actions.jump) + " Accept   " + draw_action_small(global.actions.left) + draw_action_small(global.actions.right) + " Move    " + draw_action_small(global.actions.shoot) + " Cancel");
controls_text.draw(466, 580);