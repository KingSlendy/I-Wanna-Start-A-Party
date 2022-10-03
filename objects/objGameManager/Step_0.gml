#region Input Checking
var ignore_input = global.ignore_input;
global.ignore_input = false;

if (keyboard_check_pressed(vk_f4)) {
	if (global.fullscreen_delay == 0) {
		global.fullscreen_display ^= true;
		global.fullscreen_delay = get_frames_static(0.5);
	}
	
	apply_display();
	save_config();
}

if (keyboard_check_pressed(vk_escape)) {
	if (room == rTitle) {
		game_end();
	} else if ((room == rFiles && objFiles.file_opened == -1) || room == rSettings) {
		network_disable();
		room_goto(rTitle);
	}
}

var bgm_volume = global.bgm_volume;

if (paused) {
	global.bgm_volume = 0;
}

if (global.music_current != null) {
	apply_volume();
}

global.bgm_volume = bgm_volume;

if (global.actions.pause.pressed()) {
	paused ^= true;
		
	if (paused) {
		//if (!IS_ONLINE) {
		//	pause_sprite = sprite_create_from_surface(application_surface, 0, 0, 800, 608, false, false, 0, 0);
		//	time_source_pause(time_source_game);
		//	instance_deactivate_all(true);
		//	instance_activate_object(objSettings);
		//}
			
		pause_selected = 0;
		pause_highlight = array_create(array_length(pause_options), 0.5);
	} else {
		//if (!IS_ONLINE) {
		//	instance_activate_all();
		//	time_source_resume(time_source_game);
		//	sprite_delete(pause_sprite);
		//}
	}
		
	audio_play_sound((paused) ? sndPauseEnter : sndPauseLeave, 0, false);
}

global.ignore_input = ignore_input;
#endregion

#region Music Loop System
if (global.music_current != null && global.music_loop_start != -1) {
    var current_position = audio_sound_get_track_position(global.music_current);
    var total_length = global.music_loop_start + global.music_loop_end;

    if (current_position > total_length) {
        audio_sound_set_track_position(global.music_current, current_position - global.music_loop_end);    
    }
}
#endregion

global.fullscreen_delay--;
global.fullscreen_delay = max(global.fullscreen_delay, 0);