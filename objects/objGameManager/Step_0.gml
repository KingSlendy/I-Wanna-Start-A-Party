if (keyboard_check_pressed(vk_pagedown)) {
	room_goto_next();
}

if (keyboard_check_pressed(vk_pageup)) {
	room_goto_previous();
}

if (keyboard_check_pressed(ord("D"))) {
	game_set_speed((!a) ? 150 : 50, gamespeed_fps);
	a = !a;
}

if (keyboard_check_pressed(vk_f2)) {
	player_leave_all();
	instance_destroy(objNetworkClient);
	game_restart();
}