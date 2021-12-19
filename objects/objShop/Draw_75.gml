var draw_x = (display_get_gui_width() - width) / 2;
var draw_y = (display_get_gui_height() - height) / 2;
draw_sprite_ext(sprBoxFill, 0, draw_x, draw_y, width, height, 0, c_dkgray, 1);
draw_sprite_stretched(sprBoxFrame, 0, draw_x, draw_y, width, height);

for (var i = 0; i < array_length(stock); i++) {
	var item = stock[i];
	var selected = "";
	
	if (i == option_selected) {
		selected += "{RAINBOW}{WAVE}";
	}
	
	var show_price = string(item.price);
	
	repeat (3 - string_length(show_price)) {
		show_price += "  ";
	}
	
	var text = new Text(fntDialogue, "{SPRITE," + sprite_get_name(item.sprite) +",0,0,-2,0.5,0.5} {SPRITE,sprCoin,0,0,2,0.6,0.6} x" + show_price + "  " + selected + item.name);
	text.draw(draw_x + 10, draw_y + 10 + 35 * i);
}