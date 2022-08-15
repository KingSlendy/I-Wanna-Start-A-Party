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
				roll = 1;
			}
			return;
	}
	
	var previous = roll;
	
	do {
		roll = irandom_range(1, max_roll);
	} until (roll != previous);
	
	if (global.board_started) {
		//roll = max_roll;
		//roll = 1;
		roll = 4;
	}
}

roll = 0;
random_roll();
roll_spd = (player_info.item_effect != ItemType.Clock) ? 0.08 : 0.75;

alarms_init(1);

alarm_create(function() {
	random_roll();

	if (layer_sequence_is_finished(sequence)) {
		audio_play_sound(sndDiceRoll, 0, false);
	}

	alarm_call(0, roll_spd);
});

alarm_call(0, roll_spd);