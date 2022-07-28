draw_sprite_ext(sprPlayerRocket_Flame, 0, x + 34 * dcos(image_angle + 270), y - 34 * dsin(image_angle + 270), speed / 12, speed / 12, (image_angle + 360 + 180) % 360, c_white, 1);
draw_self();
draw_sprite_ext(skin[$ "Idle"], 0, x, y, 1, 1, image_angle, c_white, image_alpha);