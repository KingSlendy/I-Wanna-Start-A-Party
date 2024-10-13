function player_jump() {
	if (room != rMinigame4vs_Dizzy) {
		if ((jump_total > 0 || jump_total == -1) && on_block || place_meeting(x, y + 1, objPlatform) || place_meeting(x, y, objMinigame4vs_Painting_Platform)) {
			vspd = -(jump_height[0] * orientation);
			
			if (room == rMinigame4vs_Drawn) {
				var b = instance_place(x, y + 1, objMinigame4vs_Drawn_Block);
	
				if (b != noone && b.image_blend == c_lime) {
					vspd = -16;
					audio_play_sound(sndMinigame4vs_Drawn_Block, 0, false);
				}
			}
			
			sprite_index = skin[$ "Jump"];
			reset_jumps();
			audio_play_sound(sndJump, 0, false);
			
			buffer_seek_begin();
			buffer_write_action(ClientUDP.PlayerJump);
			buffer_write_data(buffer_u32, sndJump);
			network_send_udp_packet();
			
			if (room == rMinigame1vs3_Hunt && network_id == global.player_id) {
				objMinigameController.trophy_jump = false;
			}
		} else if (jump_left > 0 || jump_total == -1 || place_meeting(x, y, objMinigame4vs_Bullets_Bullet)) {
			vspd = -(jump_height[1] * orientation);
			sprite_index = skin[$ "Jump"];
		
			if (jump_left > 0) {
				jump_left--;
			}
			
			if (place_meeting(x, y, objMinigame4vs_Bullets_Bullet)) {
				reset_jumps();
			}
		
			audio_play_sound(sndDoubleJump, 0, false);
			
			buffer_seek_begin();
			buffer_write_action(ClientUDP.PlayerJump);
			buffer_write_data(buffer_u32, sndDoubleJump);
			network_send_udp_packet();
			
			if (room == rMinigame4vs_Drawn && network_id == global.player_id) {
				objMinigameController.trophy_double = false;
			}
		}
	} else {
		if (on_block) {
			flip_orientation();
			vspd = jump_height[0] * orientation;
		
			audio_play_sound((orientation == -1) ? sndFlipU : sndFlipD, 0, false);
			
			buffer_seek_begin();
			buffer_write_action(ClientUDP.PlayerJump);
			buffer_write_data(buffer_u32, (orientation == -1) ? sndFlipU : sndFlipD);
			network_send_udp_packet();
		}
	}
}

function player_fall() {
	if (room != rMinigame4vs_Dizzy) {
		if (vspd * orientation < 0) {
			vspd *= 0.45;
		}
	}
}

function player_shoot(speed = null, direction = null) {
	var can_shoot = true;
		
	switch (room) {
		case rMinigame4vs_Targets:
			with (objMinigameController) {
				if (player_bullets[player_turn - 1] <= 0) {
					can_shoot = false;
				}
			}
			break;
			
		case rMinigame4vs_Treasure:
			if (network_id == global.player_id) {
				objMinigameController.trophy_obtain = false;
			}
			break;
			
		case rMinigame2vs2_Duel:
			with (objMinigameController) {
				can_shoot = player_can_shoot[other.network_id - 1];
				player_can_shoot[other.network_id - 1] = false;
			
				if (can_shoot && !take_time) {
					if (other.network_id == global.player_id) {
						trophy_shoot = true;
					}
					
					with (other) {
						player_kill();
					}
					
					return;
				} else if (other.network_id == global.player_id) {
					trophy_obtain = false;
					trophy_shoot = false;
				}
			}
			break;
	}
		
	if (!can_shoot) {
		return;
	}
	
	var b = instance_create_layer(x, y, "Actors", objBullet);
	b.network_id = network_id;
	
	if (speed == null && direction == null) {
		b.speed = 16;
		b.direction = (((object_index == objPlayerPlatformer) ? xscale : image_xscale) == 1) ? 0 : 180;
	} else {
		b.speed = speed;
		b.direction = direction;
	}
	
	b.direction = (b.direction + 360) % 360;
	
	buffer_seek_begin();
	buffer_write_action(ClientTCP.PlayerShoot);
	buffer_write_data(buffer_u8, network_id);
	buffer_write_data(buffer_s16, x);
	buffer_write_data(buffer_s16, y);
	buffer_write_data(buffer_s8, b.speed);
	buffer_write_data(buffer_u16, b.direction);
	network_send_tcp_packet();
	
	if (room == rMinigame2vs2_Duel) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame2vs2_Duel_Shot);
		buffer_write_data(buffer_u8, network_id);
		buffer_write_data(buffer_u16, objMinigameController.player_shot_time[network_id - 1]);
		network_send_tcp_packet();
	}
}

function reset_jumps() {
	jump_left = jump_total - 1;
}

function set_mask() {
	mask_index = (orientation == 1) ? sprPlayerMask : sprPlayerMaskFlip;
}

function flip_orientation() {
	orientation *= -1;
	set_mask();
	vspd = 0;
	y += 4 * orientation;
	reset_jumps();
}

function player_kill(network = false) {
	if (!lost && (is_player_local(network_id) || network)) {
		if (room != rMinigame4vs_Rocket) {
			instance_create_layer(x, y, "Actors", objBloodEmitter);
			audio_play_sound(sndDeath, 0, false);
		} else {
			instance_create_layer(x, y, "Actors", objExplosion);
			audio_play_sound(sndExplosion, 0, false, 0.7);
		}
		
		frozen = true;
		grav_amount = 0;
		lost = true;
		
		with (objCameraSplit4) {
			dead[player_info_by_id(other.network_id).turn - 1] = true;
		}
		
		if (!network) {
			buffer_seek_begin();
			buffer_write_action(ClientTCP.PlayerKill);
			buffer_write_data(buffer_u8, network_id);
			network_send_tcp_packet();
		}
	}
}