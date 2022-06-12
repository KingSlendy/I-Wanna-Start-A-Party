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