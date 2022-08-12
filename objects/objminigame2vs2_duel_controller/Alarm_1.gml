event_inherited();
show_popup("READY...",,,,,, 0.5);
audio_play_sound(sndMinigameReady, 0, false);
player_can_shoot = array_create(global.player_max, true);
next_seed_inline();
var time = irandom_range(3, 6);
cpu_shot_delay = [0];

repeat (global.player_max - 1) {
	array_push(cpu_shot_delay, ceil(get_frames(random_range(time - 0.05, time + 0.6))));
}

alarm[4] = get_frames(time);