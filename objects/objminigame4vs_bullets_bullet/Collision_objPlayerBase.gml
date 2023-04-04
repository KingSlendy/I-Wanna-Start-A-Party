if (!is_player_local(other.network_id)) {
	exit;
}

with (other) {
	if (other.image_index == 0) {
		if (vspd > 2) {
			vspd = 2;
		}
		
		reset_jumps();
	} else {
		player_kill();	
	}
}