sprites = [sprite_create_from_surface(application_surface, 0, 0, 800, 608, false, false, 0, 0), noone];
wave = 0;
final_action = board_start;

global.board_light ^= true;

with (objBoard) {
	event_perform(ev_step, ev_step_begin);
}

with (objShine) {
	event_perform(ev_step, ev_step_begin);
}

music_fade();
audio_play_sound(sndBoardHyruleWorldTransition, 0, false);

alarms_init(1);

alarm_create(function() {
	sprites[1] = sprite_create_from_surface(application_surface, 0, 0, 800, 608, false, false, 0, 0);
});

alarm_frames(0, 1);