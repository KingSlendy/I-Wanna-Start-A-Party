depth = -10000;
event_inherited();

if (!global.warp_space) {
	player1 = focus_player_by_turn();
	player1_pos = {x: player1.x, y: player1.y};
	player2 = focus_player_by_turn(global.choice_selected + 1);
	player2_pos = {x: player2.x, y: player2.y};
} else {
	player = focus_player_by_turn();
	var spaces = [];
	
	with (objSpaces) {
		if (image_index == SpaceType.Warp) {
			array_push(spaces, id);
		}
	}
	
	array_shuffle(spaces);
	pos = {x: spaces[0].x, y: spaces[0].y};
}

scale = 0;
state = 0;
ang = 0;
