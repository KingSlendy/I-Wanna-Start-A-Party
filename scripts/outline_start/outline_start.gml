function outline_start(thickness, color, sprite = sprite_index, accuracy = 16, tolerance = 0) {
	shader_set(sh_outline);
	var texture = sprite_get_texture(sprite, image_index);
	var w = texture_get_texel_width(texture);
	var h = texture_get_texel_height(texture);
	shader_set_uniform_f(uni_size, w, h);
	shader_set_uniform_f(uni_thick, thickness);
	shader_set_uniform_f(uni_color, color_get_red(color) / 255, color_get_green(color) / 255, color_get_blue(color) / 255);
	shader_set_uniform_f(uni_acc, accuracy);
	shader_set_uniform_f(uni_tol, tolerance);

	var uvs = sprite_get_uvs(sprite, image_index);
	shader_set_uniform_f(uni_uvs, uvs[0], uvs[1], uvs[2], uvs[3]);
}