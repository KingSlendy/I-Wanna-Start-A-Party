var player = other;

if (!is_player_local(player.network_id) || player.lost) {
	exit;
}

with (player) {
	if (other.image_index == 0) {
		if (vspd > 2) {
			vspd = 2;
		}
		
		reset_jumps();
	} else {
		player_kill();	
	}
}

if (player.network_id == global.player_id && image_index == 0) {
	with (instance_place(x, y - 1, objMinigame4vs_Bullets_Trophy)) {
		if (place_meeting(x, y, player)) {
			instance_destroy();
		} else if (global.actions.jump.pressed(player.network_id)) {
			achieve_trophy(95);
			instance_destroy();
		}
	}
}