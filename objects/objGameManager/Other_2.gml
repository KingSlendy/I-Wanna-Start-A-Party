for (var i = 0; i < 3; i++) {
	global.file_selected = i;
	
	if (!load_file()) {
		save_file();
	}
}

global.file_selected = -1;

minigame_init();
audio_group_load(audiogroup_BGM);
audio_group_load(audiogroup_SFX);
room_goto_next();