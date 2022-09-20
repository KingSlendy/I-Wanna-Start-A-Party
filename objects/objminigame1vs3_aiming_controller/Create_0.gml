event_inherited();

minigame_start = minigame1vs3_start;
minigame_players = function() {
	with (objPlayerBase) {
		enable_jump = false;
		enable_shoot = false;
	}
}

minigame_time = 30;
minigame_time_end = function() {
	if (minigame1vs3_lost()) {
		minigame4vs_points(points_teams[1][0].network_id);
	} else {
		minigame1vs3_points();
	}
	
	minigame_finish();
}

player_check = objPlayerPlatformer;

input_start = false;
shoot_delay = 0;
trophy_saver = true;

function create_laser(x, y) {
	instance_create_layer(x + 16, y + 16, "Actors", objMinigame1vs3_Aiming_Laser);
}

alarm_override(1, function() {
	with (objPlayerBase) {
		if (network_id == other.points_teams[1][0].network_id) {
			frozen = false;
			break;
		}
	}
	
	input_start = true;
});