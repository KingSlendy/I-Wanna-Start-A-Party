if (dialogue_sprite == noone) {
	var surf = surface_create(width, height);

	surface_set_target(surf);
	draw_clear_alpha(c_black, 0);
	draw_box(0, 0, width, height, c_dkgray);
	surface_reset_target();

	dialogue_sprite = sprite_create_from_surface(surf, 0, 0, width, height, false, false, 0, 0);
}

draw_sprite_ext(dialogue_sprite, 0, x, y, 1, 1, 0, c_white, image_alpha);

if (!surface_exists(text_surf)) {
	text_surf = surface_create(width - border_width * 2, height);
}

surface_set_target(text_surf);
draw_clear_alpha(c_black, 0);
var max_height = text_display.text.draw(4, 2, width - border_width * 2);
var answers = array_length(text_display.branches);

if (array_length(answer_displays) > 0 && answers > 0 && !text_display.text.tw_active) {
	draw_set_font(fntDialogue);
	draw_set_color(c_white);
	
	for (var i = 0; i < answers; i++) {
		var display = answer_displays[i];
		var text = "";
		
		if (i == answer_index) {
			text = "{RAINBOW}{WAVE}";
		}

		display.set(text + text_display.branches[i][0])
		display.draw(4, max_height + string_height("W") * (i + 1));
	}
}

var text = new Text(fntDialogue, draw_action_small(global.actions.jump));
text.draw(440, 110);
surface_reset_target();

draw_surface_ext(text_surf, x + border_width, y + border_width, 1, 1, 0, c_white, image_alpha);