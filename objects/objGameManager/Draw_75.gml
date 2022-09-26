draw_set_color(c_black);
draw_rectangle(-display_get_gui_width(), 0, -1, display_get_gui_height(), false);
draw_rectangle(display_get_gui_width(), 0, display_get_gui_width() * 2 - 1, display_get_gui_height(), false);

pause_state = lerp(pause_state, paused, 0.2);

if (point_distance(pause_state, 0, paused, 0) < 0.01) {
	if (paused) {
		for (var i = 0; i < array_length(pause_options); i++) {
			pause_highlight[i] = lerp(pause_highlight[i], (i == pause_selected) ? 1 : 0.5, 0.2);
		}
	}
}

draw_set_alpha(pause_state * 0.5);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);

draw_set_alpha(pause_state);
draw_set_font(fntFilesInfo);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
pause_x = lerp(pause_x, pause_target_x, 0.2);
draw_text_color_outline(pause_x, 150, "PAUSE", c_red, c_red, c_orange, c_orange, draw_get_alpha(), c_black);

draw_set_font(fntFilesButtons);

for (var i = 0; i < array_length(pause_options); i++) {
	var highlight = pause_highlight[i];
	var color1 = (i != pause_selected) ? c_ltgray : c_green;
	var color2 = (i != pause_selected) ? c_white : c_lime;
	draw_text_transformed_color_outline(pause_x, 230 + 70 * i, pause_options[i], highlight, highlight, 0, color1, color1, color2, color2, highlight * draw_get_alpha(), c_black);
}

if (room != rSettings) {
	pause_target_x = 400;
	
	with (objSettings) {
		if (draw_target_x == 400) {
			other.pause_target_x -= 800;
		}
		
		draw = true;
		event_perform(ev_draw, ev_gui);
		draw = false;
	}
}

draw_set_halign(fa_left);
controls_text.set(draw_action_small(global.actions.jump) + " Accept   " + draw_action_small(global.actions.left) + draw_action_small(global.actions.up) + draw_action_small(global.actions.down) + draw_action_small(global.actions.right) + " Move    " + draw_action_small(global.actions.shoot) + " Cancel");
controls_text.draw(420, 580);

draw_set_valign(fa_top);
draw_set_alpha(1);