with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

with (objPlayerBase) {
	enable_jump = false;
	enable_shoot = false;
	chest_picked = -1;
}

event_inherited();

points_draw = true;
player_check = objPlayerPlatformer;
chest_started = false;

next_seed_inline();
chest_switches = [];

repeat (50) {
	var switches = array_sequence(0, 4);
	array_shuffle(switches);
	array_delete(switches, 0, 2);
	array_push(chest_switches, switches);
}

current_switch = 0;
chest_round = 0;