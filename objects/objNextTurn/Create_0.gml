if (is_player_turn() && !global.board_started) {
	objPlayerBoard.x = objPlayerBoard.xstart;
}

surf = surface_create(surface_get_width(application_surface), surface_get_height(application_surface));
surface_copy(surf, 0, 0, application_surface);
alarm[0] = 1;