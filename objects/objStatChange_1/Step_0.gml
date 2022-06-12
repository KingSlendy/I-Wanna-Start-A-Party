if (animation_state == 1) {
	animation_alpha += 0.05;
	
	if (animation_alpha >= 2) {
		animation_state = 2;
	}
} else if (animation_state == 2) {
	animation_alpha -= 0.05;
	
	if (animation_alpha < -0.1) {
		instance_destroy();
	}
}