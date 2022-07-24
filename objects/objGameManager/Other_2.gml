save_variables();

for (var i = 0; i < 3; i++) {
	global.file_selected = i;
	
	if (!load_file()) {
		save_file();
	}
}

global.file_selected = -1;

skin_init();
minigame_init();
minigame_info_reset();
sprite_prefetch(sprBkgTitle);
sprite_prefetch(sprMinigamesFangames);
sprite_prefetch(sprSkinsFangames);
sprite_prefetch(sprMinigameOverview_Pictures);
audio_group_load(audiogroup_BGM);
audio_group_load(audiogroup_SFX);
global.part_system = part_system_create();
room_goto_next();
//execute_shell_simple("update.bat", program_directory);