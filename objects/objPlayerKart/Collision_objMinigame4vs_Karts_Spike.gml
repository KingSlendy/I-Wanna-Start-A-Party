audio_play_sound(sndDeath, 0, false);
x = check_x;
y = check_y;
direction = check_dir;
audio_stop_sound(engine_sound);
audio_stop_sound(drift_sound);

if (drift) {
    drift = 0;
    audio_stop_sound(drift_sound);
    drift_skid = 0;
    min_tex = 2;
    max_tex = 4;
    draw_tex = clamp(draw_tex, min_tex, max_tex);
}

speed = 0;

if (agent != null) {
	agent.path_position = agent.check_position;
	agent.position = agent.path_position;
}