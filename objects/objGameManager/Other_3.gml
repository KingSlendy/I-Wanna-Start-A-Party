if (room == rInit) {
	exit;
}

if (global.game_started) {
	save_file();
}

save_config();