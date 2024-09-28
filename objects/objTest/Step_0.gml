if (keyboard_check_pressed(ord("T"))) {
	instance_create_layer(0, 0, "Managers", objRouletteTest);
	instance_destroy();
}