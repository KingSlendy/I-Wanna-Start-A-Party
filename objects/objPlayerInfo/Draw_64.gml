if (player_info == null || !IS_BOARD) {
	exit;
}

with (objChanceTime) {
	if (started && !array_contains(player_ids, other.player_info.turn - 1)) {
		exit;
	}
}

draw_set_alpha(1);
draw_box(draw_x, draw_y, draw_w, draw_h, player_info.space);
draw_set_font(fntPlayerInfo);

switch (player_info.turn) {
	case 1:
		draw_set_color(c_blue);
		break;
		
	case 2:
		draw_set_color(c_red);
		break;
		
	case 3:
		draw_set_color(c_green);
		break;
		
	case 4:
		draw_set_color(c_yellow);
		break;
}

draw_circle(draw_x + 23, draw_y + 21, 15, false);
draw_set_color(c_white);
draw_sprite(player_idle_image, 0, draw_x + 25, draw_y + 23);
var text = new Text(fntPlayerInfo, "{SPRITE,sprShine,0,0,-4,0.5,0.5}x" + string(player_info.shines));
text.draw(draw_x + 40, draw_y + 10);
var text = new Text(fntPlayerInfo, "{SPRITE,sprCoin,0,0,2,0.6,0.6} x" + string(player_info.coins));
text.draw(draw_x + 46, draw_y + 36);
draw_set_halign(fa_right);

for (var i = 0; i < array_length(player_info.items); i++) {
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
draw_text_outline(draw_x + 5, draw_y + 63, player_info.name, c_black);