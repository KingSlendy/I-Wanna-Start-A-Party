if (keyboard_check_pressed(ord("C"))) {
	if (!instance_exists(objNetworkClient)) {
		instance_create_layer(0, 0, "Managers", objNetworkHost);
	} else {
		show_message("You're already a client.");
	}
} else if (keyboard_check_pressed(ord("J"))) {
	if (!instance_exists(objNetworkHost)) {
		instance_create_layer(0, 0, "Managers", objNetworkClient);
	} else {
		show_message("You're already a host.");
	}
}

if (keyboard_check_pressed(vk_pagedown)) {
	room_goto_next();
}

if (keyboard_check_pressed(vk_pageup)) {
	room_goto_previous();
}