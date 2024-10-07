if (!is_player_local(other.network_id)) {
	exit;
}

if (other.onGround) {
    other.onGround = 0;
    other.zSpeed = bounceSpeed;
    other.drift = 0;
    other.driftSkid = 0;
}