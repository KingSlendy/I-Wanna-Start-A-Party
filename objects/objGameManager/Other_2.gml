sprite_prefetch_multi([
	sprBkgTitle,
	sprMinigamesFangames,
	sprSkinsFangames,
	sprTrophyImages,
	sprMinigameOverview_Pictures
]);

audio_group_load(audiogroup_BGM);
audio_group_load(audiogroup_SFX);
//music_loop_init();

var files = [
	"options.ini",
	"controllerblacklist.csv",
	"controllertypes.csv",
	"sdl2.txt",
	"font.ttf",
	"languages.tsv",
	"execute_shell_simple_ext_x64.dll",
	"window_taskbar_x64.dll",
	"audiogroup1.dat",
	"audiogroup2.dat",
	"data.win",
	"I Wanna Start A Party.exe"
];

var file = file_text_open_write("update.bat");
file_text_write_string(file, "CHCP 65001");
file_text_writeln(file);
file_text_write_string(file, "ping 127.0.0.1 -n 6 > nul");
file_text_writeln(file);

for (var i = 0; i < array_length(files); i++) {
	file_text_write_string(file, string("robocopy \"{0}\" \"{1}\" \"{2}\" /mov", string_copy(game_save_id, 1, string_length(game_save_id) - 1), string_copy(program_directory, 1, string_length(program_directory) - 1), files[i]));
	file_text_writeln(file);
	//file_text_write_string(file, string("del \"{0}{1}\"", game_save_id, files[i]));
	//file_text_writeln(file);
}

file_text_write_string(file, string("\"{0}{1}\"", program_directory, files[array_length(files) - 1]));
file_text_writeln(file);
file_text_write_string(file, "exit 0");
file_text_close(file);

var file_check = function(file) {
	if (file_exists(game_save_id + file)) {
		execute_shell_simple(game_save_id + "update.bat",,, 0);
		game_end();
		return false;
	}
	
	return true;
}

for (var i = 0; i < array_length(files); i++) {
	if (!file_check(files[i])) {
		exit;
	}
}

if (string_char_at(VERSION, string_length(VERSION)) != "t" && file_exists("test")) {
	file_delete("test");
}

for (var i = 0; i < 3; i++) {
	save_variables();
	global.file_selected = i;
	
	if (!load_file()) {
		save_file();
	}
}

global.file_selected = -1;

languages_init();
language_fonts_init();
config_variables();

if (!load_config()) {
	save_config();
}

apply_config();

board_init();
minigame_init();
minigame_info_reset();
items_init();
results_init();
trial_init();
trial_info_reset();
skin_init();
reaction_init();
trophies_init();

controls_text = new Text(global.fntControls);