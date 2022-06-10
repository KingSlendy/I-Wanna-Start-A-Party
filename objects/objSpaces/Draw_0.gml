draw_self();

if (glowing) {
	gpu_set_blendmode(bm_add);
	draw_self();
	draw_self();
	gpu_set_blendmode(bm_normal);
}