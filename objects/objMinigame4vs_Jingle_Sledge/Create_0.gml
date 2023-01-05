depth = layer_get_depth("Marks") + 1;
player_id = 0;
shot = false;
stopped = false;

function sledge_shoot(network = true) {
	if (shot) {
		return;
	}
	
	instance_create_layer(x + sprite_width, y + 8, "Actors", objMinigame4vs_Jingle_Snowflake);
	shot = true;
	alarm_call(2, 1);
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame4vs_Jingle_SledgeShoot);
		buffer_write_data(buffer_u8, player_id);
		network_send_tcp_packet();
	}
}

function sledge_jump(network = true) {
	if (y != ystart) {
		return;
	}
			
	vspeed = -6;
	gravity = 0.3;
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame4vs_Jingle_SledgeJump);
		buffer_write_data(buffer_u8, player_id);
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
		alarm_pause(4 + (other.player_id - 1));
		set_spd(0, other.player_id);
	}

	alarm_call(0, 1);
	alarm_call(1, 2);
	audio_play_sound(sndGlassBreak, 0, false);
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame4vs_Jingle_SledgeHit);
		buffer_write_data(buffer_u8, player_id);
		network_send_tcp_packet();
	}
}

alarms_init(3);

alarm_create(function() {
	if (objMinigameController.info.is_finished) {
		return;
	}
	
	stopped = false;
	
	with (objMinigameController) {
		alarm_resume(4 + (other.player_id - 1));
		set_spd(-7, other.player_id);
	}
});

alarm_create(function() {
	image_alpha = 1;
});

alarm_create(function() {
	shot = false;
});