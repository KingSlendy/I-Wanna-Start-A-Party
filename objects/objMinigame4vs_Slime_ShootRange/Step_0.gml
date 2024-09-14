with (objPlayerBase) {
	if (!is_player_local(network_id)) {
		continue;
	}
	
	enable_shoot = false;
}

with (instance_place(x, y, objPlayerBase)) {
	if (!is_player_local(network_id)) {
		break;
	}
	
	enable_shoot = true;
}