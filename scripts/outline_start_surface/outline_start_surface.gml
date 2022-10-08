/// @arg thickness
/// @arg color
/// @arg surface
/// @arg OPTIONAL_accuracy
/// @arg OPTIONAL_tolerance
function outline_start_surface() {
	var _sur = argument[2];

	shader_set(sh_outline);

	var _tex = surface_get_texture(_sur);

	var _w = texture_get_texel_width(_tex);
	var _h = texture_get_texel_height(_tex);

	shader_set_uniform_f(uni_size, _w, _h);

	shader_set_uniform_f(uni_thick, argument[0]);

	shader_set_uniform_f(uni_color, color_get_red(argument[1])/255, color_get_green(argument[1])/255, color_get_blue(argument[1])/255);

	var acc;
	if (argument_count<=3) acc = 16;
	else acc = argument[3];

	shader_set_uniform_f(uni_acc, acc);

	var tol;
	if (argument_count<=4) tol = 0;
	else tol = argument[4];

	shader_set_uniform_f(uni_tol, tol);

	var uvs = texture_get_uvs(_sur);

	shader_set_uniform_f(uni_uvs, uvs[0], uvs[1], uvs[2], uvs[3]);
}