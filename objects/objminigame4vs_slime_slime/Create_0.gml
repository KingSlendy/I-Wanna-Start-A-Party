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
	
	audio_play_sound(sndMinigame4vs_Slime_Shot, 0, false);
	music_pause();
	next_seed_inline();
	alarm_call(0, irandom_range(2, 4));
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame4vs_Slime_SlimeShot);
		network_send_tcp_packet();
	}
}

alarms_init(2);

alarm_create(function() {
	next_seed_inline();
	var lost_count = 0;

	with (objPlayerBase) {
		lost_count += lost;	
	}

	image_index = (1 / (5 - lost_count) > random(1)) ? 1 : 3;

	if (image_index == 3) {
		audio_play_sound(sndMinigame4vs_Slime_Mercy, 0, false);
	} else {
		instance_create_layer(x + sprite_width / 2, y - 20, "Actors", objMinigame4vs_Slime_Laser);
		audio_play_sound(sndMinigame4vs_Slime_Laser, 0, false);
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
			unfreeze_player();
		}
	
		return;
	}

	player.enable_shoot = false;
	player.frozen = false;
	instance_create_layer(384, 480, "Collisions", objMinigame4vs_Slime_Next, {
		image_xscale: 5
	});
});