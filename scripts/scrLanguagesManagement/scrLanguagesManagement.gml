global.languages = {};

function languages_init() {
	//try {
		var file = file_text_open_read("languages.tsv");
		var languages = string_split(file_text_read_string(file), "\t");
		var excluded = [];
		
		for (var i = array_length(languages) - 1; i >= 0; i--) {
			if (string_starts_with(languages[i], "#")) {
				array_push(excluded, i);
				continue;
			}
			
			global.languages[$ languages[i]] = {};
		}
		
		file_text_readln(file);
	
		while (!file_text_eof(file)) {
			var line = file_text_read_string(file);
			file_text_readln(file);
			
			if (string_starts_with(line, "#")) {
				continue;
			}
			
			var texts = string_split(line, "\t");
			var text_id = texts[0];
			
			for (var i = 1; i < array_length(texts); i++) {
				if (array_contains(excluded, i)) {
					continue;
				}
				
				var text = texts[i];
				text = string_replace_all(text, "\\n", "\n");
				var text_key = "";
				var found_keys = false;
				var all_keys = [];
				
				for (var j = 1; j <= string_length(text); j++) {
					var char = string_char_at(text, j);
					
					if (!found_keys && char != "{") {
						continue;
					}
					
					text_key += char;
					
					if (char == "{") {
						found_keys = true;
					} else if (char == "}") {
						if (!array_contains(all_keys, text_key)) {
							array_push(all_keys, text_key);
						}
						
						text_key = "";
						found_keys = false;
					}
				}
				
				for (var j = 0; j < array_length(all_keys); j++) {
					text = string_replace(text, all_keys[j], "@TEXT@");
				}
				
				global.languages[$ languages[i]][$ text_id] = text;
			}
		}
		
		file_text_close(file);
	//} catch (ex) {
	//	log_error(ex);
	//}
}

function language_get_text(id) {
	var text = global.languages[$ global.language_game][$ id];
	
	if (text == null) {
		return $"<No Text> [{global.language_game}]";
	}
	
	for (var i = 1; i < argument_count; i++) {
		text = string_replace(text, "@TEXT@", argument[i]);
	}
	return text;
}