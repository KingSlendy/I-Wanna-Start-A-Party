shuffle_seed_inline();
reset_seed_inline();
fade_start = true;
fade_alpha = 1;

with (objPlayerBase) {
	change_to_object(objPlayerParty);
}

with (objPlayerBase) {
	image_xscale = 2;
	image_yscale = 2;
	x = 230 + 110 * (player_info_by_id(network_id).turn - 1);
	y = 500;
	lost = false;
}

bonus_started = false;
bonus_candidates = [];
bonus_round = 0;
lights_moving = false;
lights_spd = [];

for (var i = 0; i < global.player_max; i++) {
	array_push(lights_spd, random_range(3, 5));
}

lights_angle = array_create(global.player_max, 0);
revealed = false;

global.board_started = false;
info = global.minigame_info;

function results_coins() {
	for (var i = 0; i < array_length(info.players_won); i++) {
		change_coins(10, CoinChangeType.Gain, player_info_by_id(info.players_won[i]).turn);
	}
	
	alarm[0] = get_frames(3.3);
	
	if (global.player_id == 1) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.ResultsCoins);
		network_send_tcp_packet();
	}
}

function results_bonus() {
	if (!bonus_started) {
		for (var i = 1; i <= global.player_max; i++) {
			if (is_player_local(i)) {
				buffer_seek_begin();
				buffer_write_action(ClientTCP.ResultsBonus);
				buffer_write_data(buffer_u8, i);
				global.bonus_shines_ready[i - 1] = true;
				var names = variable_struct_get_names(global.bonus_shines);
				var scores_ids = [];
				var scores_scores = [];
			
				for (var j = 0; j < array_length(names); j++) {
					array_push(scores_ids, names[j]);
					array_push(scores_scores, global.bonus_shines[$ names[j]].scores[i - 1]);
				}
			
				buffer_write_array(buffer_string, scores_ids);
				buffer_write_array(buffer_s32, scores_scores);
				network_send_tcp_packet();
			}
		}
		
		bonus_started = true;
	}
	
	if (array_count(global.bonus_shines_ready, true) == global.player_max) {
		if (array_length(bonus_candidates) == 0) {
			next_seed_inline();
			
			var names = variable_struct_get_names(global.bonus_shines);
		
			for (var i = 0; i < array_length(names); i++) {
				var bonus = global.bonus_shines[$ names[i]];
		
				if (bonus.is_candidate()) {
					array_push(bonus_candidates, bonus);
				}
			}
		
			array_shuffle(bonus_candidates);
		}
	
		alarm[3] = get_frames(0.25);
	}
}

function results_won() {
	alarm[1] = get_frames(3);
	lights_moving = true;
	
	if (global.player_id == 1) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.ResultsWon);
		network_send_tcp_packet();
	}
}

function results_end() {
	fade_start = true;
	
	if (global.player_id == 1) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.ResultsEnd);
		network_send_tcp_packet();
	}
}
