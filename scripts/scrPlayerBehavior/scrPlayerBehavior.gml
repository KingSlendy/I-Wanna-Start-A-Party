function player_jump() {
	if ((jump_total > 0 || jump_total == -1) && on_block) {
		vspd = -(jump_height[0] * orientation);
		sprite_index = skin[$ "Jump"];
		reset_jumps();
		audio_play_sound(sndJump, 0, false);
	} else if (jump_left > 0 || jump_total == -1) {
		vspd = -(jump_height[1] * orientation);
		sprite_index = skin[$ "Jump"];
		
		if (jump_left > 0) {
			jump_left--;
		}
		
		audio_play_sound(sndDoubleJump, 0, false);
	}
}

function player_fall() {
	if (vspd * orientation < 0) {
		vspd *= 0.45;
	}
}

function player_shoot() {
	var b = instance_create_layer(x, y, "Actors", objBullet);
	b.network_id = network_id;
	b.hspeed = 16 * sign((object_index == objPlayerPlatformer) ? xscale : image_xscale);
	
	buffer_seek_begin();
	buffer_write_action(ClientTCP.PlayerShoot);
	buffer_write_data(buffer_u8, network_id);
	buffer_write_data(buffer_s16, x);
	buffer_write_data(buffer_s16, y);
	buffer_write_data(buffer_s8, b.hspeed);
	network_send_tcp_packet();
}

function reset_jumps() {
	jump_left = jump_total - 1;
}

function set_mask() {
	mask_index = (orientation == 1) ? sprPlayerMask : sprPlayerMask;
}

function flip_grav() {
	orientation *= -1;
	set_mask();
	vspd = 0;
	y += 4 * orientation;
	reset_jumps();
}

function player_kill() {
	instance_create_layer(x, y, "Actors", objBloodEmitter);
	visible = false;
	frozen = true;
}
