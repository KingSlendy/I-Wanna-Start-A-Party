depth = -10000;

function random_roll() {
	var previous = roll;
	
	do {
		roll = irandom_range(1, 10);
	} until (roll != previous);
}

roll = -1;
random_roll();
roll_spd = 4;
alarm[0] = roll_spd;