if (instance_number(object_index) > 1) {
	instance_destroy();
	exit;
}

depth = -15000;
delta = 1;

timer = time_source_create(time_source_game, 1, time_source_units_seconds, function() {
	global.ellapsed_time += global.game_started;
}, [], -1);

time_source_start(timer);

alarms_collected = [];
paused = false;
pause_sprite = noone;
pause_player_id = 0;
pause_state = 0;
pause_selected = 0;
pause_highlight = [];
pause_x = 400;
pause_target_x = pause_x;

controls_text = new Text(fntControls);