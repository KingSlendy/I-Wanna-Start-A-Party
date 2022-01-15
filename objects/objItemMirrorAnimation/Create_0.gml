event_inherited();

if (is_local_turn()) {
	with (objSpaces) {
		if (image_index == SpaceType.Shine) {
			focus_player.x = x + 16;
			focus_player.y = y + 16;
			break;
		}
	}

	with (focus_player) {
		event_perform(ev_other, ev_end_of_path);	
	}
}

alarm[0] = 1;