event_inherited();

minigame_players = function() {
	with (objMinigame4vs_Magic_Items) {
		init_item();
	}
	
	with (objMinigame4vs_Magic_Curtain) {
		curtain_init();
	}
	
	with (objPlayerBase) {
		item = null;
		item_orders = array_sequence(0, 10);
		
		repeat (irandom(3)) {
			array_swap(item_orders, irandom(array_length(item_orders) - 1), irandom(array_length(item_orders) - 1));
		}
		
		item_chosen = null;
		finished = false;
		delay_timer = 0;
	}
}

minigame_camera = CameraMode.Split4;
minigame_time_valign = fa_top;
minigame_time_end = function() {
	with (objMinigame4vs_Magic_Curtain) {
		alpha_target = 0;
		can_switch = false;
	}
	
	instance_create_layer(0, 0, "Managers", objMinigame4vs_Magic_Checker);
}

player_type = objPlayerHand;

state = 0;
item_order = array_sequence(0, sprite_get_number(sprMinigame4vs_Magic_Items));
array_shuffle_ext(item_order);

alarm_override(0, function() {
	if (state++ == 0) {
		music_play(music);
		
		with (objMinigame4vs_Magic_Intro) {
			alarm_call(0, 2);
		}
	} else {
		alarm_inherited(0);
	}
});

alarm_override(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
	
		var player = focus_player_by_id(i);
		
		with (player) {
			if (frozen || finished) {
				break;
			}
			
			if (delay_timer > 0) {
				delay_timer--;
				break;
			}
			
			if (item_chosen == null || item_chosen.pedestal) {
				var item_choices = [];
			
				with (objMinigame4vs_Magic_Items) {
					if (self.player == null || self.player.network_id != i || pedestal) {
						continue;
					}
					
					array_push(item_choices, id);
				}
				
				if (array_length(item_choices) == 0) {
					actions.shoot.press();
					finished = true;
					break;
				}
				
				array_shuffle_ext(item_choices);
				item_chosen = array_pop(item_choices);
			}
			
			var follow = null;
			
			if (item == null) {
				follow = item_chosen;
				var check_item = instance_place(x, y, objMinigame4vs_Magic_Items);
				
				if (check_item != noone && !check_item.pedestal) {
					var frames = get_frames(random_range(0.25, 3));
					actions.jump.hold(frames);
					delay_timer = frames;
					break;
				}
			} else {
				with (objMinigame4vs_Magic_Holder) {
					if (network_id == i && order == other.item_orders[other.item.order]) {
						follow = id;
						break;
					}
				}
				
				if (point_distance(x, y, follow.x + 16, follow.y + 16) <= 5) {
					delay_timer = get_frames(random_range(0.1, 1));
					break;
				}
				
				item_chosen = item;
				actions.jump.press();
			}
			
			var dir = point_direction(x, y, follow.x + 16, follow.y + 16);
			minigame_angle_dir8(actions, dir);
		}
	}

	alarm_frames(11, 1);
});