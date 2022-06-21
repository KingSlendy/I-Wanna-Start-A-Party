dir_y_float = (dir_y_float + 360 + 2) % 360;
dir_angle_float = (dir_angle_float + 360 + 3) % 360;
draw_sprite_ext(sprite_index, image_index, x, y + 4 * dcos(dir_y_float), image_xscale, image_yscale, image_angle + 5 * dsin(dir_angle_float), image_blend, image_alpha);
var xoff = sprite_get_xoffset(bonus.sprite);
var yoff = sprite_get_yoffset(bonus.sprite);
var w = sprite_get_width(bonus.sprite);
var h = sprite_get_height(bonus.sprite);
sprite_set_offset(bonus.sprite, w / 2, h / 2);
draw_sprite_stretched(bonus.sprite, bonus.index, x, y + 4 * dcos(dir_y_float) + 16, 16 * image_xscale, 16 * image_yscale);
sprite_set_offset(bonus.sprite, xoff, yoff);