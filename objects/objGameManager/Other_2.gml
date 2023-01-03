sprite_prefetch_multi([
	sprBkgTitle,
	sprMinigamesFangames,
	sprSkinsFangames,
	sprTrophyImages,
	sprMinigameOverview_Pictures
]);

audio_group_load(audiogroup_BGM);
audio_group_load(audiogroup_SFX);

var files = [
	"options.ini",
	"controllerblacklist.csv",
	"controllertypes.csv",
	"sdl2.txt",
	"execute_shell_simple_ext_x64.dll",
	"audiogroup1.dat",
	"audiogroup2.dat",
	"data.win",
	"I Wanna Start A Party.exe"
];

var file = file_text_open_write("update.bat");
file_text_write_string(file, "ping 127.0.0.1 -n 6 > nul");
file_text_writeln(file);

for (var i = 0; i < array_length(files); i++) {
	file_text_write_string(file, string_interp("xcopy \"{0}{2}\" \"{1}{3}\" /Y /F", game_save_id, program_directory, files[i], files[i]));
	file_text_writeln(file);
	file_text_write_string(file, string_interp("del \"{0}{1}\"", game_save_id, files[i]));
	file_text_writeln(file);
}

file_text_write_string(file, string_interp("\"{0}{1}\"", program_directory, files[array_length(files) - 1]));
file_text_writeln(file);
file_text_write_string(file, "exit 0");
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

board_init();
minigame_init();
minigame_info_reset();
trial_init();
trial_info_reset();
skin_init();
reaction_init();