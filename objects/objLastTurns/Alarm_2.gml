if (is_local_turn()) {
	start_dialogue([
		"Since you're already here, how about a little something extra?",
		new Message("Hit the block to reveal what exciting event is gonna be applied to the whole board!",, spawn_last_turns_box)
	]);
}