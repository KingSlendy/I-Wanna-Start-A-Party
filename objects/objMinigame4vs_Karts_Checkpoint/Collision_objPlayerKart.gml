var player = other;

if (!is_player_local(player.network_id)) {
	exit;
}

if (ID != 0) {
    if (other.lap_checkpoint == ID - 1) {
        other.lap_checkpoint = ID;
        other.check_x = check_x;
        other.check_y = check_y;
        other.check_dir = check_dir;
		
		if (other.agent != null) {
			other.agent.check_position = other.agent.path_position;
		}
    }
} else if (other.lap_checkpoint == num_cps - 1) {
    other.check_x = check_x;
    other.check_y = check_y;
    other.check_dir = check_dir;
	
	if (other.agent != null) {
		other.agent.check_position = other.agent.path_position;
	}
	
	other.lap_checkpoint = 0;
	
	with (objMinigameController) {
		kart_count_lap(player.network_id);
	}
}