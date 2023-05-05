event_inherited();

minigame_players = function() {
	with (objPlayerBase) {
		grav_amount = 0;
		enable_shoot = false;
		bullet_inside = null;
		bullet_change = get_frames(irandom_range(3, 8));
	}
}

minigame_time_end = function() {
	with (focus_player_by_turn(player_turn)) {
		if (is_player_local(network_id)) {
			player_jump();
		}
	}
}

action_end = function() {
	alarm_stop(5);
}

player_type = objPlayerPlatformer;

next_seed_inline();
bullet_index = 0;
bullet_max = 2;

alarm_override(1, function() {
	alarm_inherited(1);
	objPlayerBase.grav_amount = 0.4;
	objMinigame4vs_Bullets_Bullet.hspeed = -2;
	alarm_call(5, 8);
});

alarm_create(5, function() {
	next_seed_inline();
	
	repeat (2) { 
		instance_create_layer(400, 420, "Actors", objMinigame4vs_Bullets_Cherry, {
			direction: irandom(359),
			speed: irandom_range(2, 3)
		});
	}
	
	alarm_call(5, 5);
});

alarm_override(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}

		var player = focus_player_by_id(i);
		
		with (player) {
			if (bullet_inside == null) {
				bullet_inside = instance_place(x, y + 32, objMinigame4vs_Bullets_Bullet);
			}
			
			if (x < 650) {
				bullet_change--;
			}
			
			if (vspd > 0 && place_meeting(x, y - 7, objMinigame4vs_Bullets_Bullet)) {
				actions.jump.hold(irandom_range(10, 20));
				
				if (bullet_change <= 0 || x < 200) {
					bullet_change = get_frames(irandom_range(0.5, 3));
					
					with (bullet_inside) {
						for (var i = 1; i <= 3; i++) {
							var next_bullet = collision_point(x + sprite_width * i, y, objMinigame4vs_Bullets_Bullet, true, true);
							
							if (next_bullet != noone && next_bullet.image_index == 0) {
								other.bullet_inside = next_bullet;
								break;
							}
						}				
					}
				}
			}
			
			var dist = point_distance(x, y, bullet_inside.x, y);
			var dir = point_direction(x, y, bullet_inside.x, y);
			
			if (dist > 6) {
				var action = (dir == 0) ? actions.right : actions.left;
				action.hold(irandom_range(2, 5));
			}
			
			with (objMinigame4vs_Bullets_Bullet) {
				if (image_index == 0) {
					instance_deactivate_object(id);
				}
			}
			
			if (collision_rectangle(bbox_left, y, bbox_right, y + 32, objMinigame4vs_Bullets_Bullet, true, true) != noone) {
				actions.jump.release(true);
				actions.jump.hold(irandom_range(10, 20));
			}
			
			instance_activate_object(objMinigame4vs_Bullets_Bullet);
		}
	}

	alarm_frames(11, 1);
});