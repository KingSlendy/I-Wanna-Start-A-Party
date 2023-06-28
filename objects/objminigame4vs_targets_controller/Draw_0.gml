event_inherited();

draw_sprite_ext(sprBullet, 0, 32, 470, 3, 3, 0, c_white, 1);
language_set_font(fntDialogue);
draw_set_color(c_white);
draw_set_valign(fa_middle);
draw_text_outline(48, 470, string(player_bullets[player_turn - 1]), c_black);
draw_set_valign(fa_top);