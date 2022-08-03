if (fade_start && get_player_count(objPlayerBoard) == global.player_max) {
	fade_alpha -= 0.03;
	var room_name = room_get_name(room);
	var bgm_name = "bgm" + string_copy(room_name, 2, string_length(room_name) - 1);
	
	if (room == rBoardIsland && !global.board_day) {
		bgm_name += "Night";
	}
	
	music_play(asset_get_index(bgm_name));
	
	if (fade_alpha <= 0) {
		fade_alpha = 0;
		fade_start = false;
		board_start();
	}
}

if (!global.board_started) {
	if (!tell_choices && is_local_turn() && instance_number(objDiceRoll) == global.player_max) {
		tell_turns();
		tell_choices = true;
	}
}