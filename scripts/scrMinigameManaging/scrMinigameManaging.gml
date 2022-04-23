function Minigame(title = "Generic Minigame", instructions = ["Generic Instructions"], preview = sprBox, scene = rTemplate) constructor {
	self.title = title;
	self.instructions = instructions;
	self.preview = preview;
	self.scene = scene;
}

global.minigames = {};
var m = global.minigames;
m[$ "4vs"] = [
	new Minigame("Follow The Lead", ["Just win"],, rMinigame4vs_Lead)
];

m[$ "1vs3"] = [
	new Minigame()
];

m[$ "2vs2"] = [
	new Minigame("A-Maze-Ing", ["Just win"],, rMinigame2vs2_Maze)
];

function minigame_info_reset() {
	global.minigame_info = {
		reference: global.minigames[$ "2vs2"][0],
		type: "",
		player_colors: [],
		is_practice: false,
		is_finished: false,
		
		previous_board: null,
		player_positions: [],
		space_indexes: [],
		shine_position: {x: 0, y: 0}
	}
	
	minigame_info_score_reset();
}

function minigame_info_score_reset() {
	var info = global.minigame_info;
	info.player_scores = [];
	info.players_won = [];
	info.color_won = c_white;
	info.is_finished = false;
	
	repeat (global.player_max) {
		array_push(info.player_scores, {
			timer: 0,
			points: 0
		});
	}
}

function minigame_4vs_start(split = false) {
	player_4vs_positioning();
	
	if (split) {
		camera_4vs_split4(camera_start(objCameraSplit4));
	}
}

function minigame_2vs2_start(info, split = false) {
	player_2vs2_positioning(info);
	
	if (split) {
		camera_2vs2_split4(camera_start(objCameraSplit4), info);
	}
	
	player_2vs2_teammate();
}

function player_4vs_positioning() {
	for (var i = 1; i <= global.player_max; i++) {
		var player = focus_player_by_turn(i);
		
		with (objPlayerReference) {
			if (reference == i) {
				player.x = x + 17;
				player.y = y + 23;
				break;
			}
		}
	}
}

function player_2vs2_positioning(info) {
	var index = 0;
	
	for (var j = 0; j < array_length(info.player_colors); j++) {
		for (var i = 1; i <= global.player_max; i++) {
			var player = focus_player_by_id(i);
			var player_info = player_info_by_id(i);
		
			if (player_info.space == info.player_colors[j]) {
				with (objPlayerReference) {
					if (reference == index) {
						player.x = x + 17;
						player.y = y + 23;
						index++;
						break;
					}
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

function minigame_max_points() {
	return get_frames(1000000);
}

function minigame_4vs_points(info, player_id, points = minigame_max_points()) {
	info.player_scores[player_id].points += points;
}

function minigame_2vs2_points(info, player_id1, player_id2, points = minigame_max_points()) {
	minigame_4vs_points(info, player_id1, points);
	minigame_4vs_points(info, player_id2, points);
}

function minigame_finish() {
	with (objMinigameController) {
		if (!info.is_finished) {
			objPlayerBase.frozen = true;
			show_popup("FINISH");
			audio_play_sound(sndMinigameFinish, 0, false);
			music_stop();
			info.is_finished = true;
			
			for (var i = 1; i <= global.player_max; i++) {
				var player = focus_player_by_id(i);
				
				if (player.object_index != objNetworkPlayer) {
					buffer_seek_begin();
					buffer_write_action(ClientTCP.MinigameFinish);
					buffer_write_data(buffer_u8, i);
					var scoring = info.player_scores[i - 1];
					buffer_write_data(buffer_u32, scoring.timer);
					buffer_write_data(buffer_u32, scoring.points);
					network_send_tcp_packet();
				}
			}
		}
		
		for (var i = 0; i < global.player_max; i++) {
			var scoring = info.player_scores[i];
			
			if (scoring.timer + scoring.points == 0) {
				return;
			}
		}
		
		switch (info.type) {
			case "4vs":
				minigame_4vs_winner(info);
				break;
				
			case "1vs":
				break;
			
			case "2vs2":
				minigame_2vs2_winner(info);
				break;
		}
			
		alarm[2] = get_frames(2);
	}
}

function minigame_4vs_winner(info) {
	var max_score = -infinity;
	
	for (var i = 0; i < global.player_max; i++) {
		var scoring = info.player_scores[i];
		max_score = max(max_score, scoring.points + scoring.timer);
	}
	
	for (var i = 1; i <= global.player_max; i++) {
		var scoring = info.player_scores[i - 1];
		
		if (scoring.points + scoring.timer == max_score) {
			array_push(info.players_won, i);
		}
	}
}

function minigame_2vs2_winner(info) {
	var scores = array_create(2, 0);
	
	for (var i = 0; i < global.player_max; i++) {
		var scoring = info.player_scores[i];
		var color = player_info_by_id(i + 1).space;
		scores[(color == info.player_colors[1])] += scoring.timer + scoring.points;
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
		}
	}
}