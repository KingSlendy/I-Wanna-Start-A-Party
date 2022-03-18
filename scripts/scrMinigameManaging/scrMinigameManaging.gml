function Minigame(title = "Generic Minigame", instructions = "Generic Instructions", preview = sprBox, scene = rTemplate) constructor {
	self.title = title;
	self.instructions = instructions;
	self.preview = preview;
	self.scene = scene;
}

global.minigames = {};
var m = global.minigames;
m[$ "4vs"] = [
	new Minigame()
];

m[$ "1vs3"] = [
	new Minigame()
];

m[$ "2vs2"] = [
	new Minigame("A-Maze-Ing",,, rMinigame2vs2_Maze)
];

function minigame_info_reset() {
	global.minigame_info = {
		reference: global.minigames[$ "2vs2"][0],
		type: "",
		player_colors: [],
		is_practice: false,
		player_scores: [],
		players_won: [],
		color_won: c_white,
		is_finished: false,
		
		player_positions: [],
		previous_board: null
	}
	
	repeat (global.player_max) {
		array_push(global.minigame_info.player_scores, {
			timer: 0,
			points: 0
		});
	}
}

function minigame_2vs2_start(info) {
	player_2vs2_positioning(info);
	camera_2vs2_split4(camera_start(objCameraSplit4), info);
	player_2vs2_teammate();
}

function player_4vs_positioning() {
}

function player_2vs2_positioning(info) {
	var index = 0;
	
	with (objPlayerBase) {
		var player_info = player_info_by_id(network_id);
	
		if (player_info.space == info.player_colors[0]) {
			with (objPlayerReference) {
				if (reference == index) {
					other.x = x + 17;
					other.y = y + 23;
					index++;
				}
			}
		}
	}

	with (objPlayerBase) {
		var player_info = player_info_by_id(network_id);
	
		if (player_info.space == info.player_colors[1]) {
			with (objPlayerReference) {
				if (reference == index) {
					other.x = x + 17;
					other.y = y + 23;
					index++;
				}
			}
		}
	}
}

function player_2vs2_teammate() {
	with (objPlayerBase) {
		for (var i = 1; i <= global.player_max; i++) {
			var player = focus_player_by_turn(i);
			
			if (player.id == id) {
				continue;
			}
			
			if (player_info_by_id(player.network_id).space == player_info_by_id(network_id).space) {
				teammate = player.id;
				break;
			}
		}
	}
}

function minigame_2vs2_finish() {
	with (objMinigameController) {
		if (!info.is_finished) {
			objPlayerBase.frozen = true;
			show_popup("FINISH");
			
			//buffer_seek_begin();
			//buffer_write_action(ClientTCP.MinigameScore);
			//buffer_write_data(buffer_u8, global.player_id);
			//buffer_write_data(buffer_u64, info.player_scores[global.player_id]);
			//network_send_tcp_packet();
			
			if (signal_finished) {
				//buffer_seek_begin();
				//buffer_write_action(ClientTCP.Minigame2vs2Finish);
				//buffer_write_data(buffer_u64, color);
				//network_send_tcp_packet();
				signal_finished = false;
			}
			
			info.is_finished = true;
		}
		
		if (global.player_id == 1 && array_count(info.player_scores, 0) == 0) {
			minigame_2vs2_winner(info);
			alarm[2] = get_frames(2);
		}
	}
}

function minigame_2vs2_winner(info) {
	var scores = [0, 0];
	
	for (var i = 0; i < global.player_max; i++) {
		var score = player_scores[i];
		var color = player_info_by_id(i + 1).space;
		scores[(color == info.player_colors[0])] += score.timer + score.points;
	}
	
	if (scores[0] == scores[1]) {
		//Both teams have tied
		info.color_won = c_white;
	} else {
		//Determines which team color wins
		info.color_won = info.player_colors[(scores[1] > scores[0])];
	}
	
	for (var i = 1; i <= global.player_max; i++) {
		var color = player_info_by_id(i).space;
			
		if (info.color_won == c_white || color == info.color_won) {
			array_push(info.players_won, i);
			break;
		}
	}
}