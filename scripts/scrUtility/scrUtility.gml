function array_count(array, check) {
	var count = 0;

	for (var i = 0; i < array_length(array); i++) {
	    if (array[i] == check) {
	        count++;
	    }
	}

	return count;
}

function array_contains(array, check) {
	return (array_index(array, check) != -1);
}

function array_index(array, check) {
	for (var i = 0; i < array_length(array); i++) {
	    if (array[i] == check || (is_array(check) && array_equals(array[i], check))) {
	        return i;
	    }
	}

	return -1;
}

function array_shuffle(array) {
	for (var i = 0; i < array_length(array); i++) {
		var rnd = irandom(array_length(array) - 1);
		var temp = array[rnd];
		array[@ rnd] = array[i];
		array[@ i] = temp;
	}
}

function string_split(str, substr = "") {
	var splitted = [];
	var sub_count = string_count(substr, str);
	var now_index = 1;
	var count_index = 1;
	var length = string_length(str);
	var sub_length = string_length(substr);

	if (sub_count == 0) {
	    return str;
	}

	if (substr == "") {
	    for (var i = 0; i < length; i++) {
	        splitted[i] = string_char_at(str, i + 1);
	    }
    
	    return str;
	}

	for (var i = 0; i <= sub_count; i++) {
	    if (i < sub_count) {
	        var rem_index = now_index;    
        
	        while (string_copy(str, now_index, sub_length) != substr) {
	            now_index++;
	            count_index++;
	        }
        
	        splitted[i] = string_copy(str, rem_index, count_index - 1);
	        now_index += sub_length;
	        count_index = 1;
	    } else {
	        splitted[i] = string_copy(str, now_index, length - now_index + 1);
	    }
	}

	return splitted;
}

function array_first(array, func) {
	for (var i = 0; i < array_length(array); i++) {
		if (func(array[i])) {
			return array[i];
		}
	}
	
	return noone;
}

function get_frames(seconds) {
	return game_get_speed(gamespeed_fps) * seconds;
}