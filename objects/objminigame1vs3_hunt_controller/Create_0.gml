event_inherited();

minigame_start = minigame1vs3_start;
minigame_players = function() {
	with (objPlayerBase) {
		grav_amount = 0;
		enable_shoot = false;
		shoot_delay = 0;
		reticle = null;
		choose_block = null;
		landed = false;
		solo_x = 0;
		solo_y = 0;
		offset_len = 0;
		offset_dir = 0;
		aim_delay = 0;
		offset_delay = 0;
	}
	
	objBlock.touched = false;
}

minigame_time = 20;
minigame_time_end = function() {
	if (!minigame1vs3_solo().lost) {
		minigame4vs_points(minigame1vs3_solo().network_id);
	} else {
		minigame1vs3_points();
	}
	
	minigame_finish();
}

player_type = objPlayerPlatformer;
shoot_start = false;
shoot_delay = array_create(3, 0);

if (trial_is_title(RANDRANDRAND_TIME)) {
	instance_destroy(objMinigame1vs3_Hunt_Block);
	
	repeat (irandom_range(20, 50)) {
		do {
			var rand_x = irandom_range(0, 800 - 32);
			var rand_y = irandom_range(0, 608 - 32);
		} until (!position_meeting(rand_x, rand_y, objPlayerReference));
		
		instance_create_layer(rand_x, rand_y, "Collisions", objMinigame1vs3_Hunt_Block);
	}
}

function create_shoot(x, y) {
	instance_create_layer(x, y, "Actors", objMinigame1vs3_Hunt_Shot);
}

alarm_override(1, function() {
	with (objPlayerBase) {
		grav_amount = 0.4;
		
		if (y < 640) {
			frozen = false;
			break;
		}
	}

	shoot_start = true;
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
				var block = place_meeting(x, y + 1, objBlock);
				
				if (!landed && block) {
					choose_block = null;
					landed = true;
					break;
				}
				
				landed = block;
			
				var dir = -1;
				var block_jump = false;
			
				if (choose_block != null) {
					dir = point_direction(x, y, choose_block.x + 16, choose_block.bbox_top);
					block_jump = (dir >= 15 && dir <= 165);
				}
			
				if (choose_block == null || (jump_left == 0 && vspd > 0 && block_jump)) {
					var choices = [];
				
					with (objBlock) {
						if (place_meeting(x, y - 1, other) || point_distance(other.x, other.y, x + 16, other.y) > 160 || point_distance(other.x, other.y, other.x, bbox_top) > 160) {
							continue;
						}
					
						array_push(choices, id);
					}
				
					array_shuffle(choices);
					choose_block = array_pop(choices);
				}
			
				if (choose_block == null) {
					break;
				}
			
				var dist = point_distance(x, y, choose_block.x + 16, y);
			
				if (dist <= 3) {
					break;
				}
			
				var action = ((dir >= 0 && dir <= 90) || (dir >= 270 && dir <= 359)) ? actions.right : actions.left;
				action.press();
			
				if (vspd >= 0 && block_jump) {
					actions.jump.hold(20);
				}
			} else {
				if (reticle == null) {
					break;
				}
				
				var solo_player = minigame1vs3_solo();
				
				if (--aim_delay <= 0) {
					solo_x = solo_player.x;
					solo_y = solo_player.y;
					
					if (!is_player_local(solo_player.network_id)) {
						solo_player.hspd = (solo_player.x - solo_player.xprevious);
						solo_player.vspd = (solo_player.y - solo_player.yprevious);
					}
					
					if (point_distance(0, 0, solo_player.hspd, solo_player.vspd) != 0) {
						solo_x += solo_player.hspd * 5 + lengthdir_x(offset_len, offset_dir);
						solo_y += solo_player.vspd * 5 + lengthdir_y(offset_len, offset_dir);
					}
					
					aim_delay = get_frames(random_range(0.05, 0.1));
				}
				
				if (--offset_delay <= 0) {
					offset_len = irandom_range(32, 128);
					offset_dir = irandom(359);
					offset_delay = get_frames(random_range(2, 3));
				}
				
				if (--shoot_delay <= 0) {
					actions.shoot.press();
					shoot_delay = get_frames(random_range(0.9, 1.2));
				}
				
				var dist = point_distance(reticle.x, reticle.y, solo_x, solo_y);
				
				if (dist <= 3) {
					break;
				}
				
				var dir = point_direction(reticle.x, reticle.y, solo_x, solo_y);
				minigame_angle_dir8(actions, dir);
			}
		}
	}

	alarm_frames(11, 1);
});