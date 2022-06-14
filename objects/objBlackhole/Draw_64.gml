var draw_x = (display_get_gui_width() - width) / 2;
var draw_y = (display_get_gui_height() - height) / 2;
draw_box(draw_x, draw_y + offset_y, width, height, c_blue,, 0.6,, 3);
var text = new Text(fntDialogue);

for (var i = 0; i < array_length(stock); i++) {
	var item = stock[i];
	text.set(item.text + draw_coins_price(item.price));
	text.draw(draw_x + 10, draw_y + 10 + 35 * i + offset_y);
	text.set(draw_option_afford(item.name, player_info.coins >= item.price && item.can_select, i == option_selected));
	text.draw(draw_x + 160, draw_y + 10 + 35 * i + offset_y);
}

text = new Text(fntControls);
text.set(draw_action_small(global.actions.jump) + " Select\n" + draw_action_small(global.actions.shoot) + " Cancel\n" + draw_action_small(global.actions.up) + draw_action_small(global.actions.down) + " Move");
text.draw(draw_x + 10, draw_y + 90 + offset_y);
