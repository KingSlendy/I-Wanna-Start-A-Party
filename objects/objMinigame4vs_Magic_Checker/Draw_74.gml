if (!surface_exists(surf)) {
	surf = surface_create(352, 160);
	view_surface_id[6] = surf;
}

var surf_w = 352 * 0.8;
var surf_h = 160 * 0.8;
draw_set_alpha(view_alpha);
draw_surface_stretched(surf, 400 - surf_w / 2, (304 - 48) - surf_h / 2, surf_w, surf_h);
draw_set_alpha(1);