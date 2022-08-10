#region Input Checking
if (keyboard_check_pressed(ord("D"))) {
	game_set_speed((!a) ? 200 : 50, gamespeed_fps);
	a = !a;
}

if (keyboard_check_pressed(vk_f4)) {
	global.fullscreen_display ^= true;
	apply_display();
	save_config();
}

if (keyboard_check_pressed(vk_escape)) {
	if (room != rTitle) {
		network_disable();
		audio_stop_all();
		room_goto(rTitle);
	} else {
		game_end();
	}
}
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