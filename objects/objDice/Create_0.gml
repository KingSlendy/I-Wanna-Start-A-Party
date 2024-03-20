event_inherited();
box_activate = method(id, roll_dice);

if (global.board_started && is_player_turn()) {
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
	var min_roll = 1;
	var max_roll = 10;
	
	switch (player_info.item_effect) {
		case ItemType.Poison:
			max_roll = 3;
			break;
			
		case ItemType.Clock:
			if (++roll > 10) {
				roll = min_roll;
			}
			return;
	}
	
	if (!is_player_turn()) {
		min_roll = 5;
		max_roll = 8;
	}
	
	var previous = roll;
	
	do {
		roll = irandom_range(min_roll, max_roll);
	} until (roll != previous);
	
	//if (global.board_started) {
	//	//if (is_player_turn()) {
	//	//	roll = 1;
	//	//} else {
	//	//	roll = 1;
	//	//}

	//	//roll = max_roll;
	//	//roll = min_roll;
	//	//roll = 110;
	//}
}

roll = 0;
random_roll();
roll_spd = (player_info.item_effect != ItemType.Clock) ? 0.08 : 0.5;

alarms_init(1);

alarm_create(function() {
	random_roll();

	if (layer_sequence_is_finished(sequence)) {
		audio_play_sound(sndDiceRoll, 0, false);
	}

	alarm_call(0, roll_spd);
});

alarm_call(0, roll_spd);

if (global.board_started && instance_number(object_index) > 1) {
	instance_destroy();
}