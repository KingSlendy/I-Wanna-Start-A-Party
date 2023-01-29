var draw_x = (display_get_gui_width() - width) / 2;
var draw_y = (display_get_gui_height() - height) / 2;
draw_box(draw_x, draw_y + offset_y, width, height, c_dkgray, c_white, 0.6,, 3);
var text = new Text(fntDialogue);

for (var i = 0; i < array_length(stock); i++) {
	var item = stock[i];
	var price = item.price;
		
	if (room == rBoardBaba && global.baba_toggled[2]) {
		switch (global.baba_blocks[2]) {
			case 0: price *= 2; break;
			case 1: price /= 2; break;
			case 2: price = 0; break;
		}
			
		price = floor(price);
	}
	
	text.set("{SPRITE," + sprite_get_name(item.sprite) + "," + string(timer * sprite_get_speed(item.sprite) / game_get_speed(gamespeed_fps)) +  ",0,-2,0.5,0.5} " + draw_coins_price(price));
	text.draw(draw_x + 10, draw_y + 10 + 35 * i + offset_y);
	text.set(draw_option_afford(item.name, player_info.coins >= price, i == option_selected));
	text.draw(draw_x + 160, draw_y + 10 + 35 * i + offset_y);
}

text = new Text(fntControls);
text.set(draw_action_small(global.actions.jump) + " Select\n" + draw_action_small(global.actions.shoot) + " Cancel\n" + draw_action_small(global.actions.up) + draw_action_small(global.actions.down) + " Move");
text.draw(draw_x + 10, draw_y + 200 + offset_y);