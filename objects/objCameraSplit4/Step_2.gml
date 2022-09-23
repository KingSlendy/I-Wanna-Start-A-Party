for (var i = 0; i < global.player_max; i++) {
	var follow = target_follow[i];
	var view_w_half = floor(view_w / 2);
	var view_h_half = floor(view_h / 2);
		
	//Position the view to the target coordinates
	if (!lock_x && !dead[i]) {
		target_x[i] = follow.x;
	}
	
	//if (lock_x) {
	//	target_x[i] = width * (player_info_by_id(follow.network_id).turn - 1) + width / 2;
	//}
	
	if (!lock_y && !dead[i]) {
		target_y[i] = follow.y;
	}

	if ((room == rMinigame1vs3_Race || room == rMinigame2vs2_Duos) && lock_y) {
		target_y[i] = view_h * i + view_h_half;
	}
	
	view_x[i] = lerp(view_x[i], target_x[i] - view_w_half, view_spd);
	view_y[i] = lerp(view_y[i], target_y[i] - view_h_half, view_spd);
	
	//Clamp the view to the room boundaries if the variable is set to true
	if (boundaries) {
		view_x[i] = clamp(view_x[i], 0, room_width - view_w);
		view_y[i] = clamp(view_y[i], 0, room_height - view_h);
	}
	
	camera_set_view_pos(view_camera[i], view_x[i], view_y[i]);
}