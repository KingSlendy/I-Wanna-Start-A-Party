if (keyboard_check_pressed(ord("D"))) {
	game_set_speed((!a) ? 200 : 50, gamespeed_fps);
	a = !a;
}

if (keyboard_check_pressed(vk_f4)) {
	fullscreen ^= true;
	window_set_fullscreen(fullscreen);
	display_set_gui_size(surface_get_width(application_surface), surface_get_height(application_surface));
}

if (keyboard_check_pressed(vk_escape)) {
	if (room != rTitle) {
		if (room != rTitle && room != rFiles) {
			save_file();
		}
	
		network_disable();
		audio_stop_all();
		room_goto(rTitle);
	} else {
		game_end();
	}
}
