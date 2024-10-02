event_inherited();

with (objCamera) {
	lock_x = true;
	lock_y = true;
	boundaries = true;
	camera_correct_position(id);
}