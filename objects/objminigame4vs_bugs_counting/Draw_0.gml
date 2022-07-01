draw_set_font(fntPlayerInfo);
draw_set_color(c_white);
draw_set_halign(fa_center);
var player = focus_player_by_id(network_id);
draw_text_outline(player.x, player.y - 40, string(count), c_black);
draw_set_halign(fa_left);

if (!is_player_local(network_id)) {
	exit;
}

if (selecting && count > 0) {
	draw_sprite_ext(bind_to_key(global.actions.left.button), 0, player.x - 35, player.y - 30, 0.35, 0.35, 0, c_white, 1);
}

if (selecting && count < 99) {
	draw_sprite_ext(bind_to_key(global.actions.right.button), 0, player.x + 35, player.y - 30, 0.35, 0.35, 0, c_white, 1);
}