draw_self();

var indicate = (indicator && instance_exists(objMapLook));

if (glowing || indicate) {
	gpu_set_blendmode(bm_add);
	draw_self();
	draw_self();
	gpu_set_blendmode(bm_normal);
}

if (indicate) {
	draw_sprite(sprSpacesIndicator, 0, x, y);
}