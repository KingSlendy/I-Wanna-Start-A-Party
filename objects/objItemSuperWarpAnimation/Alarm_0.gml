if (!global.warp_space) {
	player2.x = player1_pos.x;
	player2.y = player1_pos.y;
	player1.x = player2_pos.x;
	player1.y = player2_pos.y;
} else {
	player.x = pos.x;
	player.y = pos.y;
}

alarm[1] = get_frames(1);