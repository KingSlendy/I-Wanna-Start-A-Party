dir_y_float = (dir_y_float + 360 + 2) % 360;
dir_angle_float = (dir_angle_float + 360 + 3) % 360;
draw_sprite_ext(sprite_index, image_index, x, y + 4 * dcos(dir_y_float), image_xscale, image_yscale, image_angle + 5 * dsin(dir_angle_float), image_blend, image_alpha);
draw_sprite_stretched(sprResultsBonus, bonus.index, x, y + 4 * dcos(dir_y_float) + 16, 16 * image_xscale, 16 * image_yscale);