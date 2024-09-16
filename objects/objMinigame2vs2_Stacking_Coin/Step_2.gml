if (following_id == null) {
	exit;
}

var player = focus_player_by_id(following_id);
x = player.x - 10;
y = player.y - 40;