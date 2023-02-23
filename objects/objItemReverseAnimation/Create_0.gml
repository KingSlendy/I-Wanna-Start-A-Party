event_inherited();
player1 = focus_player_by_turn();
player2 = focus_player_by_turn(global.choice_selected + 1);
current_player = player2;

state = -1;
fade_alpha = 0;
ypos = 0;
scale = 1;

function start_reverse() {
	turn_previous = global.player_turn;
	global.player_turn = global.choice_selected + 1;
	state = 0;
}

function end_reverse() {
	instance_destroy();
}

action = method(id, start_reverse);

alarms_init(3);

alarm_create(function() {
	switch_camera_target(current_player.x, current_player.y).final_action = action;
});

alarm_create(function() {
	player_info_by_turn().item_effect = type;
	var color_effect = make_color_rgb(92, 248, 97);
	create_effect(sprItemEffectReverse, color_effect);
	audio_play_sound(sndItemReverseAnimation, 0, false);
	alarm_call(2, 1);
});

alarm_create(function() {
	current_player = player1;
	global.player_turn = turn_previous;
	action = method(id, end_reverse);
	alarm_frames(0, 1);
});

alarm_frames(0, 1);