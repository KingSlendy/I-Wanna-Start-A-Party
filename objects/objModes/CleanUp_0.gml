for (var i = 0; i < array_length(mode_buttons); i++) {
	if (sprite_exists(mode_buttons[i].sprite)) {
		sprite_delete(mode_buttons[i].sprite);
	}
}