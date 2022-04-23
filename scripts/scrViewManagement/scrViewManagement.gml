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

function camera_4vs_split4(camera) {
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

function camera_2vs2_split4(camera, info) {
	var index = false;

	with (objPlayerInfo) {
		if (player_info.space == info.player_colors[0]) {
			with (camera) {
				var i = (!index) ? 0 : 2;
				target_follow[i] = focus_player_by_id(other.player_info.network_id);
				target_x[i] = target_follow[i].x;
				target_y[i] = target_follow[i].y;
				view_x[i] = target_x[i];
				view_y[i] = target_y[i];
			}
			
			index = !index;
		}
	}

	index = false;

	with (objPlayerInfo) {
		if (player_info.space == info.player_colors[1]) {
			with (camera) {
				var i = (!index) ? 1 : 3;
				target_follow[i] = focus_player_by_id(other.player_info.network_id);
				target_x[i] = target_follow[i].x;
				target_y[i] = target_follow[i].y;
				view_x[i] = target_x[i];
				view_y[i] = target_y[i];
			}
			
			index = !index;
		}
	}
	
	camera.type = "2vs2";
	return camera;
}