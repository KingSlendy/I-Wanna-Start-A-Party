function camera_start(camera) {
	return camera_start_pos(0, 0, camera);
}

function camera_start_pos(view_x, view_y, camera) {
	var c = instance_create_layer(0, 0, "Managers", camera);
	c.target_follow = {x: view_x, y: view_y};
	
	with (c) {
		init_view();
	}
	
	return c;
}

function camera_start_follow(follow, camera) {
	var c = instance_create_layer(0, 0, "Managers", camera);
	c.target_follow = follow;
	
	with (c) {
		init_view();
	}

	return c;
}

function camera4vs_split4(camera) {
	for (var i = 0; i < global.player_max; i++) {
		with (camera) {
			target_follow[i] = focus_player_by_turn(i + 1);
			target_x[i] = target_follow[i].x;
			target_y[i] = target_follow[i].y;
			view_x[i] = target_x[i];
			view_y[i] = target_y[i];
		}
	}
	
	return camera;
}

function camera2vs2_split4(camera, info) {
	var index = false;

	for (var i = 1; i <= global.player_max; i++) {
		var player = focus_player_by_turn(i);
		var player_info = player_info_by_turn(i);
		
		if (player_info.space == info.player_colors[0]) {
			with (camera) {
				var j = (!index) ? 0 : 2;
				target_follow[j] = player;
				target_x[j] = target_follow[j].x;
				target_y[j] = target_follow[j].y;
				view_x[j] = target_x[j];
				view_y[j] = target_y[j];
			}
			
			index = !index;
		}
	}

	index = false;

	for (var i = 1; i <= global.player_max; i++) {
		var player = focus_player_by_turn(i);
		var player_info = player_info_by_turn(i);
		
		if (player_info.space == info.player_colors[1]) {
			with (camera) {
				var j = (!index) ? 1 : 3;
				target_follow[j] = player;
				target_x[j] = target_follow[j].x;
				target_y[j] = target_follow[j].y;
				view_x[j] = target_x[j];
				view_y[j] = target_y[j];
			}
			
			index = !index;
		}
	}
	
	camera.type = "2vs2";
	return camera;
}