if (vspeed > 0) {
	sprite_index = skin[$ "Fall"];
	
	if (y > camera_get_view_y(view_camera[0]) + 450) {
		vspeed = 0;
		gravity = 0;
	}
} else {
	sprite_index = skin[$ "Idle"];
}
