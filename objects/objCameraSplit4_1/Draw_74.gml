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
	
	switch (mode) {
		case 0: //Full
			var surf_x = width * (i % 2);
			var surf_y = height * (i div 2);
			break;
			
		case 1: //Vertical
			var surf_x = width * i;
			var surf_y = 0;
			break;
			
		case 2: //Horizontal
			var surf_x = 0;
			var surf_y = height * i;
			break;
	}
	
	draw_surface(surf, surf_x, surf_y);
	draw_set_font(fntPlayerInfo);
	draw_set_color(c_white);
	var name = target_follow[i].network_name;
	draw_text_outline(surf_x + 5, surf_y + height - string_height(name), name, c_black);
}
