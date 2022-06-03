if (keyboard_check_pressed(vk_pagedown)) {
	room_goto_next();
}

if (keyboard_check_pressed(vk_pageup)) {
	room_goto_previous();
}

if (keyboard_check_pressed(ord("D"))) {
	game_set_speed((!a) ? 200 : 50, gamespeed_fps);
	a = !a;
}

if (keyboard_check_pressed(vk_f2)) {
	player_leave_all();
	global.lobby_started = false;
	instance_destroy(objNetworkClient);
	game_restart();
}

if (keyboard_check_pressed(vk_escape)) {
	game_end();
}
