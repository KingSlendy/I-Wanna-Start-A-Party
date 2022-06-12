ang = (ang + 360 + 4) % 360;

gpu_set_blendmode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y + 4 * dcos(ang), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
gpu_set_blendmode(bm_normal);

if (lookout) {
	draw_set_font(fntFilesInfo);
	draw_set_color(c_red);
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);
	draw_text_outline(x, y - sprite_height / 2 - 5, "!", c_black);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
}
