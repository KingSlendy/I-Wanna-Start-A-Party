shuffle_seed_bag();
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
previous_place = -1;

global.board_started = false;
info = global.minigame_info;

function results_coins() {
	for (var i = 0; i < array_length(info.players_won); i++) {
		change_coins(10, CoinChangeType.Gain, player_info_by_id(info.players_won[i]).turn);
	}

	alarm_call(0, 3.3);
}

function results_bonus() {
	if (!bonus_started) {
		for (var i = 1; i <= global.player_max; i++) {
			var player = focus_player_by_turn(i);
			
			if (is_player_local(player.network_id)) {
				buffer_seek_begin();
				buffer_write_action(ClientTCP.ResultsBonus);
				buffer_write_data(buffer_u8, i);
				var player_info = player_info_by_turn(i);
				buffer_write_data(buffer_u16, player_info.shines);
				buffer_write_data(buffer_u16, player_info.coins);
				var scores_scores = [];
			
				for (var j = 0; j < array_length(global.bonus_shines); j++) {
					array_push(scores_scores, global.bonus_shines[j].scores[i - 1]);
				}
			
				buffer_write_array(buffer_u16, scores_scores);
				network_send_tcp_packet();
				
				global.bonus_shines_ready[i - 1] = true;
			}
		}
		
		bonus_started = true;
	}
	
	if (array_count(global.bonus_shines_ready, true) == global.player_max) {
		if (array_length(bonus_candidates) == 0) {
			next_seed_inline();
		
			for (var i = 0; i < array_length(global.bonus_shines); i++) {
				var bonus = global.bonus_shines[i];
		
				if (bonus.is_candidate()) {
					array_push(bonus_candidates, bonus);
				}
			}
		
			array_shuffle_ext(bonus_candidates);
		}
		
		alarm_call(3, 0.25);
	}
}

function results_won() {
	music_fade();
	audio_play_sound(sndResultsDrumRoll, 0, true);
	alarm_call(1, 3);
	lights_moving = true;
	
	if (global.player_id == 1) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.ResultsWon);
		network_send_tcp_packet();
	}
}

function results_end() {
	instance_create_layer(0, 0, "Managers", objResultsStats);
	
	if (global.player_id == 1) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.ResultsEnd);
		network_send_tcp_packet();
	}
}

function results_proceed() {
	fade_start = true;
	audio_play_sound(global.sound_cursor_select, 0, false);
		
	if (global.player_id == 1) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.ResultsProceed);
		network_send_tcp_packet();
	}
}

alarms_init(4);

alarm_create(function() {
	if (global.give_bonus_shines) {
		start_dialogue([
			new Message(language_get_text("PARTY_RESULTS_BUT_FIRST"),, results_bonus)
		]);
	} else {
		start_dialogue([
			new Message(language_get_text("PARTY_RESULTS_NOW_REVEAL"),, results_won)
		]);
	
		//If it increased a bonus round that means this option was enabled from the start
		if (bonus_round > 0) {
			global.give_bonus_shines = true;
		}
	}
});

alarm_create(function() {
	var player_gone = [];
	var place = -1;

	for (var i = 4; i >= 1; i--) {
		with (objPlayerBase) {
			if (lost) {
				continue;
			}
		
			var player_info = player_info_by_id(network_id);
		
			if (player_info.place == i) {
				array_push(player_gone, player_info.turn);
			}
		}
	
		if (array_length(player_gone) > 0) {
			place = i;
			break;
		}
	}

	if (place == previous_place) {
		alarm_frames(1, 1);
		return;
	}

	previous_place = place;

	if (place == 1) {
		alarm_call(2, 0.5);
		return;
	}

	for (var i = 1; i <= global.player_max; i++) {
		var player = focus_player_by_turn(i);
	
		if (player.lost) {
			continue;
		}
	
		var c = instance_create_layer(player.x, -32, "Actors", objResultsCherry);
	
		switch (place) {
			case 4: c.sprite_index = sprResultsCherry4th; break;
			case 3: c.sprite_index = sprResultsCherry3rd; break;
			case 2: c.sprite_index = sprResultsCherry2nd; break;
		}
	
		c.image_xscale = 5 - place;
		c.image_yscale = 5 - place;
		c.place = place;
		c.down = array_contains(player_gone, i);
	}
});

alarm_create(function() {
	audio_stop_sound(sndResultsDrumRoll);
	music_play(bgmPartyStar);
	revealed = true;

	var get_turn_winner = infinity;
	var count = 0;
	var winners = "";
	
	with (objPlayerBase) {
		if (lost) {
			continue;
		}
		
		count++;
		winners += string("{COLOR,0000FF}{0}{COLOR,FFFFFF}, ", network_name);
		
		var turn = player_info_by_id().turn;

		if (turn < get_turn_winner) {
		    get_turn_winner = turn;
		}
	}

	if (global.player_id == 1) {
		winners = string_copy(winners, 1, string_length(winners) - 2);
		var text = "";
	
		switch (count) {
			case 1: text = language_get_text("PARTY_RESULTS_PARTY_WON_ONE", ["{Player}", winners]); break;
			case 2: text = language_get_text("PARTY_RESULTS_PARTY_WON_TWO", ["{Players}", winners]); break;
			case 3: text = language_get_text("PARTY_RESULTS_PARTY_WON_THREE", ["{Players}", winners]); break;
			case 4: text = language_get_text("PARTY_RESULTS_PARTY_WON_FOUR", ["{Players}", winners]); break;
		}
	
		start_dialogue([
			new Message(text,, results_end)
		]);
	}
	
	var confetti_effect = instance_create_layer(384, 160, "Particle", objResultsConfetti,{
		player_won_color : get_turn_winner
	});
});

alarm_create(function() {
	if (bonus_round == 3) {
		global.give_bonus_shines = false;
		alarm_frames(0, 1);
		return;
	}

	var bonus = bonus_candidates[bonus_round];
	var b = instance_create_layer(400, 400, "Actors", objResultsBonusShine);
	b.bonus = bonus;
	bonus_round++;
});