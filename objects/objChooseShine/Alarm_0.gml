if (room == rBoardHotland && instance_number(objShine) <= 1) {
	if (is_local_turn()) {
		choose_shine();
	}
	
	instance_destroy(id, false);
	exit;
}

fade_state = 1;