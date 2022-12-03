depth = -10000;
event_inherited();
player1 = focus_player_by_turn();
player1_pos = {x: player1.x, y: player1.y};
player2 = focus_player_by_turn(global.choice_selected + 1);
player2_pos = {x: player2.x, y: player2.y};

scale = 0;
state = 0;
ang = 0;

alarms_init(2);

alarm_create(function() {
	player2.x = player1_pos.x;
	player2.y = player1_pos.y;
	player1.x = player2_pos.x;
	player1.y = player2_pos.y;
	audio_play_sound(sndItemSuperWarpAnimation, 0, false);
	alarm_call(1, 1);
});

alarm_create(function() {
	state = 1;
});