with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

with (objPlayerBase) {
	enable_jump = false;
	enable_shoot = false;
}

event_inherited();

minigame_camera = CameraMode.Split4;
minigame_time_end = function() {
	minigame_lost_points();
	minigame_finish();
}

action_end = function() {
	set_spd(0);
	alarm[4] = 0;
	alarm[5] = 0;
}

player_check = objPlayerPlatformer;

scene_spd = 0;
prev_openings = array_create(global.player_max, 2);

function set_spd(spd) {
	scene_spd = spd;
	layer_vspeed("Background", scene_spd);
	objMinigame4vs_Tower_Spike.vspeed = scene_spd;
	objMinigame4vs_Tower_Block.vspeed = scene_spd;
	objMinigame4vs_Tower_Crack.vspeed = scene_spd;
	
	if (instance_exists(objMinigame4vs_Tower_Trophy)) {
		objMinigame4vs_Tower_Trophy.vspeed = scene_spd;
	}
}

trophy_floor = true;
