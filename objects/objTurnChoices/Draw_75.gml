var focus = focused_player_turn();
var draw_x = focus.x - camera_get_view_x(view_camera[0]) - 100;
var draw_y = focus.y - camera_get_view_y(view_camera[0]) - 50;
var text = new Text(fntDialogue);
draw_set_alpha(image_alpha);
	
for (var i = 0; i < array_length(choice_texts); i++) {
	var option_x = draw_x - 10 * i;
	var option_y = draw_y + 35 * i;
	draw_box(option_x, option_y, 80, 30, (i == option_selected) ? c_gray : c_dkgray);
	text.set(draw_option_afford(choice_texts[i], i != 1 || available_item, i == option_selected));
	text.draw(option_x + 10, option_y + 3);
	var player_turn_info = get_player_turn_info();
	
	if (i == 0 && player_turn_info.item_effect != null) {
		draw_sprite_ext(global.board_items[player_turn_info.item_effect].sprite, 0, option_x - 25, option_y + 15, 0.5, 0.5, 0, c_white, image_alpha);
	}
}
	
draw_set_alpha(1);