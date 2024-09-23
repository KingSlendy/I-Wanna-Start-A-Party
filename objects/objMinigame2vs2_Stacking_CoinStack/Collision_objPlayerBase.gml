if (objMinigameController.info.is_finished || !is_player_local(other.network_id) || other.y < 304 || stacked_id != null || stacked_falling || array_length(other.coin_line_stack) > 0) {
	exit;
}

coin_line_stack_add(other.network_id);