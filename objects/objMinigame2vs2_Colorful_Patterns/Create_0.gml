pattern_rows = 5;
pattern_cols = 8;
pattern_grid = [];
pattern_round = -1;
pattern_player_ids = null;
pattern_row_selected = [0, 0];
pattern_col_selected = [0, 0];

//Animation
wave_move = [0, 0];
wave_timer = [0, 0];
wave_length = 4;
option_selected = [false, false];

function wave_animation(index) {
    if (option_selected[index]) {
        wave_move[index] = lengthdir_x(wave_length, wave_timer[index]) - wave_length;
        wave_timer[index] = (wave_timer[index] + 360 + 5) % 360;
    } else {
        wave_reset_animation(index);
    }
}

function wave_reset_animation(index) {
    wave_move[index] = lerp(wave_move[index], 0, 0.20);
    wave_timer[index] = 0;
}

function Pattern(pattern) constructor {
	self.image = pattern.image;
	self.colorA = pattern.colorA;
	self.colorB = pattern.colorB;
	
	static equals = function(pattern) {
		return (self.image == pattern.image && self.colorA == pattern.colorA && self.colorB == pattern.colorB);
	}
	
	static draw = function(x, y) {
		draw_sprite_ext(sprMinigame2vs2_Colorful_PatternA, self.image, x, y, 1, 1, 0, self.colorA, 1);
		draw_sprite_ext(sprMinigame2vs2_Colorful_PatternB, self.image, x, y, 1, 1, 0, self.colorB, 1);
		draw_set_color(c_black);
		draw_rectangle(x, y, x + 31, y + 31, true);
	}
}

function pattern_grid_init() {
	for (var r = 0; r < pattern_rows; r++) {
		pattern_grid[r] = [];
	
		for (var c = 0; c < pattern_cols; c++) {
			pattern_grid[r][c] = null;
		}
	}
}

function pattern_grid_start() {
	pattern_grid_init();
	pattern_grid_generate();
}

function pattern_choose(chosen = null) {
	while (true) {
		var pattern = new Pattern({
			image: irandom(sprite_get_number(sprMinigame2vs2_Colorful_PatternA) - 1),
			colorA: choose(c_red, c_orange, c_yellow, c_lime),
			colorB: choose(c_blue, c_fuchsia, c_purple)
		});
		
		if (chosen == null) {
			return pattern;
		}
		
		var break_loop = false;
		
		for (var r = 0; r < pattern_rows; r++) {
			for (var c = 0; c < pattern_cols; c++) {
				var check_pattern = pattern_grid[r][c];
				
				if (check_pattern != null && (pattern.equals(check_pattern) || pattern.equals(chosen))) {
					break_loop = true;
					break;
				}
			}
			
			if (break_loop) {
				break;
			}
		}
		
		if (!break_loop) {
			return pattern;
		}
	}
}

function pattern_grid_generate() {
	if (objMinigameController.info.is_finished) {
		return;
	}
	
	pattern_round++;
	
	if (pattern_round == 4) {
		minigame2vs2_points(pattern_player_ids[0], pattern_player_ids[1]);
		minigame_finish();
		
		if (array_contains(pattern_player_ids, global.player_id) && objMinigameController.trophy_found && !trial_is_title(COLORFUL_MADNESS)) {
			achieve_trophy(22);
		}
		
		return;
	}
	
	random_set_seed(objMinigameController.round_seed[pattern_round][(x < 400)]);
	pattern_selected = [false, false];
	pattern_chosen = pattern_choose();

	for (var r = 0; r < pattern_rows; r++) {
		for (var c = 0; c < pattern_cols; c++) {
			pattern_grid[r][c] = pattern_choose(pattern_chosen);
		}
	}
	
	var choose_rows = array_sequence(0, pattern_rows);
	var choose_cols = array_sequence(0, pattern_cols);
	
	repeat (2) {
		array_shuffle_ext(choose_rows);
		array_shuffle_ext(choose_cols);
		var chosen_r = choose_rows[0];
		var chosen_c = choose_cols[0];
		pattern_grid[chosen_r][chosen_c] = new Pattern(pattern_chosen);
		array_delete(choose_rows, 0, 1);
		array_delete(choose_cols, 0, 1);
	}
	
	with (objPlayerBase) {
		found = false;
		
		if (trial_is_title(COLORFUL_MADNESS) && network_id == focus_player_by_id().teammate.network_id) {
			find_timer = infinity;
			found = false;
			continue;
		}
		
		find_timer = get_frames(min(irandom_range(5, 30), 20));
	}
}

function pattern_move_vertical(index, v, network = true) {
	if (network) {
		pattern_row_selected[index] = (pattern_row_selected[index] + pattern_rows + v) % pattern_rows;
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame2vs2_Colorful_PatternMoveVertical);
		buffer_write_data(buffer_u16, x);
		buffer_write_data(buffer_u8, pattern_round);
		buffer_write_data(buffer_u8, index);
		buffer_write_data(buffer_u8, pattern_row_selected[index]);
		network_send_tcp_packet();
	} else {
		pattern_row_selected[index] = v;
	}
	
	audio_play_sound(sndMinigame2vs2_Colorful_PatternMove, 0, false);
}

function pattern_move_horizontal(index, h, network = true) {
	if (network) {
		pattern_col_selected[index] = (pattern_col_selected[index] + pattern_cols + h) % pattern_cols;
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame2vs2_Colorful_PatternMoveHorizontal);
		buffer_write_data(buffer_u16, x);
		buffer_write_data(buffer_u8, pattern_round);
		buffer_write_data(buffer_u8, index);
		buffer_write_data(buffer_u8, pattern_col_selected[index]);
		network_send_tcp_packet();
	} else {
		pattern_col_selected[index] = h;
	}
	
	audio_play_sound(sndMinigame2vs2_Colorful_PatternMove, 0, false);
}

function pattern_select(index, network = true) {
	if (!alarm_is_stopped(0)) {
		return;
	}
	
	var player_id = pattern_player_ids[index];
	pattern_selected[index] ^= true;
			
	if (pattern_selected[index] && pattern_grid[pattern_row_selected[index]][pattern_col_selected[index]].equals(pattern_chosen)) {
		var player = focus_player_by_id(player_id);
		
		if (!trial_is_title(COLORFUL_MADNESS)) {
			player.teammate.find_timer *= 0.25;
			player.teammate.find_timer = ceil(player.teammate.find_timer);
		} else {
			player.teammate.find_timer = 0;
		}
		
		if (player_id == global.player_id) {
			if (pattern_selected[!index]) {
				objMinigameController.trophy_found = false;
			}
		}
	}
			
	option_selected[index] = pattern_selected[index]; 
	audio_play_sound(sndMinigame2vs2_Colorful_PatternSelect, 0, false);
			
	if (pattern_selected[index] && pattern_selected[!index]) {
		var me_row = pattern_row_selected[index];
		var me_col = pattern_col_selected[index];
		var other_row = pattern_row_selected[!index];
		var other_col = pattern_col_selected[!index];
				
		if ((me_row != other_row || me_col != other_col) && pattern_grid[me_row][me_col].equals(pattern_chosen) && pattern_grid[other_row][other_col].equals(pattern_chosen)) {
			wave_timer = [0, 0];
			option_selected = [false, false];
			alarm_call(0, 1);
			audio_play_sound(sndMinigame2vs2_Colorful_PatternCorrect, 0, false);
		}
	}
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame2vs2_Colorful_PatternSelect);
		buffer_write_data(buffer_u16, x);
		buffer_write_data(buffer_u8, pattern_round);
		buffer_write_data(buffer_u8, index);
		network_send_tcp_packet();
	}
}

alarms_init(1);

alarm_create(function() {
	pattern_grid_generate();
});