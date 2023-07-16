var status = async_load[? "status"];

if (status < 0) {
	occurred_error();
	exit;
}

if (async_load[? "id"] == tag) {
	var result = async_load[? "result"];

	if (result == null) {
		exit;
	}

	var title_open = "<title>";
	var title_close = "</title>";
	var versions = title_open;
	var span_pos = string_pos(versions, result) + string_length(title_open);

	while (string_count(title_close, versions) == 0) {
		versions += string_char_at(result, ++span_pos);
	}

	versions = string_split(versions, " ", true);
	
	array_foreach(versions, function(x) {
		if (string_count(".", x) > 0) {
			version = x;
			return;
		}
	});
	
	if (version != VERSION) {
		var os_name = "";
		
		//if (os_type == os_linux) {
		//	os_name = "-Linux"
		//}
		
		//switch (os_type) {
		//	case os_windows: os_name = "-Windows"; break;
		//	case os_linux: os_name = "-Linux"; break;
		//}
		
		file = http_get_file($"https://github.com/KingSlendy/{repo}/releases/download/{version}/I.Wanna.Start.A.Party{os_name}.zip", game_save_id + "\\Version.zip");
	} else {
		alarm_instant(0);
		exit;
	}
} else {
	if (!downloading) {
		text = language_get_text("VERSION_DOWNLOADING");
		downloading = true;
	}

	var prev_size = size;
	var prev_sent = sent;
	size = async_load[? "contentLength"];
	sent = async_load[? "sizeDownloaded"];
	
	if (size == null || sent == null) {
		size = prev_size;
		sent = prev_sent;
	}
	
	alarm_call(2, 15);

	if (status == 0) {
		var zip = zip_unzip("Version.zip", game_save_id);
	
		if (zip <= 0) {
			occurred_error();
			exit;
		}
	
		file_delete("Version.zip");
		execute_shell_simple(game_save_id + "update.bat",,, 0);
		text = language_get_text("VERSION_FINISHED");
		downloading = false;
		alarm_call(1, 2.5);
		alarm_stop(2);
	}
}