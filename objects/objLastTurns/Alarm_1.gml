if (is_local_turn()) {
	start_dialogue([
		"Good party everyone! It has been super fun so far, but we're nearing the end, only a couple turns left!",
		new Message("This is the perfect time to spice things up a little bit, but first let's see how everyone is doing so far...",, say_player_place)
	]);
}
