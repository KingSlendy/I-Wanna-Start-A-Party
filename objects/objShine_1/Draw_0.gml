y_float = y + 4 * dcos(dir_y_float);
angle_float = image_angle + 5 * dsin(dir_angle_float);
dir_y_float = (dir_y_float + 360 + 2) % 360;
dir_angle_float = (dir_angle_float + 360 + 3) % 360;

if (floating) {
	draw_sprite_ext(sprite_index, image_index, x, y_float, image_xscale, image_yscale, angle_float, image_blend, image_alpha);
} else {
	draw_self();
}