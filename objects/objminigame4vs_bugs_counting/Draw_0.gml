draw_set_font(fntPlayerInfo);
draw_set_color(c_white);
draw_set_halign(fa_center);
var player = focus_player_by_turn(player_turn);
draw_text_outline(player.x, player.y - 40, string(count), c_black);
draw_set_halign(fa_left);

if (!is_player_local(player.network_id)) {
	exit;
}

if (selecting && count > 0) {
	draw_sprite_ext(global.actions.left.bind(), 0, player.x - 35, player.y - 30, 0.35, 0.35, 0, c_white, 1);
}

if (selecting && count < 99) {
	draw_sprite_ext(global.actions.right.bind(), 0, player.x + 35, player.y - 30, 0.35, 0.35, 0, c_white, 1);
}