current_player = player1;
		
switch_camera_target(current_player.x, current_player.y).final_action = function() {
	global.player_turn = turn_previous;
	state = 0;
}