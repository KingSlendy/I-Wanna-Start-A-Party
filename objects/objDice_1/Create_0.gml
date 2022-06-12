event_inherited();
box_activate = roll_dice;

if (global.board_started) {
	player_info = player_info_by_turn();
} else {
	player_info = {item_effect: -1};
}

switch (player_info.item_effect) {
	case ItemType.DoubleDice: image_index = 1; break;
	case ItemType.TripleDice: image_index = 2; break;
	case ItemType.Poison: image_index = 3; break;
	case ItemType.Clock: image_index = 4; break;
}

function random_roll() {
	var max_roll = 10;
	
	switch (player_info.item_effect) {
		case ItemType.Poison:
			max_roll = 3;
			break;
			
		case ItemType.Clock:
			if (++roll > 10) {
				roll = 10;
			}
			return;
	}
	
	var previous = roll;
	
	do {
		roll = irandom_range(1, max_roll);
	} until (roll != previous);
	
	//roll = max_roll;
	//roll = 1;
}

roll = 0;
random_roll();
roll_spd = (player_info.item_effect != ItemType.Clock) ? 4 : get_frames(0.75);
alarm[0] = roll_spd;