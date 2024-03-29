event_inherited();

minigame_time_end = function() {
	with (focus_player_by_turn(player_turn)) {
		player_kill();
	}
	
	alarm_instant(4);
	instance_destroy(objBullet);
}

player_type = objPlayerPlatformer;
player_turn = 0;

function unfreeze_player() {
	alarm_stop(4);
	instance_destroy(objMinigame4vs_Slime_Blocking);
	instance_destroy(objMinigame4vs_Slime_Next);
	
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
	
	with (objPlayerBase) {
		enable_shoot = true;
		frozen = true;
	}
	
	var player = focus_player_by_turn(player_turn);
	player.frozen = false;
	instance_create_layer(384, 384, "Collisions", objMinigame4vs_Slime_Blocking, {
		image_xscale: 5
	});
	
	minigame_time = 8;
	alarm_call(10, 1);
}

function block_entrance(network = true) {
	for (var i = 0; i < 5; i++) {
		instance_create_layer(400 + 32 * i, 464, "Collisions", objMinigame4vs_Slime_Block);
	}
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame4vs_Slime_BlockEntrance);
		network_send_tcp_packet();
	}
}

alarm_override(1, function() {
	unfreeze_player();
});

alarm_create(4, function() {
	if (focus_player_by_turn(player_turn).lost) {
		unfreeze_player();
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
			if (!enable_shoot) {
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
			} else {
				if (!instance_exists(objBullet)) {
					actions.right.press();
					actions.shoot.press();
				}
			}
		}
	}

	alarm_frames(11, 1);
});