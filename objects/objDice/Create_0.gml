depth = -10000;
player_turn_info = get_player_turn_info();

switch (player_turn_info.item_effect) {
	case ItemType.Dice: image_index = 1; break;
	case ItemType.DoubleDice: image_index = 2; break;
	case ItemType.Poison: image_index = 3; break;
	case ItemType.Clock: image_index = 4; break;
}

image_xscale = 0;
image_yscale = 0;

sequence = layer_sequence_create("Assets", x, y, seqDice);
sequence_instance_override_object(layer_sequence_get_instance(sequence), objDice, id);

function random_roll() {
	var max_roll;
	
	switch (player_turn_info.item_effect) {
		case ItemType.Poison:
			max_roll = 3;
			break;
			
		case ItemType.Clock:
			if (++roll > 10) {
				roll = 10;
			}
			return;
			
		default: max_roll = 10; break;
	}
	
	var previous = roll;
	
	do {
		roll = irandom_range(1, max_roll);
	} until (roll != previous);
	
	roll = max_roll;
}

roll = 0;
random_roll();
roll_spd = (player_turn_info.item_effect != ItemType.Clock) ? 4 : game_get_speed(gamespeed_fps) * 0.75;
alarm[0] = roll_spd;