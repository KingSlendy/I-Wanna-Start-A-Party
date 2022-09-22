depth = -8999;
sprite = null;
fade_alpha = 0;
fade_start = false;

show_popup("",,,,,, 4.5);
audio_play_sound(sndResultsSuperstar, 0, false);
displaying = 1;

function minigame_info_placement() {
	places_minigame_repeated = array_create(global.player_max, 0);
	places_minigame_info = [];
	places_minigame_order = [];
		
	for (var i = 1; i <= global.player_max; i++) {
		var info = focus_info_by_turn(i);
		var order = info.player_info.place + places_minigame_repeated[info.player_info.place - 1];
		places_minigame_repeated[info.player_info.place - 1]++;
		array_push(places_minigame_info, info);
		array_push(places_minigame_order, order);
	}
}

minigame_info_placement();

for (var i = 0; i < global.player_max; i++) {
	var p_info = places_minigame_info[i];
	var order = places_minigame_order[i];
	
	with (p_info) {
		target_draw_x = 800 + draw_w;
		target_draw_y = 150 + (draw_h + 10) * (order - 1);
		draw_x = target_draw_x;
		draw_y = target_draw_y;
		self.order = order;
		
		switch (player_info.place) {
			case 1: player_info.space = #FFD700; break;
			case 2: player_info.space = #C0C0C0; break;
			case 3: player_info.space = #CD7F32; break;
			case 4: player_info.space = #2A6E2E; break;
		}
	}
}

stats_bonuses = [
	"most_coins",
	"most_items",
	"most_minigames",
	"most_roll",
	"most_blue_spaces",
	"most_red_spaces",
	"most_green_spaces",
	"most_item_spaces",
	"most_chance_time_spaces",
	"most_the_guy_spaces",
	"most_purchases"
];

stats_x = 800;
stats_target_x = 800;
stats_page = 0;
stats_total_page = array_length(stats_bonuses) div 6;
show_inputs = false;

alarms_init(3);

alarm_create(function() {
	fade_start = true;
	sprite = sprite_create_from_surface(application_surface, 0, 0, 800, 608, false, false, 0, 0);
	alarm_call(1, 1);
});

alarm_create(function() {
	with (objPlayerInfo) {
		if (player_info.place == other.displaying) {
			target_draw_x = 400 - draw_w / 2;
		}
	}

	displaying++;

	if (displaying == 5) {
		alarm_call(2, 2);
		return;
	}

	alarm_call(1, 0.5);
});

alarm_create(function() {
	with (objPlayerInfo) {
		target_draw_x = 50;
	}

	stats_target_x = 320;
	show_inputs = true;

	var player_info = player_info_by_id(global.player_id);

	global.games_played++;
	change_collected_coins(global.max_board_turns * 50 + player_info.shines * 100);
	variable_struct_remove(global.board_games, global.game_id);
	save_file();

	if (player_info.place == 1) {
		achieve_trophy(31);
	}

	if (player_info.place == 4) {
		achieve_trophy(32);
	}

	if (player_info.shines == 0) {
		achieve_trophy(33);
	}

	if (global.max_board_turns == 50) {
		achieve_trophy(39);
	}

	if (array_count(player_info.items, null) == 0) {
		achieve_trophy(40);
	}
	
	if (global.bonus_shines[BonusShines.MostMinigames].scores[player_info.turn - 1] == global.max_board_turns) {
		achieve_trophy(57);
	}
});

alarm_call(0, 5.5);