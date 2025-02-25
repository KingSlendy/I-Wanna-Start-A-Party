depth = -10010;
state = 0;
fade_alpha = 0;
zoom = false;
player_colors = [];
info = global.minigame_info;
shuffle_seed_bag();
roulette_alpha = 0;
roulette_spin = false;
roulette_spread = 0;
roulette_angle = 270;
roulette_separation = 0;
roulette_spd = 5;
roulette_max_angle = 0;
roulette_max_laps = 0;
roulette_chosen = false;
minigames = null;
minigames_chosen = null;
minigame_previous = null;
minigame_first = true;

//Temp
force_type = null;
force_num = -1;
force_minigames = true;
//Temp

with (objBoard) {
	alarm_stop(11);
}

function choosed_minigame() {
	var minigame = minigame_chosen;
	info.reference = minigame;
	minigame_unlock(minigame.title);
	array_push(global.minigame_history, minigame.title);
	
	//if (array_length(global.minigame_history) > 10) {
	//	array_delete(global.minigame_history, 0, 1);
	//}

	roulette_chosen = true;
	audio_play_sound(sndRoulettePick, 0, false);
	alarm_call(2, 1);
}

function send_to_minigame() {
	info.previous_board = room;
	
	for (var i = 1; i <= global.player_max; i++) {
		var player = focus_player_by_id(i);
		array_push(info.player_positions, {x: player.x, y: player.y});
	}
	
	with (objSpaces) {
		array_push(other.info.space_indexes, {x: self.x, y: self.y, index: image_index, shine: space_shine});
	}
	
	with (objShine) {
		array_push(other.info.shine_positions, [x, y]);
	}
	
	with (objBoardWorldGhost) {
		other.info.ghost_position = {x: self.x, y: self.y};	
	}
	
	//Save the music position for when we come back to the Board
	board_save_track_position();
	
	// Overview room
	room_goto(rMinigameOverview);
}



alarms_init(2);

//Alarm 0 - Show vs. and get list of minigames to select
alarm_create(function() {
	//Counts the maximum colors between the cards
	var blue_count = array_count(player_colors, c_blue);
	var red_count = array_count(player_colors, c_red);
	info.player_colors = [
		(blue_count >= red_count) ? c_blue : c_red,
		(blue_count >= red_count) ? c_red : c_blue
	];

	var colors = info.player_colors;
	var pos_index = 0;

	if (blue_count == 4 || red_count == 4) { //4vs
		for (var i = 1; i <= global.player_max; i++) {
			with (focus_info_by_turn(i)) {
				var len = 50;
				var dir = point_direction(draw_x + draw_w / 2, draw_y + draw_h / 2, 400, 304);
				target_draw_x = draw_x - lengthdir_x(len, dir);
				target_draw_y = draw_y - lengthdir_y(len, dir);
			}
		}
	
		show_popup(language_get_text("PARTY_CHOOSE_MINIGAME_4VS"),, 100,,, false);
		info.type = "4vs";
	} else if (blue_count == 3 || red_count == 3) { //1vs3	
		for (var i = 1; i <= global.player_max; i++) {
			with (focus_info_by_turn(i)) {
				if (player_info.space == colors[1]) {
					target_draw_x = 225 - draw_w / 2;
					target_draw_y = 304 - draw_h / 2;
				}
			}
		}
	
		for (var i = 1; i <= global.player_max; i++) {
				with (focus_info_by_turn(i)) {
				if (player_info.space == colors[0]) {
					target_draw_x = 575 - draw_w / 2;
					target_draw_y = 304 - draw_h / 2 - draw_h + draw_h * pos_index++;
				}
			}
		}
	
		show_popup(language_get_text("PARTY_CHOOSE_MINIGAME_1VS3"),, 100,,, false);
		info.type = "1vs3";
	} else { //2vs2
		for (var i = 1; i <= global.player_max; i++) {
			with (focus_info_by_turn(i)) {
				if (player_info.space == colors[0]) {
					target_draw_x = 225 - draw_w / 2;
					target_draw_y = 304 - draw_h + draw_h * pos_index++;
				}
			}
		}
	
		pos_index = 0;
	
		for (var i = 1; i <= global.player_max; i++) {
			with (focus_info_by_turn(i)) {
				if (player_info.space == colors[1]) {
					target_draw_x = 575 - draw_w / 2;
					target_draw_y = 304 - draw_h + draw_h * pos_index++;
				}
			}
		}
	
		show_popup(language_get_text("PARTY_CHOOSE_MINIGAME_2VS2"),, 100,,, false);
		info.type = "2vs2";
	}
	
	minigames = global.minigames[$ info.type];
	roulette_separation = 360 / array_length(minigames);
	array_push(global.minigame_type_history, info.type);
	
	//if (array_length(global.minigame_type_history) > 10) {
	//	array_delete(global.minigame_type_history, 0, 1);
	//}

	var minigames_now = global.minigames[$ info.type];
	var minigame_count = {};
	var minigame_names = [];

	for (var i = 0; i < array_length(minigames_now); i++) {
		var minigame = minigames_now[i];
		minigame_count[$ minigame.title] = array_count(global.minigame_history, minigame.title);
		array_push(minigame_names, minigame.title);
	}

	var minigame_add = true;

	while (minigame_add) {
		next_seed_inline();
		array_shuffle_ext(minigame_names);
		var min_minigame = infinity;
	
		for (var i = 0; i < array_length(minigame_names); i++) {
			min_minigame = min(min_minigame, minigame_count[$ minigame_names[i]]);
		}
	
		for (var i = array_length(minigame_names) - 1; i >= 0; i--) {
			minigame_name = minigame_names[i];
		
			if (minigame_count[$ minigame_name] == min_minigame) {
				minigame_chosen = array_first(array_filter(minigames_now, function(x) { return (x.title == minigame_name); }));
				minigame_add = false;
			}
		}
	}

	//Temp
	if (force_type != null && force_num != -1) {
		minigame_list = [
			global.minigames[$ info.type][force_num],
			global.minigames[$ info.type][force_num],
			global.minigames[$ info.type][force_num],
			global.minigames[$ info.type][force_num],
			global.minigames[$ info.type][force_num],
		];
	}
	//Temp

	next_seed_inline();
	roulette_angle = 270 - roulette_separation * irandom(array_length(minigames) - 1);
	roulette_max_angle = (270 - roulette_separation * array_find_index(minigames, function(x) { return (x.title == minigame_chosen.title); }) + 360) % 360;
	roulette_max_laps = irandom_range(2, 3);

	show_popup("VS");
	audio_play_sound(sndChooseMinigame, 0, false);
	alarm_call(1, 2);
});

//Alarm 1
alarm_create(function() {
	with (objPlayerInfo) {
		if (draw_x < 400) {
			target_draw_x = -draw_w;
		} else {
			target_draw_x = display_get_gui_width();
		}
	}

	state = 2;
});

//Alarm 2 - Minigame roulette end
alarm_create(function() {
	state = 3;
});