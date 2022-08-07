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
	
	show_popup("4 vs. minigame",, 100,,, false);
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
	
	show_popup("1 vs. 3 minigame",, 100,,, false);
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
	
	show_popup("2 vs. 2 minigame",, 100,,, false);
	info.type = "2vs2";
}

array_push(global.minigame_type_history, info.type);

minigame_list = [];

next_seed_inline();
var minigames_now = global.minigames[$ info.type];
var minigames_order = array_sequence(0, array_length(minigames_now));
array_shuffle(minigames_order);
array_delete(minigames_order, 5, array_length(minigames_order) - 5);

//Temp
if (force_minigames) {
	switch (info.type) {
		case "4vs":
			break;
			
		case "1vs3":
			minigames_order[4] = 6;
			break;
			
		case "2vs2":
			break;
	}
}
//Temp

array_sort(minigames_order, true);

for (var i = 0; i < 5; i++) {
	array_push(minigame_list, minigames_now[minigames_order[min(i, array_length(minigames_now) - 1)]]);
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

show_popup("VS");
audio_play_sound(sndChooseMinigame, 0, false);
alarm[1] = get_frames(2);