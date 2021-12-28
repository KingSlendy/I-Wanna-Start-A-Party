var draw_x = (display_get_gui_width() - width) / 2;
var draw_y = (display_get_gui_height() - height) / 2;
draw_box(draw_x, draw_y + offset_y, width, height, c_dkgray);

for (var i = 0; i < array_length(stock); i++) {
	var item = stock[i];
	var text = new Text(fntDialogue, item.text + " {SPRITE,sprCoin,0,0,2,0.6,0.6} x" + string(item.price));
	text.draw(draw_x + 10, draw_y + 10 + 35 * i + offset_y);
	var text = new Text(fntDialogue, draw_option_afford(item.name, player_turn_info.coins >= item.price, i == option_selected));
	text.draw(draw_x + 160, draw_y + 10 + 35 * i + offset_y);
}