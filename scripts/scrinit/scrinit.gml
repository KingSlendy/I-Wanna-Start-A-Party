global.fullscreen_delay = 0;

function move_and_execute_game() {
	if (file_exists("Version.zip")) {
		file_delete("Version.zip");
	}
	
	execute_shell_simple(game_save_id + "update.bat",,, 0);
}