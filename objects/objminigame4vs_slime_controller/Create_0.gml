event_inherited();

minigame_players = function() {
	with (objPlayerBase) {
		enable_shoot_wait = 7;
		shoot_times = 0;
	}
}

minigame_time_end = function() {
	with (focus_player_by_turn(player_turn)) {
		player_kill();
	}
	
	alarm_instant(4);
	instance_destroy(objBullet);
}

player_type = objPlayerPlatformer;
player_turn = 0;
slime_annoyances = 0;
slime_annoy = 0;

function unfreeze_player() {
	alarm_stop(4);
	
	if (instance_exists(objMinigame4vs_Slime_Block)) {
		objMinigame4vs_Slime_Block.scale_target = 0;
	}
	
	if (info.is_finished) {
		return;
	}
	
	do {
		player_turn++;
	
		if (player_turn > global.player_max) {
			player_turn = 1;
		}
	} until (!focus_player_by_turn(player_turn).lost);
	
	objPlayerBase.frozen = true;
	
	var player = focus_player_by_turn(player_turn);
	player.frozen = false;
	instance_create_layer(384, 384, "Collisions", objMinigame4vs_Slime_Blocking, {
		image_xscale: 5
	});
	
	alarm_instant(5);
}

function block_entrance() {
	for (var i = 0; i < 5; i++) {
		instance_create_layer(400 + 32 * i, 464, "Collisions", objMinigame4vs_Slime_Block);
	}
}

alarm_override(1, function() {
	var lost_count = 0;

	with (objPlayerBase) {
		lost_count += lost;	
	}
	
	next_seed_inline();
	slime_annoyances = irandom_range(1, (global.player_max - lost_count) * 2 + global.player_max);
	slime_annoy = 0;
	unfreeze_player();
});

alarm_create(4, function() {
	if (!focus_player_by_turn(player_turn).lost) {
		alarm_frames(4, 1);
		return;
	}
	
	unfreeze_player();
});

alarm_create(5, function() {
	minigame_time = 8;
	alarm_call(10, 1);
});

alarm_override(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
	
		var player = focus_player_by_id(i);
	
		with (player) {
			if (instance_exists(objBullet) || frozen) {
				break;
			}
			
			if (y > 416) {
				var dist = point_distance(x, y, 400, y);
			
				if (dist <= 3) {
					if (vspd >= 0) {
						actions.jump.hold(15);
					}
				} else {
					var dir = point_direction(x, y, 400, y);
					var action = (dir == 0) ? actions.right : actions.left;
					action.press();
				}
				
				shoot_times = 1;
			} else if (shoot_times > 0) {
				if (!enable_shoot) {
					actions.left.hold(15);
					
					if (chance(0.6)) {
						shoot_times = 1;
					} else {
						shoot_times = irandom_range(1, 3);
					}
					
					enable_shoot_wait = 15;
				} else if (--enable_shoot_wait <= 0) {
					if (xscale == -1) {
						actions.right.press();
					} else {
						actions.shoot.press();
						shoot_times--;
					}
				}
			} else {
				actions.right.hold(10);
			}
		}
	}

	alarm_frames(11, 1);
});