event_inherited();

minigame_start = minigame1vs3_start;
minigame_players = function() {
	with (objPlayerBase) {
		chosen_r = -1;
		chosen_c = -1;
		target_delay = 0;
	}
}

points_draw = true;

player_type = objPlayerHand;

picture_number = 5;

picture_chosen_alpha = 0;
picture_chosen_alpha_target = 0;
picture_chosen_scale = 0;
picture_chosen_scale_target = 0;

alarm_override(1, function() {
	alarm_inherited(1);
	picture_chosen_scale_target = 1;
	
	with (objMinigame1vs3_Picture_Frame) {
		picture_divisions_cover = -1;
	}
});

alarm_create(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
		
		var player = focus_player_by_id(i);
		
		with (player) {
			if (--target_delay >= 0) {
				break;
			}
			
			var frame = null;
			
			with (objMinigame1vs3_Picture_Frame) {
				if ((minigame1vs3_is_solo(other.network_id) && x < 400) || (!minigame1vs3_is_solo(other.network_id) && x > 400)) {
					frame = id;
					break;
				}
			}
			
			var none_match = true;
			
			with (frame) {
				for (var r = 0; r < picture_divisions; r++) {
					for (var c = 0; c < picture_divisions; c++) {
						if ((!picture_locked[r][c] && picture_sequence[r][c][picture_current[r][c]] == objMinigameController.picture_chosen) ||
							(picture_locked[r][c] && picture_sequence[r][c][picture_current[r][c]] != objMinigameController.picture_chosen)) {
							none_match = false;
							break;
						}
					}
					
					if (!none_match) {
						break;
					}
				}
			}
			
			if (none_match) {
				break;
			}
			
			if (chosen_r == -1 || chosen_c == -1 || frame.picture_sequence[chosen_r][chosen_c][frame.picture_current[chosen_r][chosen_c]] != other.picture_chosen || frame.picture_locked[chosen_r][chosen_c]) {
				do {
					chosen_r = irandom(frame.picture_divisions - 1);
					chosen_c = irandom(frame.picture_divisions - 1);
				} until ((!frame.picture_locked[chosen_r][chosen_c] && frame.picture_sequence[chosen_r][chosen_c][frame.picture_current[chosen_r][chosen_c]] == other.picture_chosen) ||
						 (frame.picture_locked[chosen_r][chosen_c] && frame.picture_sequence[chosen_r][chosen_c][frame.picture_current[chosen_r][chosen_c]] != other.picture_chosen));
			}
			
			if (chosen_r == -1 || chosen_c == -1) {
				break;
			}
			
			var target_x = frame.x + frame.picture_border + frame.picture_divisions_length * chosen_c + frame.picture_divisions_length / 2;
			var target_y = frame.y + frame.picture_border + frame.picture_divisions_length * chosen_r + frame.picture_divisions_length / 2;
			
			if (point_distance(x, y, target_x, target_y) > 4) {
				if (point_distance(x, 0, target_x, 0) >= 3) {
					var action_horizontal = (x > target_x) ? actions.left : actions.right;
					action_horizontal.press();
				}
							
				if (point_distance(0, y, 0, target_y) >= 3) {
					var action_vertical = (y > target_y) ? actions.up : actions.down;
					action_vertical.press();
				}
			} else {
				with (frame) {
					if (picture_sequence[other.chosen_r][other.chosen_c][picture_current[other.chosen_r][other.chosen_c]] == objMinigameController.picture_chosen) {
						picture_section_toggle(other.chosen_r, other.chosen_c, !frame.picture_locked[other.chosen_r][other.chosen_c], frame.picture_current[other.chosen_r][other.chosen_c]);
					}
				}
							
				target_delay = get_frames(random_range(0.5, 1.5));
			}
		}
	}

	alarm_frames(11, 1);
});

function picture_shuffle() {
	picture_chosen_alpha = 1;
	picture_chosen_alpha_target = 1;
	picture_chosen_scale = 0;
	
	next_seed_inline();
	picture_chosen = irandom(picture_number - 1);
	pictures = array_sequence(0, sprite_get_number(sprReactions));
	array_shuffle_ext(pictures);
	array_delete(pictures, picture_number, array_length(pictures) - picture_number);
	
	with (objMinigame1vs3_Picture_Frame) {
		pictures = [];
		picture_sequence = [];
		picture_current = [];
		picture_locked = [];
		
		for (var r = 0; r < picture_divisions; r++) {
			array_push(picture_sequence, []);
			array_push(picture_current, []);
			array_push(picture_locked, []);
	
			for (var c = 0; c < picture_divisions; c++) {
				array_push(picture_sequence[r], array_shuffle(array_sequence(0, array_length(other.pictures))));
				array_push(picture_current[r], 0);
				array_push(picture_locked[r], false);
			}
		}
	
		for (var i = 0; i < array_length(other.pictures); i++) {
			var surf = surface_create(picture_length, picture_length);
			surface_set_target(surf);
			draw_clear_alpha(c_black, 0.5);
			gpu_set_blendmode_ext_sepalpha(bm_src_alpha, bm_inv_src_alpha, bm_one, bm_one);
			draw_sprite_stretched(sprReactions, other.pictures[i], 0, 0, picture_length, picture_length);
			gpu_set_blendmode(bm_normal);
			surface_reset_target();
			array_push(pictures, sprite_create_from_surface(surf, 0, 0, picture_length, picture_length, false, false, 0, 0));
			surface_free(surf);
		}
	}
}