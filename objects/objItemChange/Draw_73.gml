if (used_item) {
	exit;
}

draw_set_alpha(animation_alpha);
language_set_font(global.fntDialogue);
var positive = (sign(amount) == 1);
draw_set_color((positive) ? c_blue : c_red);
draw_set_halign(fa_center);
focus_player = focus_player_by_id(network_id);
var text = (positive) ? language_get_text("PARTY_ITEM_GOT_ITEM") : language_get_text("PARTY_ITEM_LOST_ITEM");
draw_text_outline(focus_player.x, focus_player.y - 50, text, c_black);
draw_set_halign(fa_left);
draw_set_alpha(1);