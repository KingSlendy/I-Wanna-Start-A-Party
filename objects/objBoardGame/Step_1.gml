if (global.player_id == 1 && !sent_id && get_player_count(objPlayerBoardID) == global.player_max) {
	obtain_same_game_id();
	sent_id = true;
}

if (global.player_id == 1 && !sent_data && get_player_count(objPlayerBoardData) == global.player_max) {
	obtain_player_game_ids();
	sent_data = true;
}