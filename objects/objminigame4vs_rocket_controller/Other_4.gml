event_inherited();

with (objPlayerBase) {
	image_angle = (point_direction(room_width / 2, room_height / 2, x, y) + 360 - 90) % 360;
}

objCameraSplit4.boundaries = true;