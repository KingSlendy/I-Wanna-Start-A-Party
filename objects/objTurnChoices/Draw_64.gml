var focus = focused_player();
var draw_x = display_get_gui_width() / 2 - 100;
var draw_y = display_get_gui_height() / 2 - 50;
var text = new Text(fntDialogue);
draw_set_alpha(image_alpha);
	
for (var i = 0; i < array_length(choice_texts); i++) {
	var option_x = draw_x - 10 * i;
	var option_y = draw_y + 40 * i;
	draw_box(option_x, option_y, 80, 35, (i == option_selected) ? c_ltgray : c_dkgray, c_white,,, 1);
	text.set(draw_option_afford(choice_texts[i], i != 1 || available_item, i == option_selected));
	text.draw(option_x + 17, option_y + 5);
	var player_info = player_info_by_turn();
	
	if (i == 0 && player_info.item_effect != null) {
		draw_sprite_ext(global.board_items[player_info.item_effect].sprite, 0, option_x - 25, option_y + 15, 0.5, 0.5, 0, c_white, image_alpha);
	}
}
	
text = new Text(fntControls);
text.set(draw_action_small(global.actions.jump) + " Select\n" + draw_action_small(global.actions.up) + draw_action_small(global.actions.down) + " Move");
text.draw(draw_x - 20, draw_y + 80);
draw_set_alpha(1);