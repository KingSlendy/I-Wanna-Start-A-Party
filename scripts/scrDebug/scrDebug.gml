global.debug_mode = true;

#macro print show_debug_message
#macro popup show_message

function log_error(exception) {
	var file = file_text_open_append("Error_Log.txt");
	file_text_write_string(file, "---------------------");
	file_text_writeln(file);
	file_text_write_string(file, exception);
	file_text_close(file);
}