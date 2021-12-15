y = yprevious;

while (!place_meeting(x, y - 1, objDice)) {
	y--;
}

vspeed = 0;
roll_dice();