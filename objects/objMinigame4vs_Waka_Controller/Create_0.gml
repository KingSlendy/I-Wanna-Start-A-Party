event_inherited();

minigame_players = function() {
	with (objPlayerBase) {
		xpos = x;
		ypos = y;
	}
}

minigame_time_end = function() {
	objPlayerBase.frozen = true;
	minigame_time = -1;
	alarm_instant(4);
}

player_type = objPlayerStatic;

next_path = -1;
state_path = -1;
camera_state = -1;
current_round = 0;
player_pos = array_create(global.player_max, 0);

alarm_override(1, function() {
	alarm_call(4, 1);
});

alarm_create(4, function() {
	state_path = (state_path + 2 + 1) % 2;
	
	if (state_path == 0 && (current_round == 3 || minigame_lost_all())) {
		minigame_lost_points();
		minigame_finish();
		return;
	}
	
	next_path = 0;
});

alarm_create(5, function() {
	camera_state = 0;
})