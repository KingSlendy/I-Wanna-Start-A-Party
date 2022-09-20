event_inherited();

minigame_players = function() {
	with (objPlayerBase) {
		jump_total = 1;
		advance = true;
	}
}

player_check = objPlayerBasic;
player_turn = 0;
twice = false;

next_seed_inline();
bullet_indexes = [];
bullet_current = 0;
var chosen_index = 0;
var chosen_count = 1;
var now_index = 0;

repeat (500) {
	if (chosen_count-- > 0) {
		now_index = chosen_index;
	}
	
	array_push(bullet_indexes, now_index);
	
	if (chosen_count <= 0) {
		chosen_index = !chosen_index;
		
		if (chosen_index == 0) {
			chosen_count = max(1, irandom_range(0, 2));
		} else {
			chosen_count = min(3, irandom_range(2, 4));
		}
	}
}

function next_player() {
	if (info.is_finished) {
		return;
	}
	
	twice = true;
	
	do {
		player_turn++;
	
		if (player_turn > global.player_max) {
			player_turn = 1;
		}
	} until (!focus_player_by_turn(player_turn).lost);
	
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