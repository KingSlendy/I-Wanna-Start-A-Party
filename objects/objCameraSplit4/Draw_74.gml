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
	
	if (draw_names) {
		language_set_font(global.fntPlayerInfo);
		draw_set_color(c_white);
		var name_x = surf_x + 20;
		var name_y = surf_y + height - 16;
		
		if (room != rMinigame4vs_Tower && room != rMinigame4vs_Jingle && room != rMinigame2vs2_Duos) {
			switch (i) {
				case 0:
					name_x = surf_x + 20;
					name_y = surf_y + 16;
					break;
					
				case 1:
					name_x = surf_x + width - 95;
					name_y = surf_y + 16;
					break;
					
				case 2:
					name_x = surf_x + 20;
					name_y = surf_y + height - 16;
					break;
				
				case 3:
					name_x = surf_x + width - 95;
					name_y = surf_y + height - 16;
					break;
			}
		}
		
		draw_player_name(name_x, name_y, target_follow[i].network_id);
	}
}