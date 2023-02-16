delta = delta_time / 1000000 * 50;

#region Pause Input Checking
pause_options = [
	"Resume",
	"Settings",
	"Back To Files",
	"Back To Modes"
];

if (IS_ONLINE) {
	pause_options = [
		"Resume",
		"Settings",
		"Exit Lobby"
	];
} else if (room == rFiles || room == rSettings) {
	pause_options = [
		"Resume",
		"Settings"
	];
} else if (room == rModes) {
	pause_options = [
		"Resume",
		"Settings",
		"Back To Files"
	];
} else if (IS_MINIGAME && room != rMinigameOverview && global.minigame_info.is_minigames) {
	pause_options = [
		"Resume",
		"Settings",
		"Back To Files",
		"Back To Modes",
		"Back To Overview"
	];
} else if (global.minigame_info.is_trials) {
	pause_options = [
		"Resume",
		"Settings",
		"Back To Files",
		"Back To Modes",
		"Back To Trials"
	];
}

if (array_length(pause_options) != array_length(pause_highlight)) {
	pause_highlight = array_create(array_length(pause_options), 0.5);
}

global.ignore_input = false;

if (paused) {
	if (pause_target_x == 400 && point_distance(pause_state, 0, paused, 0) < 0.01) {
		var move = (global.actions.down.pressed(pause_player_id) - global.actions.up.pressed(pause_player_id));
		
		if (move != 0) {
			pause_selected = (pause_selected + array_length(pause_options) + move) % array_length(pause_options);
			global.ignore_input = true;
			audio_play_sound(global.sound_cursor_move, 0, false);
		}
		
		if (global.actions.jump.pressed(pause_player_id)) {
			switch (pause_selected) {
				case 0:
					paused = false;
					audio_play_sound(sndPauseLeave, 0, false);
					break;
				
				case 1:
					if (!instance_exists(objSettings)) {
						with (instance_create_depth(0, 0, depth, objSettings)) {
							fade_start = false;
							fade_alpha = 0;
							draw = false;
							draw_x = 1200;
						}
					} else {
						objSettings.draw_target_x = 400;
					}
					
					audio_play_sound(global.sound_cursor_select, 0, false);
					break;
					
				case 2:
					disable_board();
					network_disable();
					paused = false;
					pause_state = 0;
					audio_play_sound(global.sound_cursor_back, 0, false);
					break;
					
				case 3:
					disable_board();
					paused = false;
					pause_state = 0;
					room_goto(rModes);
					audio_play_sound(global.sound_cursor_back, 0, false);
					break;
					
				case 4:
					paused = false;
					pause_state = 0;
					
					if (global.minigame_info.is_minigames) {
						room_goto(rMinigameOverview);
					} else if (global.minigame_info.is_trials) {
						room_goto(rTrials);
					}
					
					audio_play_sound(global.sound_cursor_back, 0, false);
					break;
			}
			
			global.ignore_input = true;
		}
		
		if (global.actions.shoot.pressed(pause_player_id)) {
			paused = false;
			global.ignore_input = true;
			audio_play_sound(sndPauseLeave, 0, false);
		}
	}
	
	global.ignore_input = true;
}
#endregion