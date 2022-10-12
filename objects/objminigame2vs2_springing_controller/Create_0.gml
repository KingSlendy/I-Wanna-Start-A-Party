event_inherited();

minigame_start = minigame2vs2_start;
minigame_players = function() {
	with (objPlayerBase) {
		enable_shoot = false;
		grav_amount = 0;
	}
}

action_end = function() {
	objMinigame2vs2_Springing_Spring.enabled = false;
	
	with (objMinigame2vs2_Springing_Piranha) {
		image_index = 0;
		alarm_stop(0);
		alarm_stop(1);
	}
	
	instance_destroy(objMinigame2vs2_Springing_Fireball);
}

player_type = objPlayerPlatformer;

alarm_override(1, function() {
	alarm_inherited(1);
	objMinigame2vs2_Springing_Spring.enabled = true;

	with (objMinigame2vs2_Springing_Piranha) {
		image_index = 1;
		alarm_frames(0, 1);
		alarm_frames(1, 1);
	}

	objPlayerBase.grav_amount = 0.4;
});

alarm_override(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
	
		var player = focus_player_by_id(i);
		
		with (player) {
			var fireball = collision_rectangle(bbox_left - 22, bbox_top - 128 - 64 * (vspd < 0), bbox_right + 22, bbox_bottom, objMinigame2vs2_Springing_Fireball, true, true);
			
			if (fireball != noone) {
				if ((fireball.x + fireball.hspeed * 1.5 >= x && !place_meeting(x - 3, y, objBlock)) || place_meeting(x + 3, y, objBlock)) {
					actions.left.press();
				} else {
					actions.right.press();
				}
				
				break;
			}
			
			if (y < 416 && vspd > 0) {
				if (place_meeting(x, y + 64, objMinigame2vs2_Springing_Spike)) {
					var spring = instance_nearest(x, y, objMinigame2vs2_Springing_Spring);
					
					if (spring != noone) {
						if (x > spring.bbox_right) {
							actions.left.press();
						} else if (x < spring.bbox_left) {
							actions.right.press();
						}
						
						actions.jump.hold(20);
						break;
					}
				}
				
				fireball = instance_place(x, y + vspd, objMinigame2vs2_Springing_Fireball);
				
				if (fireball != noone) {
					actions.jump.hold(irandom_range(10, 21));
				}
			}
		}
	}

	alarm_frames(11, 1);
});