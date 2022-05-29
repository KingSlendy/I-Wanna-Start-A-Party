//Counts the maximum colors between the cards
var blue_count = array_count(player_colors, c_blue);
var red_count = array_count(player_colors, c_red);
info.player_colors = [
	(blue_count > red_count) ? c_blue : c_red,
	(blue_count > red_count) ? c_red : c_blue
];

var colors = info.player_colors;
var pos_index = 0;

if (blue_count == 4 || red_count == 4) { //4vs
	with (objPlayerInfo) {
		var len = 50;
		var dir = point_direction(draw_x + draw_w / 2, draw_y + draw_h / 2, 400, 304);
		target_draw_x = draw_x - lengthdir_x(len, dir);
		target_draw_y = draw_y - lengthdir_y(len, dir);
	}
	
	show_popup("4 player minigame",, 100,,, false);
	info.type = "4vs";
} else if (blue_count == 3 || red_count == 3) { //1vs3	
	with (objPlayerInfo) {
		if (player_info.space == colors[1]) {
			target_draw_x = 225 - draw_w / 2;
			target_draw_y = 304 - draw_h / 2;
		}
	}
	
	with (objPlayerInfo) {
		if (player_info.space == colors[0]) {
			target_draw_x = 575 - draw_w / 2;
			target_draw_y = 304 - draw_h / 2 - draw_h + draw_h * pos_index++;
		}
	}
	
	show_popup("1 vs. 3 minigame",, 100,,, false);
	info.type = "1vs3";
} else { //2vs2
	with (objPlayerInfo) {
		if (player_info.space == colors[0]) {
			target_draw_x = 225 - draw_w / 2;
			target_draw_y = 304 - draw_h + draw_h * pos_index++;
		}
	}
	
	pos_index = 0;
	
	with (objPlayerInfo) {
		if (player_info.space == colors[1]) {
			target_draw_x = 575 - draw_w / 2;
			target_draw_y = 304 - draw_h + draw_h * pos_index++;
		}
	}
	
	show_popup("2 vs. 2 minigame",, 100,,, false);
	info.type = "2vs2";
}

minigame_list = [
	global.minigames[$ info.type][1],
	global.minigames[$ info.type][1],
	global.minigames[$ info.type][1],
	global.minigames[$ info.type][1],
	global.minigames[$ info.type][1],
];

//minigame_list = [];

//var minigames_now = global.minigames[$ info.type];

//for (var i = 0; i < 5; i++) {
//	array_push(minigame_list, minigames_now[irandom(array_length(minigames_now) - 1)]);
//}

show_popup("VS");
alarm[1] = get_frames(2);