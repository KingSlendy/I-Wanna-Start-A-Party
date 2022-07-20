pattern_rows = 5;
pattern_cols = 8;
pattern_grid = [];
pattern_round = -1;
pattern_player_ids = null;
pattern_row_selected = [0, 0];
pattern_col_selected = [0, 0];

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

for (var r = 0; r < pattern_rows; r++) {
	pattern_grid[r] = [];
	
	for (var c = 0; c < pattern_cols; c++) {
		pattern_grid[r][c] = null;
	}
}

function pattern_choose(chosen = null) {
	var pattern;
	
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
				
				if (check_pattern == null) {
					return pattern;
				}
				
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
		
		if (array_contains(pattern_player_ids, global.player_id) && objMinigameController.trophy_found) {
			gain_trophy(22);
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
		array_shuffle(choose_rows);
		array_shuffle(choose_cols);
		var chosen_r = choose_rows[0];
		var chosen_c = choose_cols[0];
		pattern_grid[chosen_r][chosen_c] = new Pattern(pattern_chosen);
		array_delete(choose_rows, 0, 1);
		array_delete(choose_cols, 0, 1);
	}
	
	with (objPlayerBase) {
		find_timer = irandom_range(get_frames(15), get_frames(20));
		found = false;
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
	if (alarm[0] != -1) {
		exit;
	}
	
	var player_id = pattern_player_ids[index];
	pattern_selected[index] ^= true;
			
	if (pattern_selected[index] && pattern_grid[pattern_row_selected[index]][pattern_col_selected[index]].equals(pattern_chosen)) {
		var player = focus_player_by_id(player_id);
		player.teammate.find_timer *= 0.25;
		player.teammate.find_timer = ceil(player.teammate.find_timer);
		
		if (player_id == global.player_id) {
			if (pattern_selected[!index]) {
				objMinigameController.trophy_found = false;
			}
		}
	}
			
	audio_play_sound(sndMinigame2vs2_Colorful_PatternSelect, 0, false);
			
	if (pattern_selected[index] && pattern_selected[!index]) {
		var me_row = pattern_row_selected[index];
		var me_col = pattern_col_selected[index];
		var other_row = pattern_row_selected[!index];
		var other_col = pattern_col_selected[!index];
				
		if ((me_row != other_row || me_col != other_col) && pattern_grid[me_row][me_col].equals(pattern_chosen) && pattern_grid[other_row][other_col].equals(pattern_chosen)) {
			alarm[0] = get_frames(1);
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
