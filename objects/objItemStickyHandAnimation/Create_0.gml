event_inherited();
player1 = focus_player_by_turn();
player2 = focus_player_by_turn(global.choice_selected + 1);
current_player = player2;

state = -1;
fade_alpha = 0;
ypos = 0;
scale = 1;

item_stole = null;

function start_hand() {
	turn_previous = global.player_turn;
	global.player_turn = global.choice_selected + 1;
	state = 0;
}

function end_hand() {
	change_items(item_stole, ItemChangeType.Gain).final_action = function() {
		with (objItemAnimation) {
			instance_destroy();
		}
	}
}

action = method(id, start_hand);

alarms_init(3);

alarm_create(function() {
	switch_camera_target(current_player.x, current_player.y).final_action = action;
});

alarm_create(function() {
	var player_info = player_info_by_turn();
	global.choice_selected = irandom(player_info.free_item_slot() - 1);
	item_stole = player_info.items[global.choice_selected];
	
	change_items(item_stole, ItemChangeType.Lose).final_action = function() {
		with (objItemAnimation) {
			alarm_instant(2);
		}
	}
});

alarm_create(function() {
	current_player = player1;
	global.player_turn = turn_previous;
	action = method(id, end_hand);
	alarm_frames(0, 1);
});

alarm_frames(0, 1);