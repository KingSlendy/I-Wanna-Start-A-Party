if (keyboard_check_pressed(ord("D"))) {
	game_set_speed((!a) ? 200 : 50, gamespeed_fps);
	a = !a;
}

if (keyboard_check_pressed(vk_f2)) {
	player_leave_all();
	global.lobby_started = false;
	instance_destroy(objNetworkClient);
	room_goto(rTitle);
}

if (keyboard_check_pressed(vk_escape)) {
	game_end();
}
