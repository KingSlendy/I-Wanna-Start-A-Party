function camera_start_pos(view_x, view_y, camera) {
	var c = instance_create_layer(0, 0, "Managers", camera);
	c.target_follow = {x: view_x, y: view_y};
	
	with (c) {
		init_view();
	}
}

function camera_start_follow(follow, camera) {
	var c = instance_create_layer(0, 0, "Managers", camera);
	c.target_follow = follow;
	
	with (c) {
		init_view();
	}
}