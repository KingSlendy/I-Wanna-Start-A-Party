if (async_load[? "id"] != file) {
	exit;
}

var status = async_load[? "status"];

if (status < 0) {
	error_occurred();
	exit;
}

if (!downloading) {
	text = "Downloading version...";
	downloading = true;
}

size = async_load[? "contentLength"];
sent = async_load[? "sizeDownloaded"];
alarm_call(2, 15);

if (status == 0) {
	var zip = zip_unzip("Version.zip", game_save_id);
	
	if (zip <= 0) {
		error_occurred();
		exit;
	}
	
	file_delete("Version.zip");
	execute_shell_simple(game_save_id + "update.bat",,, 0);
	text = "Finished download!";
	downloading = false;
	alarm_call(1, 3);
	alarm_stop(2);
}