if (!surface_exists(surf)) {
	surf = surface_create(room_width, room_height);
}

surface_set_target(surf);
draw_clear(c_black);

if (lights) {
	gpu_set_blendmode_ext_sepalpha(bm_src_alpha, bm_inv_src_alpha, bm_zero, bm_inv_src_alpha);
	draw_set_color(c_black);

	with (objPlayerBase) {
		if (!draw) {
			continue;
		}
	
		draw_sprite(other.spotlight, 0, x, y);
	}

	with (objMinigame1vs3_Host_Candle) {
		draw_sprite_ext(other.spotlight, 0, x + 16, y + 12, spotlight_size, spotlight_size, 0, c_orange, 1);
	}

	gpu_set_blendmode(bm_normal);
}

surface_reset_target();

draw_surface(surf, 0, 0);