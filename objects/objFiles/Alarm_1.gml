if (!global.actions.jump.released()) {
	alarm[1] = 1;
	exit;
}

get_string_async(lobby_window_name, lobby_window_desc);