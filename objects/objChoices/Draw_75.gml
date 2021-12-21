var focus = focused_player_turn();
var draw_x = focus.x - camera_get_view_x(view_camera[0]) - 100;
var draw_y = focus.y - camera_get_view_y(view_camera[0]) - 50;
var text = new Text(fntDialogue);
draw_set_alpha(image_alpha);
	
for (var i = 0; i < array_length(choice_texts); i++) {
	var option_x = draw_x - 10 * i;
	var option_y = draw_y + 35 * i;
	draw_box(option_x, option_y, 80, 30, c_dkgray);
	var selected = "";
		
	if (i == choice_selected) {
		selected += "{RAINBOW}{WAVE}";
	}
		
	text.set(selected + choice_texts[i]);
	text.draw(option_x + 10, option_y + 3);
}
	
draw_set_alpha(1);
