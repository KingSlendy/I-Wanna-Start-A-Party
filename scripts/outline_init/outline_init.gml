function outline_init() {
	uni_size = shader_get_uniform(sh_outline, "size");
	uni_thick = shader_get_uniform(sh_outline, "thick");
	uni_color = shader_get_uniform(sh_outline, "oColor");
	uni_acc = shader_get_uniform(sh_outline, "accuracy");
	uni_tol = shader_get_uniform(sh_outline, "tol");
	uni_uvs = shader_get_uniform(sh_outline, "uvs");
}