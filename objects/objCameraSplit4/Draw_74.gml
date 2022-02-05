for (var i = 0; i < global.player_max; i++) {
	var surf = view_surfs[i];
	var camera = view_camera[i];
	var width = camera_get_view_width(camera);
	var height = camera_get_view_height(camera);
	
	if (!surface_exists(surf)) {
		view_surfs[i] = surface_create(width, height);
		surf = view_surfs[i];
		view_surface_id[i] = surf;
	}
	
	var surf_x = width * (i % 2);
	var surf_y = height * (i div 2);
	draw_surface(surf, surf_x, surf_y);
}