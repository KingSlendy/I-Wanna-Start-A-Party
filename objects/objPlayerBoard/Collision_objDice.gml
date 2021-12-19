if (!is_player_turn()) {
	return;
}

y = yprevious;

while (!place_meeting(x, y - 1, other)) {
	y--;
}

vspeed = 0;
roll_dice();