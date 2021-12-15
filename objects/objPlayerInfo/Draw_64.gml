if (player_info == null) {
	exit;
}

var draw_w = 240;
var draw_h = 90;
var draw_x = 0;
var draw_y = 0;

switch (player_info.turn) {
	case 1:
		draw_x = 0;
		draw_y = 0;
		break;
		
	case 2:
		draw_x = display_get_gui_width() - draw_w;
		draw_y = 0;
		break;
		
	case 3:
		draw_x = 0;
		draw_y = display_get_gui_height() - draw_h;
		break;
		
	case 4:
		draw_x = display_get_gui_width() - draw_w;
		draw_y = display_get_gui_height() - draw_h;
		break;
}

draw_sprite_stretched(sprite_index, 0, draw_x, draw_y, draw_w, draw_h);
draw_set_font(fntPlayerInfo);
draw_set_color(c_white);
draw_sprite(sprPlayerIdle, 0, draw_x + 25, draw_y + 23);
draw_sprite_ext(sprShine, 0, draw_x + 40, draw_y + 5, 0.5, 0.5, 0, c_white, 1);
draw_text_outline(draw_x + 70, draw_y + 10, "x" + string(player_info.shines), c_gray);
draw_sprite_ext(sprCoin, 0, draw_x + 46, draw_y + 40, 0.6, 0.6, 0, c_white, 1);
draw_text_outline(draw_x + 70, draw_y + 39, "x" + string(player_info.coins), c_gray);
draw_set_halign(fa_right);
draw_text_outline(draw_x + draw_w - 5, draw_y + 63, "?st", c_gray);
draw_set_halign(fa_left);
draw_text_outline(draw_x + 5, draw_y + 63, "", c_gray);