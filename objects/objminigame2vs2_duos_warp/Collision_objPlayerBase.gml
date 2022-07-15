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
	
	if (!array_contains(state_presses[state], other.x)) {
		array_push(state_presses[state], other.x);
		
		if (other.target != null) {
			array_push(state_presses[state], other.target.x);
		} else {
			state_presses[state] = null;
		}
	}
	
	prev_chosed_warp = chosed_warp;
	chosed_warp = null;
}