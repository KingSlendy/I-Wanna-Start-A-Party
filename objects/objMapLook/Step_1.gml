objCamera.target_follow = {x: look_x, y: look_y};

if (!is_local_turn()) {
	exit;
}

if (!objGameManager.paused) {
	global.ignore_input = false;
}

var scroll_h = (global.actions.right.held(network_id) - global.actions.left.held(network_id));
var scroll_v = (global.actions.down.held(network_id) - global.actions.up.held(network_id));
look_x = clamp(look_x + scroll_h * 8, 0, room_width);
look_y = clamp(look_y + scroll_v * 8, 0, room_height);

if (!player_info_by_turn().can_map()) {
	end_map();
	exit;
}

if (global.actions.shoot.pressed(network_id)) {
	global.actions.shoot.consume();
	end_map();
	audio_play_sound(global.sound_cursor_back, 0, false);
	exit;
}

global.ignore_input = true;

buffer_seek_begin();
buffer_write_action(ClientUDP.MapLook);
buffer_write_data(buffer_f32, look_x);
buffer_write_data(buffer_f32, look_y);
network_send_udp_packet();