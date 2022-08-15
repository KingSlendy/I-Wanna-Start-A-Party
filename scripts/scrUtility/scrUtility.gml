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

#region Alarms
function alarm_new(func) {
	return time_source_create(time_source_game, 1, time_source_units_frames, func);
}

function alarm_create(arg, arg2 = null) {
	if (is_method(arg)) {
		alarms[alarm_curr] = alarm_new(arg);
		alarms_funcs[alarm_curr] = arg;
		alarms_orig_funcs[alarm_curr] = arg;
		alarm_curr++;
	} else if (is_real(arg)) {
		alarms[arg] = alarm_new(arg2);
		alarms_funcs[arg] = arg2;
		alarms_orig_funcs[arg] = arg2;
	}
}

function alarms_init(num) {
	alarms = array_create(num, null);
	alarms_funcs = array_create(num, null);
	alarms_orig_funcs = array_create(num, null);
	alarm_curr = 0;
}

function alarm_call(num, seconds) {
	time_source_reconfigure(alarms[num], seconds, time_source_units_seconds, alarms_funcs[num]);
	time_source_start(alarms[num]);
}

function alarm_frames(num, frames) {
	time_source_reconfigure(alarms[num], frames, time_source_units_frames, alarms_funcs[num]);
	time_source_start(alarms[num]);
}

function alarm_next(num) {
	alarm_call(num, 1 / 50);
}

function alarm_instant(num) {
	alarms_funcs[num]();
}

function alarm_stop(num) {
	time_source_stop(alarms[num]);
}

function alarm_destroy(num) {
	if (time_source_exists(alarms[num])) {
		time_source_destroy(alarms[num]);
	}
}

function alarms_destroy() {
	try {
		for (var i = 0; i < array_length(alarms); i++) {
			if (alarms[i] == null) {
				continue;
			}
			
			alarm_destroy(i);
		}
	} catch (_) {}
}

function alarm_override(num, func) {
	alarm_destroy(num);
	var temp = alarms_orig_funcs[num];
	alarm_create(num, func);
	alarms_orig_funcs[num] = temp;
}

function alarm_inherited(num) {
	alarms_orig_funcs[num]();
}

function alarm_is_stopped(num) {
	return (time_source_get_state(alarms[num]) != time_source_state_active);
}
#endregion

function remap(value, from1, to1, from2, to2) {
	return (value - from1) / (to1 - from1) * (to2 - from2) + from2;
}

function get_frames(seconds) {
	var game_fps = game_get_speed(gamespeed_fps);
	var real_fps = (fps != 0) ? fps : game_fps;
	return game_fps * (game_fps / real_fps) * seconds;
}

function get_frames_static(seconds) {
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

function approach(val1, val2, amount) {
	if (val1 == val2) {
		return val1;
	}
	
	if (val1 < val2) {
		return min(val1 + amount, val2);
	} else {
		return max(val1 - amount, val2);
	}
}