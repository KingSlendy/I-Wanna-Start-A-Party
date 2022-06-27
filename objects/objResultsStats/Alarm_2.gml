with (objPlayerInfo) {
	target_draw_x = 50;
}

stats_target_x = 320;
show_inputs = true;

global.games_played++;
increase_collected_coins(player_info_by_id(global.player_id).shines * 100);
variable_struct_remove(global.board_games, global.game_id);
save_file();
