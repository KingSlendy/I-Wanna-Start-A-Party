for (var i = 0; i < global.player_max; i++) {
	var follow = target_follow[i];
		
	//Position the view to the target coordinates
	var width = camera_get_view_width(view_camera[i]);
	var height = camera_get_view_height(view_camera[i]);
	
	if (!lock_x && !dead[i]) {
		target_x[i] = follow.x;
	}
	
	//if (lock_x) {
	//	target_x[i] = width * (player_info_by_id(follow.network_id).turn - 1) + width / 2;
	//}
	
	if (!lock_y && !dead[i]) {
		target_y[i] = follow.y;
	}

	if (room == rMinigame2vs2_Duos && lock_y) {
		target_y[i] = height * (player_info_by_id(follow.network_id).turn - 1) + height / 2;
	}
	
	view_x[i] = lerp(view_x[i], target_x[i], view_spd);
	view_y[i] = lerp(view_y[i], target_y[i], view_spd);
	
	//Clamp the view to the room boundaries if the variable is set to true
	if (boundaries) {
		view_x[i] = clamp(view_x[i], width / 2, room_width - width / 2);
		view_y[i] = clamp(view_y[i], height / 2, room_height - height / 2);
	}
	
	camera_set_view_pos(view_camera[i], view_x[i] - width / 2, view_y[i] - height / 2);
}