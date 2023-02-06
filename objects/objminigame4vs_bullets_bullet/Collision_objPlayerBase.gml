if (!is_player_local(other.network_id) || !touchable) {
	exit;
}

switch (image_index) {
	case 0: var points = 1; break;
	case 1: var points = 2; break;
	case 2: var points = -1; break;
	case 3: var points = -5; break;
}

if (points < 0 && minigame4vs_get_points(other.network_id) == 0) {
	exit;
}

minigame4vs_points(other.network_id, points);

if (minigame4vs_get_points(other.network_id) < 0) {
	minigame4vs_set_points(other.network_id, 0)
}

touchable = false;

if (is_player_local(other.network_id)) {
	buffer_seek_begin();
	buffer_write_action(ClientTCP.Minigame4vs_Bullets_Points);
	buffer_write_data(buffer_u8, other.network_id);
	buffer_write_data(buffer_s8, points);
	network_send_tcp_packet();
}