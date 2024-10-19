event_inherited();
minigame_start = minigame1vs3_start;
minigame_players = function() {
	with (objPlayerBase) {
		enable_shoot = false;
		press_delay = 0;
	}
}

minigame_time = 20;
minigame_time_halign = fa_center;
minigame_time_valign = fa_middle;
minigame_time_end = function() {
	if (!minigame1vs3_solo().lost) {
		var network_id = minigame1vs3_solo().network_id;
		
		minigame4vs_points(network_id);
		
		if (trophy_jump && network_id == global.player_id) {
			achieve_trophy(94);
		}
	} else {
		minigame1vs3_points();
	}
	
	minigame_finish();
}

player_type = objPlayerPlatformer;

kardia_start = false;

trophy_jump = true;

alarm_override(1, function() {
	minigame1vs3_solo().frozen = false;
	kardia_start = true;
});

alarm_override(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
		
		var player = focus_player_by_id(i);
		
		with (player) {
			if (minigame1vs3_is_solo(i)) {
				with (objMinigame1vs3_Kardia_Cherry) {
					if (circle) {
						instance_deactivate_object(id);
					}
				}
				
				var cherry;
				
				if (vspd <= 0) {
					cherry = collision_rectangle(bbox_left - 30, bbox_top, bbox_right + 30, bbox_bottom + 30, objMinigame1vs3_Kardia_Cherry, true, true);
				
					if (cherry != noone && ((cherry.x < x && cherry.hspeed > 0) || (cherry.x > x && cherry.hspeed < 0))) {
						if (cherry.hspeed > 0) {
							actions.right.hold(irandom_range(10, 20));
						} else {
							actions.left.hold(irandom_range(10, 20));
						}
						
						actions.jump.hold(irandom_range(10, 18));
						instance_activate_object(objMinigame1vs3_Kardia_Cherry);
						break;
					}
				} else {
					cherry = instance_place(x, y + vspd, objMinigame1vs3_Kardia_Cherry);
				
					if (cherry != noone) {
						actions.jump.hold(irandom_range(10, 18));
					}
				}
				
				cherry = collision_rectangle(bbox_left - 22, bbox_top - 128 - 64 * (vspd < 0), bbox_right + 22, bbox_bottom, objMinigame1vs3_Kardia_Cherry, true, true);
			
				if (cherry != noone) {
					if ((cherry.x >= x && !place_meeting(x - 3, y, objMinigame1vs3_Kardia_CPU)) || place_meeting(x + 3, y, objMinigame1vs3_Kardia_CPU)) {
						actions.left.press();
					} else {
						actions.right.press();
					}
				
					instance_activate_object(objMinigame1vs3_Kardia_Cherry);
					break;
				}
				
				instance_activate_object(objMinigame1vs3_Kardia_Cherry);
			} else {
				if (chance(0.5)) {
					actions.shoot.press();
				}
				
				if (--press_delay <= 0) {
					var action_delay = get_frames(random_range(0.5, 2));
					var action = choose(actions.left, actions.right);
					action.hold(action_delay);
					press_delay = action_delay + get_frames(random_range(0.5, 1.5));
				}
			}
		}
	}

	alarm_frames(11, 1);
});