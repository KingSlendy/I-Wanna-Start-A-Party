depth = -10010;
state = 0;
alpha = 0;
zoom = false;
player_colors = [];
minigame_total = 5;
minigame_list = [
	global.minigames[$ "2vs2"][0],
	global.minigames[$ "2vs2"][0],
	global.minigames[$ "2vs2"][0],
	global.minigames[$ "2vs2"][0],
	global.minigames[$ "2vs2"][0],
];

minigames_alpha = 0;
minigames_width = 300;
minigames_height = 40;
minigames_timer = 3;
minigames_chosen = irandom(minigame_total - 1);

if (is_local_turn()) {
	global.choice_selected = irandom(minigame_total - 1);
}

info = global.minigame_info;
objBoard.alarm[11] = 0;

function choosed_minigame() {
	info.reference = minigame_list[global.choice_selected];
	alarm[3] = get_frames(1);
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.ChooseMinigameChoosed);
		network_send_tcp_packet();
	}
}

function send_to_minigame() {
	with (objPlayerBase) {
		change_to_object(objPlayerBase);
	}
	
	info.previous_board = room;
	
	for (var i = 1; i <= global.player_max; i++) {
		var player = focus_player_by_id(i);
		array_push(info.player_positions, {x: player.x, y: player.y});
	}
	
	with (objSpaces) {
		array_push(other.info.space_indexes, {x: self.x, y: self.y, index: image_index});
	}
	
	with (objShine) {
		other.info.shine_position.x = x;
		other.info.shine_position.y = y;
	}
	
	room_goto(rMinigameOverview);
}