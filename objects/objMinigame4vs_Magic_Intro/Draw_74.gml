if (!draw_views) {
	exit;
}

if (!surface_exists(surf)) {
	surf = surface_create(416, 320);
	view_surface_id[6] = surf;
}

if (!surface_exists(surf2)) {
	surf2 = surface_create(800, 608);
	view_surface_id[7] = surf2;
}

draw_surface(surf2, 0, 0);
draw_surface(surf, 192 + show_view_x, 144 + show_view_y);
