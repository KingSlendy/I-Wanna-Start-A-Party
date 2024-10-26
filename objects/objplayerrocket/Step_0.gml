if (!frozen) {
	var move_h = (global.actions.left.held(network_id) - global.actions.right.held(network_id)) * 1.25;
	
	if (network_id == global.player_id && trial_is_title(INVERTED_COMPETITION)) {
		move_h *= -1;
	}
	
	image_angle = (image_angle + 360 + move_h) % 360;
	var move = (global.actions.up.held(network_id) - global.actions.down.held(network_id));
	
	if (move != 0) {
		motion_add(image_angle + 90, move * 0.05);
	}

	speed = clamp(speed, -max_spd, max_spd);
	spd = speed;
	
	if (shoot_delay == 0 && global.actions.shoot.pressed(network_id)) {
		shoot_delay = get_frames(1);
		player_shoot(10, image_angle + 90);
	}
	
	shoot_delay = max(--shoot_delay, 0);
	
	if (/*network_id == global.player_id && */audio_is_playing(audio_idle_looping)) {
	    var sfx_factor = remap(speed, 0, max_spd, 0, 1);
	    audio_sound_gain(audio_idle_looping, sfx_factor, 0);
	    audio_sound_pitch(audio_idle_looping, remap(sfx_factor, 0, 1, 0.5, 1));
	}
} else {
    hspeed = 0;
    vspeed = 0;
	spd -= 0.05;
	spd = max(spd, 0);
}

if (place_meeting(x + hspeed, y, objBlock)) {
	hspeed *= -0.8;
}

if (place_meeting(x, y + vspeed, objBlock)) {
	vspeed *= -0.8;
}

while (place_meeting(x, y, objBlock)) {
	x += lengthdir_x(1, point_direction(x, y, room_width / 2, room_height / 2));
	y += lengthdir_y(1, point_direction(x, y, room_width / 2, room_height / 2));
}