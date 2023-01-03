image_alpha = lerp(image_alpha, alpha_target, 0.3);

if (vspeed == 0) {
	sprite_index = (follow_path == null) ? skin[$ "Idle"] : skin[$ "Run"];
} else {
	sprite_index = (vspeed < 0) ? skin[$ "Jump"] : skin[$ "Fall"];
}

if (vspeed > 0 && y >= jump_y) {
	vspeed = 0;
	gravity = 0;
	y = jump_y;
}