global.languages = {};
global.language_codes = {};
global.language_list = [];

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
			array_push(global.language_list, languages[i]);
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
				//var text_key = "";
				//var found_keys = false;
				//var all_keys = [];
				
				//for (var j = 1; j <= string_length(text); j++) {
				//	var char = string_char_at(text, j);
					
				//	if (!found_keys && char != "{") {
				//		continue;
				//	}
					
				//	text_key += char;
					
				//	if (char == "{") {
				//		found_keys = true;
				//	} else if (char == "}") {
				//		array_push(all_keys, text_key);
				//		text_key = "";
				//		found_keys = false;
				//	}
				//}
				
				//for (var j = 0; j < array_length(all_keys); j++) {
				//	text = string_replace(text, all_keys[j], "@TEXT@");
				//}
				
				global.languages[$ languages[i]][$ text_id] = string_trim(text);
			}
		}
		
		file_text_close(file);
	//} catch (ex) {
	//	log_error(ex);
	//}
	
	if (!array_contains(global.language_list, global.language_game)) {
		popup("The language previously saved has been disabled temporarily until the translation has been fully completed.\nSetting the language to English!");
		global.language_game = "English";
	}
}

function language_get_text(id) {
	var text = global.languages[$ global.language_game][$ id];
	
	if (text == null) {
		return $"<No Text> [{global.language_game}]";
	}
	
	for (var i = 1; i < argument_count; i++) {
		var replacer = argument[i];
		var old_replace = replacer[0];
		var new_replace = replacer[1];
		text = string_replace(text, old_replace, string(new_replace));
		//text = string_replace(text, "@TEXT@", string(argument[i]));
	}
	
	return text;
}

function language_set_font(font) {
	draw_set_font(font);
}

function language_fonts_init() {
	//Menu
	global.fntTitle = language_font_add(60);
	global.fntTitleStart = language_font_add(30);
	global.fntTitleCreator = language_font_add(15);
	global.fntFilesFile = language_font_add(40);
	global.fntFilesData = language_font_add(20);
	global.fntFilesButtons = language_font_add(30);
	global.fntFilesInfo = language_font_add(38);
	global.fntTrophies = language_font_add(25);
	global.fntTrophiesDesc = language_font_add(15);
	
	//Boards
	global.fntPlayerInfo = language_font_add(20);
	global.fntPlayerName = language_font_add(20);
	global.fntDice = language_font_add(17);
	global.fntDialogue = language_font_add(20);
	global.fntControls = language_font_add(15);
	global.fntPopup = language_font_add(35);
	
	//Minigames
	global.fntMinigameOverviewTitle = language_font_add(40);
	
	//Trailer
	global.fntTrailer = language_font_add(45);
	
	//Test
	global.fntTest = language_font_add(20);
}

function language_font_add(size) {
	if (global.language_game == "Japanese") {
		size *= 0.85;
	}
	
	return font_add("font.ttf", size, false, false, 0, 40959);
}

function language_replace_text(language, text) {
	var text_ids = variable_struct_get_names(global.languages[$ language]);
	
	for (var i = 0; i < array_length(text_ids); i++) {
		var text_id = text_ids[i];
				
		if (global.languages[$ language][$ text_id] == text) {
			return language_get_text(text_id);
		}
	}
	
	return text;
}