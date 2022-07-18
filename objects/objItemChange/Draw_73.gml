if (used_item) {
	exit;
}

draw_set_alpha(animation_alpha);
var positive = (sign(amount) == 1);
draw_set_color((positive) ? c_blue : c_red);
draw_set_halign(fa_center);
focus_player = focus_player_by_id(network_id);
draw_text_outline(focus_player.x, focus_player.y - 50, ((positive) ? "Got" : "Lost") + " Item" + ((positive) ? "!" : "..."), c_black);
draw_set_halign(fa_left);
draw_set_alpha(1);