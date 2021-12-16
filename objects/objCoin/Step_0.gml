if (vspeed > 0) {
	var focus = focus_player();

	if (instance_place(x, y, focus)) {
		instance_destroy();
	}
}