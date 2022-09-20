draw_sprite_ext(sprPlayerRocket_Flame, 0, x + 34 * dcos(image_angle + 270), y - 34 * dsin(image_angle + 270), spd / 12, spd / 12, (image_angle + 360 + 180) % 360, c_white, 1);
draw_sprite_ext(sprPlayerRocket, 0, x, y, 1, 1, image_angle, c_white, image_alpha);
draw_sprite_ext(sprite_index, 0, x, y, 1, 1, image_angle, c_white, image_alpha);