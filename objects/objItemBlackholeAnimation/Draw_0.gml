draw_sprite_ext(sprite, 0, current_player.x, current_player.y - 50, scale, scale, 0, c_white, 1);

if (state == -1) {
	controls_text.set(draw_action_small(global.actions.jump) + " Mash");
	controls_text.draw(current_player.x - 10, current_player.y + 20);
}