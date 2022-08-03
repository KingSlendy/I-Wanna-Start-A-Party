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