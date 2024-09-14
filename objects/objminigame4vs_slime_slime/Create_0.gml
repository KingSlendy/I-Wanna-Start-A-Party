alarm_time = 0;

function slime_shot(network = true) {
	sprite_index = sprMinigame4vs_Slime_SlimeShot;
	image_index = 4;
	
	with (objMinigameController) {
		alarm_pause(10);
	}
	
	var player = focus_player_by_turn(objMinigameController.player_turn);
	
	if (is_player_local(player.network_id)) {
		player.frozen = true;
	}
	
	objMinigameController.slime_annoy++;
	audio_play_sound(sndMinigame4vs_Slime_Shot, 0, false);
	music_pause();
	next_seed_inline();
	
	if (network) {
		alarm_time = irandom_range(2, 4);
		
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame4vs_Slime_SlimeShot);
		buffer_write_data(buffer_u8, alarm_time);
		network_send_tcp_packet();
	}
	
	alarm_call(0, alarm_time);
}

alarms_init(2);

alarm_create(function() {
	image_index = (objMinigameController.slime_annoy == objMinigameController.slime_annoyances) ? 1 : 3;

	if (image_index == 3) {
		audio_play_sound(sndMinigame4vs_Slime_Mercy, 0, false);
		image_index = 3;
	} else {
		instance_create_layer(x + sprite_width / 2, y - 20, "Actors", objMinigame4vs_Slime_Laser);
		audio_play_sound(sndMinigame4vs_Slime_Laser, 0, false);
		image_index = 1;
	}

	alarm_call(1, 2);
});

alarm_create(function() {
	sprite_index = sprMinigame4vs_Slime_Slime;

	if (instance_exists(objMinigame4vs_Slime_Block)) {
		objMinigame4vs_Slime_Block.scale_target = 0;
	}

	music_resume();
	var player = focus_player_by_turn(objMinigameController.player_turn);

	if (player.lost) {
		with (objMinigameController) {
			alarm_instant(1);
		}
	
		return;
	}

	player.frozen = false;
	instance_create_layer(384, 480, "Collisions", objMinigame4vs_Slime_Next, {
		image_xscale: 5
	});
	
	with (objMinigameController) {
		alarm_instant(5);
	}
});