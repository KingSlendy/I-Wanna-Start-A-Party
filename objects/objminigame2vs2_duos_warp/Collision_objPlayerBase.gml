if (!is_player_local(other.network_id) || !enabled || other.vspd >= 0) {
	exit;
}

var player = other;
player.vspd = 0;
player.grav = 0;
player.jump_left = 0;

if (target != null) {
	player.x = target.x + 17;
	player.y = target.y + 23;
	target.enabled = false;
} else if (reference != null) {
	with (objPlayerReference) {
		if (reference == other.reference) {
			player.x = x + 17;
			player.y = y + 23;
		}
	}
}

with (player) {
	var state = (other.x < 1344) ? 15 : 16;
	
	if (!array_contains(state_presses[state][0], other.x)) {
		array_push(state_presses[state][0], other.x);
		
		if (other.target != null) {
			array_push(state_presses[state][0], other.target.x);
		} else {
			teammate.state_presses[state][1] = other.x + 16;
			teammate.state_presses[state][2] = true;
		}
	}
	
	if (!state_presses[state][2]) {
		state_presses[state][1] = null;
	}
}