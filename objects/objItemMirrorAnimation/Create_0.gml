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
			if (!has_shine()) {
				continue;
			}
			
			var space_record = infinity;
			var near = null;
		
			with (objSpaces) {
				if (image_index != SpaceType.PathEvent) {
					continue;
				}
				
				var dist = point_distance(x + 16, y + 16, other.x, other.y);
						
				if (dist < space_record) {
					space_record = dist;
					near = id;
				}
			}

			other.focus_player.x = near.x + 16;
			other.focus_player.y = near.y + 16;
			break;
		}
	}

	with (focus_player) {
		event_perform(ev_other, ev_end_of_path);	
	}
}

alarms_init(1);

alarm_create(function() {
	instance_destroy();
});

alarm_frames(0, 1);