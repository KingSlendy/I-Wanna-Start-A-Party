global.choice_selected = (global.choice_selected + options_dir + options_total) % options_total;
audio_play_sound(sndCursorSelect, 0, false);
next_seed_inline();

if (options_dir == 1) {
	options_timer += 0.10;
	
	if (options_timer > 6 && irandom(10) == 0) {
		options_timer = 5;
		options_dir = -1;
		
		with (objTheGuyHead) {
			snd = audio_play_sound(sndTheGuyEscape, 0, false);
		}
		
		alarm[3] = irandom_range(get_frames(0.75), get_frames(1.5));
		exit;
	}
} else {
	if (irandom(1) == 0 && global.choice_selected == options_chosen) {
		alarm[6] = get_frames(1);
		exit;
	}
}

alarm[3] = options_timer;
