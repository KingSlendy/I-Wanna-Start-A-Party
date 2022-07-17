with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

with (objPlayerBase) {
	enable_jump = false;
	enable_shoot = false;
}

event_inherited();

minigame_start = minigame1vs3_start;
minigame_time = 60;
points_draw = true;
points_number = false;
action_end = function() {
	if (points_teams[1][0].lost) {
		minigame4vs_points(points_teams[1][0].network_id);
	} else {
		for (var i = 0; i < array_length(points_teams[0]); i++) {
			minigame4vs_points(points_teams[0][i].network_id);
		}
	}
}

player_check = objPlayerPlatformer;

warp_delay = array_create(3, 0);

function create_warp(x, y) {
	instance_create_layer(x, y, "Actors", objMinigame1vs3_Warping_Warp, {
		vspeed: -8
	});
}