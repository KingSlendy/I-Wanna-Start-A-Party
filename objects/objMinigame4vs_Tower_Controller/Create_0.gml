with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

with (objPlayerBase) {
	enable_jump = false;
	enable_shoot = false;
}

event_inherited();

minigame_split = true;
//minigame_time = 40;
minigame_time_end = function() {
	with (objPlayerBase) {
		if (lost) {
			continue;
		}
		
		minigame4vs_points(objMinigameController.info, network_id);
	}
	
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
}
