event_inherited();

minigame_players = function() {
	with (objPlayerBase) {
		jump_total = 1;
		advance = true;
	}
}

minigame_time_end = function() {
	with (focus_player_by_turn(player_turn)) {
		if (is_player_local(network_id)) {
			player_jump();
		}
	}
}

points_draw = true;
player_type = objPlayerBasic;
player_turn = 0;
current_round = 0;
twice = false;

next_seed_inline();
bullet_indexes = [];
bullet_current = 0;

repeat (500) {
	array_push(bullet_indexes, choose(0, 0, 0, 0, 0, 1, 1, 2, 2, 2, 3));
}

function next_player() {
	if (info.is_finished) {
		return;
	}
	
	for (var i = 1; i <= global.player_max; i++) {
		if (minigame4vs_get_points(i) >= 5) {
			minigame_finish();
			return;
		}
	}
	
	twice = true;
	
	if (++player_turn > global.player_max) {
		player_turn = 1;
	}
	
	minigame_time = 15;
	alarm_call(10, 1);
	
	var player = focus_player_by_turn(player_turn);
	
	if (!is_player_local(player.network_id)) {
		return;
	}
	
	player.hspd = -player.max_hspd;
	player.advance = true;
}

function bullets_move() {
	with (objMinigame4vs_Bullets_Bullet) {
		target_x = x - sprite_width;
	}
}

alarm_override(1, function() {
	next_player();
});

alarm_create(4, function() {
	bullets_move();
});

alarm_override(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}

		if (0.3 > random(1)) {
			actions.jump.press();
		}
	}

	alarm_frames(11, 1);
});