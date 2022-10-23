if (image_xscale < 3.5 || other.touched || objMinigameController.info.is_finished) {
	exit;
}

other.touched = true;
alarm[0] = 1;

if (!is_player_local(other.network_id)) {
	exit;
}

var points = -1;

if (image_index == 0 || image_index == 1) {
	points = image_index + 1;
	audio_play_sound(sndMinigamePointsA, 0, false);
} else if (minigame4vs_get_points(other.network_id) > 0) {
	audio_play_sound(sndMinigamePointsF, 0, false);
}

if (points == -1 && minigame4vs_get_points(other.network_id) == 0) {
	exit;
}

minigame4vs_points(other.network_id, points);

buffer_seek_begin();
buffer_write_action(ClientTCP.Minigame4vs_Sky_Points);
buffer_write_data(buffer_u8, other.network_id);
buffer_write_data(buffer_s8, points);
network_send_tcp_packet();