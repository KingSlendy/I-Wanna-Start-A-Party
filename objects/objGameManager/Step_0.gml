if (keyboard_check_pressed(ord("D"))) {
	game_set_speed((!a) ? 200 : 50, gamespeed_fps);
	a = !a;
}

if (keyboard_check_pressed(vk_f2)) {
	if (room != rTitle && room != rFiles) {
		save_file();
	}
	
	network_disable();
	audio_stop_all();
	room_goto(rTitle);
}

if (keyboard_check_pressed(vk_escape)) {
	game_end();
}
