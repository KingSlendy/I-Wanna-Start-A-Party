depth = -10010;
state = 0;
fade_alpha = 0;
zoom = false;
player_colors = [];
info = global.minigame_info;
minigame_total = 5;
minigames_alpha = 0;
minigames_width = 300;
minigames_height = 40;
minigames_timer = 3;
shuffle_seed_bag();
reset_seed_inline();
minigames_chosen = irandom(minigame_total - 1);
global.choice_selected = irandom(minigame_total - 1);

//Temp
force_type = null;
force_num = -1;
force_minigames = true;
//Temp

with (objBoard) {
	alarm_stop(11);
}

function choosed_minigame() {
	var minigame = minigame_list[global.choice_selected];
	info.reference = minigame;
	
	if (!array_contains(global.seen_minigames, minigame.title)) {
		array_push(global.seen_minigames, minigame.title);
	}
	
	if (array_length(global.seen_minigames) == array_length(global.minigames[$ "4vs"]) + array_length(global.minigames[$ "1vs3"]) + array_length(global.minigames[$ "2vs2"])) {
		achieve_trophy(64);
	}
	
	array_push(global.minigame_history, minigame.title);
	audio_play_sound(sndRoulettePick, 0, false);
	alarm_call(3, 1);
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
	
	room_goto(rMinigameOverview);
}

alarms_init(2);

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
	var minigames_now = global.minigames[$ info.type];
	var minigame_count = {};
	var minigame_names = [];

	for (var i = 0; i < array_length(minigames_now); i++) {
		var minigame = minigames_now[i];
		minigame_count[$ minigame.title] = (array_length(global.minigame_history) > 0) ? array_count(global.minigame_history, minigame.title) / array_length(global.minigame_history) : 0;
		array_push(minigame_names, minigame.title);
	}

	var minigame_add = true;

	while (minigame_add) {
		next_seed_inline();
		array_shuffle(minigame_names);
		var min_minigame = infinity;
	
		for (var i = 0; i < array_length(minigame_names); i++) {
			min_minigame = min(min_minigame, minigame_count[$ minigame_names[i]]);
		}
	
		for (var i = array_length(minigame_names) - 1; i >= 0; i--) {
			minigame_name = minigame_names[i];
		
			if (minigame_count[$ minigame_name] == min_minigame) {
				array_push(minigame_list, array_first(minigames_now, function(x) { return (x.title == minigame_name); }));
			
				if (array_length(minigame_list) == 5) {
					minigame_add = false;
					break;
				}
			
				array_delete(minigame_names, i, 1);
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

	show_popup("VS");
	audio_play_sound(sndChooseMinigame, 0, false);
	alarm_call(1, 2);
});

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

alarm_create(function() {
	global.choice_selected = (global.choice_selected + 1 + minigame_total) % minigame_total;
	audio_play_sound(sndRouletteRoll, 0, false);

	minigames_timer += 0.10;
	next_seed_inline();

	if (minigames_timer > 6 && irandom(1) == 0 && global.choice_selected == minigames_chosen) {
		choosed_minigame();	
		exit;
	}

	alarm_frames(2, floor(minigames_timer));
});

alarm_create(function() {
	state = 3;
});