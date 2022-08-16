if (player_info == null || (!IS_BOARD && room != rParty && room != rResults)) {
	exit;
}

with (objChanceTime) {
	if (started && !array_contains(player_ids, other.player_info.turn - 1)) {
		exit;
	}
}

draw_set_alpha(1);
draw_box(draw_x, draw_y, draw_w, draw_h, player_info.space, player_color_by_turn(player_info.turn), 0.8,, 3);
draw_set_color(c_black);
draw_circle(draw_x + 23, draw_y + 21, 16, false);
draw_set_color(player_color_by_turn(player_info.turn));
draw_circle(draw_x + 23, draw_y + 21, 15, false);
draw_set_font(fntPlayerInfo);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_sprite(player_idle_image, 0, draw_x + 25, draw_y + 23);
draw_sprite_ext(sprShine, 0, draw_x + 56, draw_y + 45, 0.5, 0.5, 0, c_white, 1);
draw_text_outline(draw_x + 70, draw_y + 33, string(player_info.shines), c_black);
draw_sprite_ext(sprCoin, 0, draw_x + 56, draw_y + 71, 0.6, 0.6, 0, c_white, 1);
draw_text_outline(draw_x + 70, draw_y + 59, string(player_info.coins), c_black);
draw_set_halign(fa_right);

for (var i = 0; i < min(array_length(player_info.items), 3); i++) {
	var item = player_info.items[i];
	
	if (item == null) {
		continue;
	}
	
	var item_x = draw_x + 160 + 35 * (i - 1);
	var item_y = draw_y + 25 + 35;
	
	if (i == 0) {
		item_x = draw_x + 160 + 35 / 2;
		item_y = draw_y + 25;
	}
	
	draw_sprite_ext(item.sprite, 0, item_x, item_y, 0.5, 0.5, 0, c_white, 1);
}

if (player_info.pokemon != -1) {
	draw_sprite_ext(player_info.pokemon, 0, draw_x + 100, draw_y - 15, 0.75, 0.75, 0, c_white, 1);
}

draw_sprite_ext(sprPlayerInfoPlaces, player_info.place - 1, draw_x + 10, draw_y + 57, 0.6, 0.6, 0, c_white, 1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_player_name(draw_x + 44, draw_y + 21, player_info.network_id);