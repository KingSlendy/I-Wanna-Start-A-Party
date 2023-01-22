draw_sprite_ext(sprite, timer * sprite_get_speed(sprite) / game_get_speed(gamespeed_fps), space_current.x, space_current.y - 50 + lengthdir_y(4, angle), scale, scale, 0, c_white, 1);
draw_sprite_ext(sprite, timer * sprite_get_speed(sprite) / game_get_speed(gamespeed_fps), space_shine.x, space_shine.y - 50 + lengthdir_y(4, angle), scale, scale, 0, c_white, 1);
angle = (angle + 360 + 2) % 360;