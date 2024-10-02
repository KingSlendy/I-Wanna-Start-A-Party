vspeed = 3;
gravity = 0.1;

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

smash = crate_destroy();

function crate_explode() {
	crate_destroy();
	audio_stop_sound(sndMinigame4vs_Crates_CrateBreak);
	audio_stop_sound(sndMinigame4vs_Crates_CrateExplode);
	audio_play_sound(sndMinigame4vs_Crates_CrateExplode, 0, false);
	
	if (distance_to_object(objPlayerBase) < 26) {
		kill_player();
	}
	
	var part_type = (object_index != sprMinigame4vs_Crates_CrateNITRO) ? objMinigameController.part_type_crate_tnt : objMinigameController.part_type_crate_nitro;
	part_particles_create(objMinigameController.part_system, x, y, part_type, 30);
}