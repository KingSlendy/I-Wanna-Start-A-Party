sprite_prefetch(sprBkgTitle);
sprite_prefetch(sprMinigamesFangames);
sprite_prefetch(sprSkinsFangames);
sprite_prefetch(sprMinigameOverview_Pictures);
audio_group_load(audiogroup_BGM);
audio_group_load(audiogroup_SFX);

var files = [
	"audiogroup1.dat",
	"audiogroup2.dat",
	"options.ini",
	"execute_shell_simple_ext.dll",
	"data.win",
	"I Wanna Start A Party.exe"
];

var file = file_text_open_write("update.bat");
file_text_write_string(file, "ping 127.0.0.1 -n 6 > nul");
file_text_writeln(file);

for (var i = 0; i < array_length(files); i++) {
	file_text_write_string(file, string_interp("xcopy \"{0}{2}\" \"{1}{3}\" /Y", game_save_id, program_directory, files[i], files[i]));
	file_text_writeln(file);
	file_text_write_string(file, string_interp("del \"{0}{1}\"", game_save_id, files[i]));
	file_text_writeln(file);
}

file_text_write_string(file, string_interp("\"{0}{1}\"", program_directory, files[array_length(files) - 1]));
file_text_writeln(file);
file_text_write_string(file, "exit");
file_text_close(file);

var file_check = function(file) {
	if (file_exists(game_save_id + file)) {
		file_delete(game_save_id + file);
	}
}

for (var i = 0; i < array_length(files); i++) {
	file_check(files[i]);
}

for (var i = 0; i < 3; i++) {
	save_variables();
	global.file_selected = i;
	
	if (!load_file()) {
		save_file();
	}
}

global.file_selected = -1;

config_variables();

if (!load_config()) {
	save_config();
}

apply_config();

skin_init();
minigame_init();
minigame_info_reset();
global.part_system = part_system_create();
room_goto_next();