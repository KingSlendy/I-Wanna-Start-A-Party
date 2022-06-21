y = lerp(y, target_y, 0.2);

if (disappear) {
	image_alpha -= 0.075;
	
	if (image_alpha <= 0) {
		instance_destroy();
	}
	
	exit;
}

if (objMinigameController.info.is_finished || point_distance(x, y, x, target_y) > 3) {
	exit;
}

if (done && !disappear) {
	if (sprite_index == sprMinigame2vs2_Squares_Half1) {
		minigame4vs_points(objMinigameController.info, network_id, 1);
	}
	
	//minigame2vs2_points(objMinigameController.info, network_id, focus_player_by_id(network_id).teammate.network_id, 0.25);
	disappear = true;
	exit;
}

if (!is_player_local(network_id)) {
	exit;
}

var scroll = (global.actions.left.held(network_id) - global.actions.right.held(network_id));

if (scroll != 0) {
	image_angle = (image_angle + 360 + scroll * 5) % 360;
}

buffer_seek_begin();
buffer_write_action(ClientUDP.Minigame2vs2_Squares_Halfs);
buffer_write_data(buffer_u8, network_id);
buffer_write_data(buffer_u16, image_angle);
network_send_udp_packet();