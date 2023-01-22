draw_sprite_ext(sprite, timer * sprite_get_speed(sprite) / game_get_speed(gamespeed_fps), current_player.x, current_player.y - 50 + lengthdir_y(4, angle), scale, scale, 0, c_white, 1);
angle = (angle + 360 + 2) % 360;

if (state == -1 && !stealed) {
	controls_text.set(draw_action_small(global.actions.jump) + " Mash");
	controls_text.draw(current_player.x - 30, current_player.y + 20);
}