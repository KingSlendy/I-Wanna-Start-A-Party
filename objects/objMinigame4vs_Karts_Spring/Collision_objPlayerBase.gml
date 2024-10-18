if (!is_player_local(other.network_id)) {
	exit;
}

if (other.on_ground) {
    other.on_ground = 0;
    other.zspeed = bounceSpeed;
    other.drift = 0;
    other.drift_skid = 0;
	
	if (other.network_id == global.player_id) {
		objMinigameController.trophy_spring = false;
	}
}