hspd = 0;
vspd = 3;
grav = 0.1;
network_id = 0;
count_id = 0;
outside = false;

function crate_smash(network = true) {
	x = xstart;
	
	if (sprite_index == sprMinigame4vs_Crates_Crate) {
		minigame4vs_points(network_id, 1);
		crate_destroy();
	} else {
		if (sprite_index == sprMinigame4vs_Crates_CrateNITRO && minigame4vs_get_points(network_id) > 0) {
			minigame4vs_points(network_id, -1);
		}
		
		with (focus_player_by_id(network_id)) {
			stunned = true;
			alarm_instant(1);
			alarm_call(2, 3);
		}
		
		audio_play_sound(sndHurt, 0, false);
		crate_explode();
	}
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame4vs_Crates_CrateSmash);
		buffer_write_data(buffer_u8, network_id);
		buffer_write_data(buffer_u8, count_id);
		network_send_tcp_packet();
	}
}

function crate_destroy() {
	audio_stop_sound(sndMinigame4vs_Crates_CrateBreak);
	audio_play_sound(sndMinigame4vs_Crates_CrateBreak, 0, false);
	
	var part_type = objMinigameController.part_type_wood_crate;
	
	if (sprite_index == sprMinigame4vs_Crates_CrateTNT) {
		part_type = objMinigameController.part_type_wood_tnt;
	} else if (object_index == sprMinigame4vs_Crates_CrateNITRO) {
		part_type = objMinigameController.part_type_wood_nitro;
	}
	
	part_particles_create(objMinigameController.part_system, x + 16, y + 16, part_type, 1);
	part_particles_create(objMinigameController.part_system, x + 16, y + 16, part_type, 1);
	part_particles_create(objMinigameController.part_system, x - 16, y + 16, part_type, 1);
	part_particles_create(objMinigameController.part_system, x + 31, y + 16, part_type, 1);
	part_particles_create(objMinigameController.part_system, x + 16, y - 16, part_type, 1);
	part_particles_create(objMinigameController.part_system, x + 16, y + 31, part_type, 1);
	
	instance_destroy();
}

function crate_explode() {
	crate_destroy();
	audio_stop_sound(sndMinigame4vs_Crates_CrateBreak);
	audio_stop_sound(sndMinigame4vs_Crates_CrateExplode);
	audio_play_sound(sndMinigame4vs_Crates_CrateExplode, 0, false);
	
	var part_type = (sprite_index != sprMinigame4vs_Crates_CrateNITRO) ? objMinigameController.part_type_explosion_tnt : objMinigameController.part_type_explosion_nitro;
	part_particles_create(objMinigameController.part_system, x + 16, y + 16, part_type, 30);
}

alarm[0] = get_frames(1);