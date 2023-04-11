depth = layer_get_depth("Marks") + 1;
shot = false;
stopped = false;

function sledge_jump(network = true) {
	if (y != ystart) {
		return;
	}
			
	vspeed = -6;
	gravity = 0.4;
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame4vs_Jingle_SledgeJump);
		buffer_write_data(buffer_u8, player_turn);
		network_send_tcp_packet();
	}
}

function sledge_shoot(network = true) {
	if (shot) {
		return;
	}
	
	instance_create_layer(x + sprite_width, y + 8, "Actors", objMinigame4vs_Jingle_Snowflake, {
		sledge: id
	});
	
	shot = true;
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame4vs_Jingle_SledgeShoot);
		buffer_write_data(buffer_u8, player_turn);
		network_send_tcp_packet();
	}
}

function sledge_toggle(network = true) {
	with (objMinigame4vs_Jingle_Toggle) {
		if (player_turn == other.player_turn) {
			toggle_block();
		}
	}
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame4vs_Jingle_SledgeToggle);
		buffer_write_data(buffer_u8, player_turn);
		network_send_tcp_packet();
	}
}

function sledge_hit(network = true) {
	if (objMinigameController.info.is_finished || image_alpha != 1) {
		return;
	}

	image_alpha = 0.5;
	stopped = true;

	with (objMinigameController) {
		alarm_pause(4 + (other.player_turn - 1));
		set_spd(0, other.player_turn);
	}

	alarm_call(0, 1);
	alarm_call(1, 2);
	audio_play_sound(sndGlassBreak, 0, false);
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame4vs_Jingle_SledgeHit);
		buffer_write_data(buffer_u8, player_turn);
		network_send_tcp_packet();
	}
}

alarms_init(2);

alarm_create(function() {
	if (objMinigameController.info.is_finished) {
		return;
	}
	
	stopped = false;
	
	with (objMinigameController) {
		alarm_resume(4 + (other.player_turn - 1));
		set_spd(-9, other.player_turn);
	}
});

alarm_create(function() {
	image_alpha = 1;
});