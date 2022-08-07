with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

objPlayerBase.enable_shoot = false;

event_inherited();

minigame_start = minigame1vs3_start;
minigame_time = 20;
minigame_time_end = function() {
	if (!points_teams[1][0].lost) {
		minigame4vs_points(points_teams[1][0].network_id);
	} else {
		minigame1vs3_points();
	}
	
	minigame_finish();
}

player_check = objPlayerPlatformer;
shoot_start = false;
shoot_delay = array_create(3, 0);

function create_shoot(x, y) {
	instance_create_layer(x, y, "Actors", objMinigame1vs3_Hunt_Shot);
}