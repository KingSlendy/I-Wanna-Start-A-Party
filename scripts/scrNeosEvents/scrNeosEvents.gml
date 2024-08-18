// New board global variables
// Check line 211 in scrSaveManagement or search fasf (ctrl + shift + F)
global.board_fasf_last5turns_event = false; // Init specual variable to change song in the last 5 turns
global.nusic_board_track_position = 0; // Handle track position when we go back to the board after a minigame

function set_fasf_event(mode = false) {
	global.board_fasf_last5turns_event = mode;
	
	// Change color background
	with objBoardFASFBGManipulation
		apply_red_color_fx();
}

function fasf_play_music() {
	music_play(bgmBoardFASFLast5Turns);
	audio_sound_gain(global.music_current, 1, 500);
}

function fasf_save_track_position() {
	//print("VAMO AL MINIJUEGO");
	if room == rBoardFASF {
		global.nusic_board_track_position = audio_sound_get_track_position(global.music_current);
		print($"Track position stored ({global.nusic_board_track_position})");
	}
}

function fasf_play_music_from_position(music) {
	
	if (global.music_current != null && music != global.music_current && !music_is_same(music)) {
		music_play(music); // Play music
		
		audio_sound_gain(global.music_current, 0, 0); // Mute music
		audio_sound_set_track_position(global.music_current, global.nusic_board_track_position); // Load position
		print($"Music position loaded ({global.nusic_board_track_position})");
		audio_sound_gain(global.music_current, 1, 500); // Fade in volume
	}
}

function fasf_reset_track_position() {
	global.nusic_board_track_position = 0;
	print($"Music position reseted ({global.nusic_board_track_position})");
}

function fasf_last_turn_battle_cutscene() {
	if room == rBoardFASF {
		if global.board_turn > global.max_board_turns - 1 {	
			print("Last turn cutscene");
		}
	}
}


// Particles
function part_system_destroy_safe(particle_system) {
	if part_system_exists(particle_system)
	{
		part_system_destroy(particle_system);	
	}
}

function part_type_destroy_safe(particle_type) {
	if part_type_exists(particle_type)
	{
		part_type_destroy(particle_type);	
	}
}

function part_emitter_destroy_safe(particle_system, particle_emitter) {
	if part_emitter_exists(particle_system, particle_emitter)
	{
		part_emitter_destroy(particle_system, particle_emitter);	
	}
}
