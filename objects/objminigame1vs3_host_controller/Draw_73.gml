var view_w = camera_get_view_width(view_camera[0]) + 1;
var view_h = camera_get_view_height(view_camera[0]) + 1;

if (!surface_exists(surf)) {
	surf = surface_create(view_w, view_h);
} else if (surface_get_width(view_w) < view_w || surface_get_height(view_h) < view_h) {
	surface_resize(surf, view_w, view_h);
}

var view_x = camera_get_view_x(view_camera[0]);
var view_y = camera_get_view_y(view_camera[0]);
surface_set_target(surf);
draw_clear(c_black);

if (lights) {
	gpu_set_blendmode_ext_sepalpha(bm_src_alpha, bm_inv_src_alpha, bm_zero, bm_inv_src_alpha);
	draw_set_color(c_black);

	with (objPlayerBase) {
		if (!draw) {
			continue;
		}
	
		draw_sprite(other.spotlight, 0, x - view_x, y - view_y);
	}

	with (objMinigame1vs3_Host_Candle) {
		draw_sprite_ext(other.spotlight, 0, x + 16 - view_x, y + 12 - view_y, spotlight_size, spotlight_size, 0, c_orange, 1);
	}

	gpu_set_blendmode(bm_normal);
}

surface_reset_target();

draw_surface(surf, view_x, view_y);