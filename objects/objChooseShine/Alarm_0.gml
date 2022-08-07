if (instance_number(objShine) < global.shine_spawn_count) {
	if (is_local_turn()) {
		choose_shine();
	}
	
	instance_destroy(id, false);
	exit;
}

fade_state = 1;