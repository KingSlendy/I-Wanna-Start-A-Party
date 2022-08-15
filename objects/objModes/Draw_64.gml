for (var i = 0; i < array_length(mode_buttons); i++) {
	var button = mode_buttons[i];
		
	if (button == null) {
		continue;
	}
		
	button.check(mode_selected == i);
	button.draw(0);
}

controls_text.draw(420, 580);