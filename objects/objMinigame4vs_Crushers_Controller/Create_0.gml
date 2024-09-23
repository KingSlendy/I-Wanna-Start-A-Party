event_inherited();

minigame_players = function() {
	with (objPlayerBase) {
		enable_jump = false;
		enable_shoot = false;
		crusher_follow = null;
	}
}

action_end = function() {
	alarm_stop(4);
}

player_type = objPlayerPlatformer;

crusher_count = 0;
shake = 0;

alarm_override(1, function() {
	alarm_inherited(1);
	alarm_instant(4);
});

alarm_create(4, function() {
	next_seed_inline();
	var crusher_list = [];
	var repeat_crusher = 1;
	
	if (crusher_count > 14) {
		repeat_crusher = 4;
	} else if (crusher_count > 9) {
		repeat_crusher = 3;
	} else if (crusher_count > 4) {
		repeat_crusher = 2;
	}
	
	repeat (irandom_range(1, repeat_crusher)) {
		with (objMinigame4vs_Crushers_Crusher) {
			if (image_index == 0) {
				array_push(crusher_list, id);
			}
		}
	
		if (array_length(crusher_list) > 0) {
			array_shuffle_ext(crusher_list);
		
			with (crusher_list[0]) {
				alarm_instant(0);
			}
		}
	}
	
	crusher_count++;
	alarm_call(4, irandom_range(1.25, 2));
});

alarm_override(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
		
		var player = focus_player_by_id(i);
		
		with (player) {
			if (crusher_follow == null || (instance_exists(crusher_follow) && crusher_follow.image_index != 0 && crusher_follow.image_index != 3)) {
				var priority = ds_priority_create();
				
				with (objMinigame4vs_Crushers_Crusher) {
					if (image_index != 0 && image_index != 3) {
						continue;
					}
					
					ds_priority_add(priority, id, point_distance(x + sprite_width / 2, y + sprite_height / 2, other.x, other.y));
				}
				
				var crusher_list = [];
				
				repeat (3) {
					array_push(crusher_list, ds_priority_delete_min(priority));
				}
				
				if (array_length(crusher_list) > 0) {
					array_shuffle_ext(crusher_list);
					crusher_follow = crusher_list[0];
					ds_priority_destroy(priority);
				}
			}
			
			if (crusher_follow != null && instance_exists(crusher_follow)) {
				var crusher_x = crusher_follow.x + crusher_follow.sprite_width / 2;
			
				if (point_distance(x, y, crusher_x, y) < 12) {
					break;
				}
			
				var action = (x > crusher_x) ? actions.left : actions.right;
				action.press();
			}
		}
	}

	alarm_frames(11, 1);
});