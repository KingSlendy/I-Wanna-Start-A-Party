event_inherited();
player1 = focus_player_by_id_turn();
player2 = focus_player_by_id_turn(global.choice_selected + 1);
current_player = player2;

state = -1;
alpha = 0;
ypos = 0;
scale = 1;

alarm[0] = 1;

function start_ice_freeze() {
	turn_previous = global.player_turn;
	global.player_turn = global.choice_selected + 1;
	state = 0;
}

function end_ice_freeze() {
	instance_destroy();
}

action = method(id, start_ice_freeze);