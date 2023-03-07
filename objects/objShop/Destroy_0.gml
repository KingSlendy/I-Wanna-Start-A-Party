if (is_local_turn()) {
	with (objDialogue) {
		if (!endable) {
			endable = true;
			text_end();
		}
	}
}

global.buy_choice = -1;