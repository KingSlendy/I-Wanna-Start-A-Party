if (global.actions.shoot.pressed(network_id)) {
	audio_play_sound(global.sound_cursor_back, 0, false);
	io_clear();
	end_map();
	exit;
}

var cam = view_camera[0];
var cam_w = camera_get_view_width(cam);
var cam_h = camera_get_view_height(cam);
var scroll_h = (global.actions.right.held(network_id) - global.actions.left.held(network_id));
var scroll_v = (global.actions.down.held(network_id) - global.actions.up.held(network_id));
look_x += scroll_h * 8;
look_y += scroll_v * 8;
look_x = clamp(look_x, 0, room_width - cam_w * 0.25);
look_y = clamp(look_y, 0, room_height - cam_h * 0.25);
objCamera.target_follow = {x: look_x, y: look_y};

if (is_local_turn()) {
	buffer_seek_begin();
	buffer_write_action(ClientUDP.MapLook);
	buffer_write_data(buffer_f32, look_x);
	buffer_write_data(buffer_f32, look_y);
	network_send_udp_packet();
}
