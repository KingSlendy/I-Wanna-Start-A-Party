event_inherited();

minigame_start = minigame1vs3_start;
minigame_players = function() {
	objPlayerBase.enable_shoot = false;
}

minigame_time = 20;
minigame_time_end = function() {
	if (!points_teams[1][0].lost) {
		minigame4vs_points(points_teams[1][0].network_id);
		
		if (points_teams[1][0].network_id == global.player_id && trophy_jump) {
			gain_trophy(53);
		}
	} else {
		minigame1vs3_points();
	}
	
	minigame_finish();
}

player_check = objPlayerPlatformer;
shoot_start = false;
shoot_delay = array_create(3, 0);
trophy_jump = true;

function create_shoot(x, y) {
	instance_create_layer(x, y, "Actors", objMinigame1vs3_Hunt_Shot);
}

alarm_override(1, function() {
	with (objPlayerBase) {
		if (y < 640) {
			frozen = false;
			break;
		}
	}

	shoot_start = true;
});