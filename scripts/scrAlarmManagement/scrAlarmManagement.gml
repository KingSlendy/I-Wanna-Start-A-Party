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

function alarm_remain(num) {
	var remaining = time_source_get_time_remaining(alarms[num]);
	
	if (time_source_get_units(alarms[num]) == time_source_units_seconds) {
		remaining = get_frames(remaining);
	}

	return remaining;
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