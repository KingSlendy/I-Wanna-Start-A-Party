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

function array_swap(array, index1, index2) {
	var temp = array[index1];
	array[@ index1] = array[index2];
	array[@ index2] = temp;
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
function string_contains(str, substr) {
	return (string_count(substr, str) > 0);
}
#endregion

function remap(value, from1, to1, from2, to2) {
	return (value - from1) / (to1 - from1) * (to2 - from2) + from2;
}

function chance(percent) {
	return (percent > random(1));
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

function instance_place_any(x, y, obj, func, notme = true) {
	var list = ds_list_create();
	var count = instance_place_list(x, y, obj, list, false);
	var result = noone;
	
	for (var i = 0; i < count; i++) {
		var o = list[| i];
		
		if (notme && o.id == id) {
			continue;
		}
		
		if (func(o)) {
			result = o;
			break;
		}
	}
	
	ds_list_destroy(list);
	return result;
}

function instance_nearest_any(x, y, obj, func) {
	var result = null;
	
	while (true) {
		if (!instance_exists(obj)) {
			break;
		}
		
		var near = instance_nearest(x, y, obj);
		
		if (func(near)) {
			result = near;
			break;
		}
		
		instance_deactivate_object(near);
	}
	
	instance_activate_object(obj);
	return result;
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

#region Particles
function part_system_destroy_safe(particle_system) {
	if part_system_exists(particle_system)
	{
		part_system_destroy(particle_system);	
	}
}

function part_type_destroy_safe(particle_type) {
	if part_type_exists(particle_type)
	{
		part_type_destroy(particle_type);	
	}
}

function part_emitter_destroy_safe(particle_system, particle_emitter) {
	if part_emitter_exists(particle_system, particle_emitter)
	{
		part_emitter_destroy(particle_system, particle_emitter);	
	}
}
#endregion

function path_point_nearest(path, x, y, precision = 0.1) {
	var priority = ds_priority_create();

	for(var i = 0; i <= 1; i += precision / path_get_length(path)){
	     var xx = path_get_x(path, i);
	     var yy = path_get_y(path, i);
	     ds_priority_add(priority, {path_x: xx, path_y: yy}, point_distance(xx, yy, x, y));
	}

	var solution = ds_priority_find_min(priority);
	ds_priority_destroy(priority);
	return solution;
}