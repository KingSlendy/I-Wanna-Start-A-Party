event_inherited();

space_shine = null;
space_current = {x: focus_player.x, y: focus_player.y};

state = 0;
scale = 0;
angle = 0;

if (is_local_turn()) {
	if (room != rBoardPallet) {
		with (objSpaces) {
			if (image_index == SpaceType.Shine) {
				other.space_shine = id;
				break;
			}
		}
	} else {
		with (objBoardPalletPokemon) {
			if (!has_shine()) {
				continue;
			}
			
			var space_record = infinity;
		
			with (objSpaces) {
				if (image_index != SpaceType.PathEvent) {
					continue;
				}
				
				var dist = point_distance(x + 16, y + 16, other.x, other.y);
						
				if (dist < space_record) {
					space_record = dist;
					other.space_shine = id;
				}
			}

			break;
		}
	}
}

//with (focus_player) {
//	x = other.space_shine.x + 16;
//	y = other.space_shine.y + 16;
//	event_perform(ev_other, ev_end_of_path);	
//}

space_shine = {x: space_shine.x + 16, y: space_shine.y + 16};

alarms_init(3);

alarm_create(function() {
	with (focused_player()) {
		board_jump();
	}
	
	alarm_call(1, 0.3);
});

alarm_create(function() {
	with (focus_player) {
		var diff_y = (jump_y - y);
		jump_y = other.space_shine.y;
		x = other.space_shine.x;
		y = other.space_shine.y - diff_y;
	}
	
	alarm_call(2, 1);
});

alarm_create(function() {
	state = 1;
});