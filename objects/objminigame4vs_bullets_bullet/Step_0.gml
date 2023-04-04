if (x <= 112 - sprite_width) {
	x = 112 + sprite_width * (instance_number(object_index) - 1);
	change_index();
}