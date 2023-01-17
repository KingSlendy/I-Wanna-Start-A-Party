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

function array_swap(array, index1, index2) {
	var temp = array[index1];
	array[@ index1] = array[index2];
	array[@ index2] = temp;
}

function array_shuffle(array) {
	for (var i = 0; i < array_length(array); i++) {
		var rnd = irandom(array_length(array) - 1);
		array_swap(array, rnd, i);
	}
}

function array_sequence(start, count) {
	var array = [];
	
	for (var i = start; i < count; i++) {
		array_push(array, i);
	}
	
	return array;
}

function array_search(array, value, left = 0, right = array_length(array) - 1) {
	if (right < left) {
		return false;
	}
	
	var middle = floor((left + right) / 2);
	var check = array[middle];
	
	if (check == value) {
		return true;
	}
	
	if (check < value) {
		return array_search(array, value, middle + 1, right);
	}
	
	if (check > value) {
		return array_search(array, value, left, middle - 1);
	}
}
#endregion

#region Strings
function string_interp(str) {
	for (var i = 0; i < argument_count - 1; i++) {
	    str = string_replace(str, "{" + string(i) + "}", string(argument[i + 1]));
	}

	return str;
}

//function string_split(str, substr = "") {
//	var splitted = [];
//	var sub_count = string_count(substr, str);
//	var now_index = 1;
//	var count_index = 1;
//	var length = string_length(str);
//	var sub_length = string_length(substr);

//	if (sub_count == 0) {
//	    return str;
//	}

//	if (substr == "") {
//	    for (var i = 0; i < length; i++) {
//	        splitted[i] = string_char_at(str, i + 1);
//	    }
    
//	    return str;
//	}

//	for (var i = 0; i <= sub_count; i++) {
//	    if (i < sub_count) {
//	        var rem_index = now_index;    
        
//	        while (string_copy(str, now_index, sub_length) != substr) {
//	            now_index++;
//	            count_index++;
//	        }
        
//	        splitted[i] = string_copy(str, rem_index, count_index - 1);
//	        now_index += sub_length;
//	        count_index = 1;
//	    } else {
//	        splitted[i] = string_copy(str, now_index, length - now_index + 1);
//	    }
//	}

//	return splitted;
//}

function string_trim(str, char = " ", side = "both") {
	var new_string = str;
	
	if (string_count(char, str) == string_length(new_string)) {
		return "";
	}
	
	if (side == "left" || side == "both") {
		var start = 0;
		
		for (var i = 1; i <= string_length(new_string); i++) {
			if (string_char_at(new_string, i) != char) {
				start = i - 1;
				break;
			}
		}
		
		if (start != 0) {
			new_string = string_delete(new_string, 1, start);
		}
	}
	
	if (side == "right" || side == "both") {
		var finish = 0;
		
		for(var i = string_length(new_string); i > 0; i--) {
			if (string_char_at(new_string, i) != char) {
				finish = i + 1;
				break;
			}
		}
		
		if (finish != 0) {
			new_string = string_delete(new_string, finish, string_length(new_string));
		}
	}
	
	return new_string;
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

function alarm_pause(num) {
	time_source_pause(alarms[num]);
}

function alarm_resume(num) {
	time_source_resume(alarms[num]);
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
			
			alarm_stop(i);
		}
		
		with (objGameManager) {
			array_push(alarms_collected, other.alarms);
			alarm[0] = 1;
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
	//var game_fps = game_get_speed(gamespeed_fps);
	//var real_fps = (fps != 0) ? fps : game_fps;
	//return game_fps * (game_fps / real_fps) * seconds;
	return get_frames_static(seconds);
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

function wave_transition(sprites, fraction) {
	var width = 800;
	var height = 608;
	var strip_height = 8;
	var amplitude = 0.08;
	var cycles = 9;
	var phase_speed = 0.8;
	var strip_count = ceil(height / strip_height);
	
	for (var sn = 0; sn < 2; sn++) {
	    var tex = sprite_get_texture(sprites[sn], 0);
	    var tw = texture_get_width(tex);
	    var th = texture_get_height(tex);

	    draw_primitive_begin_texture(pr_trianglestrip, tex);
		
	    for (var i = 0; i <= strip_count; i += 1) {
	        var left = amplitude * width * cos((i / strip_count - fraction * phase_speed) * pi * cycles) * sin(fraction * pi);
	        var top = i * strip_height;
	        var tt = top / height * th;
			var alpha = clamp((1 + i / strip_count - fraction * 2), 0, 1);
	        
			if (sn == 1) {
				alpha = 1 - alpha;
			}
        
	        draw_vertex_texture_color(left, top, 0, tt, c_white, alpha);
	        draw_vertex_texture_color(left + width, top, tw, tt, c_white, alpha);
	    }
		
		draw_primitive_end();
	}
}