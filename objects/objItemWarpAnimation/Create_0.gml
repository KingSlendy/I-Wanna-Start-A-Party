depth = -10000;
event_inherited();
player1 = focus_player_by_turn();
player1_pos = {x: player1.x, y: player1.y};

next_seed_inline();
var chosed_player;

do {
	chosed_player = irandom_range(1, global.player_max);
} until (chosed_player != global.player_turn);

player2 = focus_player_by_turn(chosed_player);
player2_pos = {x: player2.x, y: player2.y};
scale = 0;
state = 0;

alarms_init(2);

alarm_create(function() {
	player2.x = player1_pos.x;
	player2.y = player1_pos.y;
	player1.x = player2_pos.x;
	player1.y = player2_pos.y;

	alarm_call(1, 1);
});

alarm_create(function() {
	state = 1;
});