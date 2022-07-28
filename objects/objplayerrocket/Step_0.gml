if (!frozen) {
	image_angle = (image_angle + 360 + (global.actions.left.held(network_id) - global.actions.right.held(network_id))) % 360;
	
    if (global.actions.up.held(network_id)) {
		motion_add(image_angle + 90, 0.025);
    }
	
	if (global.actions.down.held(network_id)) {
		motion_add(image_angle + 90, -0.025);
	}

	speed = clamp(speed, -max_spd, max_spd);
	
	if (shoot_delay == 0 && global.actions.shoot.pressed(network_id)) {
		shoot_delay = get_frames(1);
		player_shoot(10, image_angle + 90);
	}
	
	shoot_delay = max(--shoot_delay, 0);
} else {
    hspeed = 0;
    vspeed = 0;
}