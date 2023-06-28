global.languages = {};
global.language_codes = {};

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
			
			var languages_info = string_split(languages[i], " - ");
			global.language_codes[$ languages_info[0]] = languages_info[1];
			languages[i] = languages_info[0];
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
						array_push(all_keys, text_key);
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
		text = string_replace(text, "@TEXT@", string(argument[i]));
	}
	
	return text;
}

function language_set_font(font) {
	var font_assign = global.fonts[$ font_get_name(font) + global.language_codes[$ global.language_game]];
	draw_set_font((font_assign != null) ? font_assign : font);
}

function language_fonts_init() {
	global.fonts = {};
	var codes = variable_struct_get_names(global.language_codes);
	
	for (var i = 0; font_exists(i); i++) {
		var font_name = font_get_name(i);
		
		if (string_starts_with(font_name, "__")) {
			break;
		}
		
		if (string_starts_with(font_name, "fntMinigame1vs3")) {
			continue;
		}
		
		for (var j = 0; j < array_length(codes); j++) {
			var code = global.language_codes[$ codes[j]];
			var font = language_font_add(code, font_get_size(i));
			
			if (font == null) {
				continue;
			}
			
			global.fonts[$ font_name + code] = font;
		}
	}
}

function language_font_add(code, size) {
	switch (code) {
		case "KO":
			var font_name = "BinggraeSamanco.ttf";
			var font_size = size;
			break;
			
		case "ZH":
			var font_name = "DroidSansFallback.ttf";
			var font_size = size * 0.8;
			break;
			
		case "JA":
			var font_name = "Natsuzemi.ttf"; 
			var font_size = size * 0.8;
			break;
			
		case "RU":
			var font_name = "18VAG Rounded M Normal.ttf";
			var font_size = size * 0.8;
			break;
			
		default: return null;
	}
	
	var path = $"Fonts/{font_name}";
	
	if (!file_exists(path)) {
		return null;
	}
	
	return font_add(path, floor(font_size), false, false, 0, 40959);
}