event_inherited();

if (is_local_turn()) {
	if (room != rBoardPallet) {
		with (objSpaces) {
			if (image_index == SpaceType.Shine) {
				other.focus_player.x = x + 16;
				other.focus_player.y = y + 16;
				break;
			}
		}
	} else {
		with (objBoardPalletPokemon) {
			if (has_shine()) {
				var near = instance_nearest(x, y, objSpaces);
				other.focus_player.x = near.x + 16;
				other.focus_player.y = near.y + 16;
				break;
			}
		}
	}

	with (focus_player) {
		event_perform(ev_other, ev_end_of_path);	
	}
}

alarm[0] = 1;