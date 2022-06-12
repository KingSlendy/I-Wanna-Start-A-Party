switch (objChanceTime.current_flag++) {
	case 0:
		target_x = x - 48;
		break;
		
	case 1:
		target_x = x + 48;
		break;
}

if (is_local_turn()) {
	with (objChanceTime) {
		advance_chance_time();
	}
}