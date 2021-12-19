draw_set_alpha(animation_alpha);
var positive = (sign(amount) == 1);
draw_set_color((positive) ? c_blue : c_red);
draw_set_halign(fa_center);
var focus = focused_player_turn();
draw_sprite_ext(sprCoin, 0, focus.x - 12, focus.y - 40, 1, 1, 0, c_white, animation_alpha);
draw_text_outline(focus.x + 20, focus.y - 50, ((positive) ? "+" : "-") + string(abs(amount)), c_black);
draw_set_halign(fa_left);
draw_set_alpha(1);