with (objPlayerInfo) {
	target_draw_x = 50;
}

stats_target_x = 320;
show_inputs = true;

var player_info = player_info_by_id(global.player_id);

global.games_played++;
increase_collected_coins(global.max_board_turns * 10 + player_info.shines * 100);
variable_struct_remove(global.board_games, global.game_id);
save_file();

if (player_info.place == 1) {
	gain_trophy(31);
}

if (player_info.place == 4) {
	gain_trophy(32);
}

if (player_info.shines == 0) {
	gain_trophy(33);
}