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
		
	default: exit;
}

try {
	var idle = get_skin_pose(focus_player(player_info.network_id).sprite_index, "Idle");
} catch (_) {
	exit;
}

draw_set_alpha(1);
draw_box(draw_x, draw_y, draw_w, draw_h, player_info.space);
draw_set_font(fntPlayerInfo);
draw_set_color(c_dkgray);
draw_circle(draw_x + 23, draw_y + 21, 15, false);
draw_set_color(c_white);
draw_sprite(idle, 0, draw_x + 25, draw_y + 23);
var text = new Text(fntPlayerInfo, "{SPRITE,sprShine,0,0,-4,0.5,0.5}x" + string(player_info.shines));
text.draw(draw_x + 40, draw_y + 10);
var text = new Text(fntPlayerInfo, "{SPRITE,sprCoin,0,0,2,0.6,0.6} x" + string(player_info.coins));
text.draw(draw_x + 46, draw_y + 36);
draw_set_halign(fa_right);

for (var i = 0; i < 3; i++) {
	var item = player_info.items[i];
	
	if (item == null) {
		continue;
	}
	
	draw_sprite_ext(item.sprite, 0, draw_x + 150 + 35 * i, draw_y + 20, 0.5, 0.5, 0, c_white, 1);
}

var place = "?st";

switch (player_info.place) {
	case 1:
		draw_set_color(c_yellow);
		place = "1st";
		break;
		
	case 2:
		draw_set_color(c_ltgray);
		place = "2nd";
		break;
		
	case 3:
		draw_set_color(make_color_rgb(205, 127, 50));
		place = "3rd";
		break;
		
	case 4:
		draw_set_color(make_color_hsv(104, 133, 99));
		place = "4th";
		break;
}

draw_text_outline(draw_x + draw_w - 5, draw_y + 63, place, c_black);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_text_outline(draw_x + 5, draw_y + 63, "", c_black);