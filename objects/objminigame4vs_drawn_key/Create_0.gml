image_speed = random_range(0.9, 1);
image_index = random(image_number - 1);

alarms_init(1);

alarm_create(function() {
	visible = true;
})

function collect_key(player_id, network = true) {
	var points;
	
	switch (image_blend) {
		case c_lime: points = 1; break;
		case c_yellow: points = 3; break;
		case c_red: points = 5; break;
	}
	
	minigame4vs_points(player_id, points);
	
	if (player_id == global.player_id && image_blend == c_lime) {
		objMinigameController.trophy_green = false;
	}
	
	visible = false;
	audio_play_sound(sndMinigame4vs_Drawn_Keys, 0, false);
	alarm_call(0, random_range(2, 4));
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame4vs_Drawn_CollectKey);
		buffer_write_data(buffer_u8, player_id);
		buffer_write_data(buffer_s32, x);
		buffer_write_data(buffer_s32, y);
		network_send_tcp_packet();
	}
}