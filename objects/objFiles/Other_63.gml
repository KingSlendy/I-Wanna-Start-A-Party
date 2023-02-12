lobby_window = false;

if (!async_load[? "status"]) {
	exit;
}

var text = async_load[? "result"];

switch (menu_type) {
	case 1:
		file_name = "";

		for (var i = 1; i <= string_length(text); i++) {
			var char = string_char_at(text, i);
								
			if (char == " " || char == "." || char == ":" || char == "!" || char == "?") {
				file_name += char;
			}
								
			file_name += string_letters(char) + string_digits(char);
		}
							
		file_name = string_trim(file_name);
						
		if (string_length(file_name) == 0) {
			file_name = DEFAULT_PLAYER;
		}
						
		if (file_limit != -1) {
			file_name = string_copy(file_name, 1, file_limit);
		}
		break;
		
	case 3:
		var select = menu_selected[menu_type];
		online_texts[select] = "";
	
		for (var i = 1; i <= string_length(text); i++) {
			var char = string_char_at(text, i);
								
			if (select == 1) {
				online_texts[select] += string_digits(char);
			} else {
				online_texts[select] += char;
			}
		}
							
		online_texts[select] = string_trim(online_texts[select]);
						
		if (string_length(online_texts[select]) == 0) {
			switch (select) {
				case 0: online_texts[select] = DEFAULT_IP; break;
				case 1: online_texts[select] = DEFAULT_PORT; break;
			}
		}
						
		if (online_limits[select] != -1) {
			online_texts[select] = string_copy(online_texts[select], 1, online_limits[select]);
		}
		break;
		
	case 4:
		var select = menu_selected[menu_type];
		lobby_texts[select] = "";
		
		for (var i = 1; i <= string_length(text); i++) {
			var char = string_char_at(text, i);
								
			if (select == 0 && (char == " " || char == "!" || char == "?")) {
				lobby_texts[select] += char;
			}
								
			lobby_texts[select] += string_letters(char) + string_digits(char);
		}
							
		lobby_texts[select] = string_trim(lobby_texts[select]);
							
		if (select == 0 && string_length(lobby_texts[select]) == 0) {
			lobby_texts[select] = "Room";
		}
						
		if (lobby_limits[select] != -1) {
			lobby_texts[select] = string_copy(lobby_texts[select], 1, lobby_limits[select]);
		}
		break;
}