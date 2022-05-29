#region Arrays
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

function array_sequence(start, count) {
	var array = [];
	
	for (var i = start; i < count; i++) {
		array_push(array, i);
	}
	
	return array;
}

function array_first(array, func) {
	for (var i = 0; i < array_length(array); i++) {
		if (func(array[i])) {
			return array[i];
		}
	}
	
	return noone;
}
#endregion

#region Strings
function string_interp(str) {
	for (var i = 0; i < argument_count - 1; i++) {
	    str = string_replace(str, "{" + string(i) + "}", string(argument[i + 1]));
	}

	return str;
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
#endregion

function remap(value, from1, to1, from2, to2) {
	return (value - from1) / (to1 - from1) * (to2 - from2) + from2;
}

function get_frames(seconds) {
	return game_get_speed(gamespeed_fps) * seconds;
}

function instance_activate_important() {
	instance_activate_object(objGameManager);
	instance_activate_object(objNetworkClient);
	instance_activate_object(objBoard);
	instance_activate_object(objPlayerInfo);
	instance_activate_object(objCameraSplit4);
	instance_activate_object(objPlayerBase);
	instance_activate_object(objPopup);
}
