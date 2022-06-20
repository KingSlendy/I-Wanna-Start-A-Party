function Minigame(title, instructions, preview, scene, fangame_name, fangame_index) constructor {
	self.title = title;
	self.instructions = instructions;
	self.preview = preview;
	self.scene = scene;
	self.fangame_name = fangame_name;
	self.fangame_index = fangame_index;
}

global.minigames = {};

function minigame_init() {
	var m = global.minigames;
	m[$ "4vs"] = [
		new Minigame("Follow The Lead", ["Game is still in development.\nMore things will be added.\nThings are subject to change."], 2, rMinigame4vs_Lead, "I Wanna Be The Boshy", 0),
		new Minigame("Tower Ascension", [draw_action(global.actions.left) + draw_action(global.actions.right) + " Move"], 4, rMinigame4vs_Tower, "I Wanna Be The Guy", 1),
		new Minigame("Haunted Forest", [draw_action(global.actions.left) + draw_action(global.actions.right) + " Move"], 8, rMinigame4vs_Haunted, "I Wanna Kill The Guy", 2),
		new Minigame("Magic Memory", ["A set of items are above the pedestals.\nYou have to remember the order before the\nearthquake makes them fall!", draw_action(global.actions.left) + draw_action(global.actions.up) + draw_action(global.actions.down) + draw_action(global.actions.right) + " Move\n" + draw_action(global.actions.jump) + " Hold/Release Item"], 9, rMinigame4vs_Magic, "Not Another Magic Tower Game", 3),
		new Minigame("Mansion Escape", ["You've been trapped in the attic of an old\nmansion!\nBe the first to escape!\nBut pay attention because not every door\nleads downstairs.\nYou need to find that door and quick!", draw_action(global.actions.left) + draw_action(global.actions.right) + " Move\n" + draw_action(global.actions.up) + " Open Door"], 10, rMinigame4vs_Mansion, "Kid World", 4),
	];

	m[$ "1vs3"] = [
		new Minigame("Avoid The Anguish", ["Game is still in development.\nMore things will be added.\nThings are subject to change."], 5, rMinigame1vs3_Avoid, "Avoidance", 5),
		new Minigame("Conveyor Havoc", ["Game is still in development.\nMore things will be added.\nThings are subject to change."], 7, rMinigame1vs3_Conveyor, "Not Another Needle Game", 6),
		new Minigame("Number Showdown", ["{COLOR,0000FFa}Solo Player{COLOR,FFFFFF}:\nPick a number between 1 and 3.\nIf you happen to choose the same number as\none of your opponents, their block\nfalls apart.", "{COLOR,0000FF}Team Players{COLOR,FFFFFF}:\nPick a number between 1 and 3.\nThat number will be on your block.\nIf that number is the same as the one that\n{COLOR,0000FF}Solo Player{COLOR,FFFFFF} picked, then your\nblock breaks.", draw_action(global.actions.jump) + ": Select Number\n" + draw_action(global.actions.left) + draw_action(global.actions.right) + ": Change Number"], 11, rMinigame1vs3_Showdown, "I Wanna Be The Showdown", 7)
	];

	m[$ "2vs2"] = [
		new Minigame("A-Maze-Ing", ["Game is still in development.\nMore things will be added.\nThings are subject to change."], 1, rMinigame2vs2_Maze, "I Wanna Kill The Kamilia 3", 8),
		new Minigame("Catch The Fruits", ["Game is still in development.\nMore things will be added.\nThings are subject to change."], 6, rMinigame2vs2_Fruits, "I Wanna Be The Aura", 9),
		new Minigame("Buttons Everywhere", ["Game is still in development.\nMore things will be added.\nThings are subject to change."], 3, rMinigame2vs2_Buttons, "I Wanna Destroy The 6 Players", 10),
		new Minigame("Fitting Squares", ["Each team must assemble\ntheir squares,\nput both of them in the correct orientation\nto fit them!\nPlayers control half square each.", draw_action(global.actions.left) + draw_action(global.actions.right) + " Change Square Angle"], 12, rMinigame2vs2_Squares, "I Wanna Reach The Moon", 11)
	];
}

function minigame_info_reset() {
	global.minigame_info = {
		reference: null,
		type: "",
		player_colors: [],
		is_practice: false,
		is_finished: false,
		is_modes: false,
		
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
	info.calculated = false;
	
	repeat (global.player_max) {
		array_push(info.player_scores, {
			ready: false,
			timer: 0,
			points: 0
		});
	}
}

enum CameraMode {
	Static,
	Follow,
	Split4
}

function minigame4vs_start(info, mode = CameraMode.Static) {
	player_4vs_positioning();
	
	switch (mode) {
		case CameraMode.Follow: camera_start(objCamera); break;
		case CameraMode.Split4: camera4vs_split4(camera_start(objCameraSplit4)); break;
	}
}

function minigame1vs3_start(info, mode = CameraMode.Static) {
	player_1vs3_positioning(info);
	
	switch (mode) {
		case CameraMode.Follow: camera_start(objCamera); break;
		//case CameraMode.Split4: camera4vs_split4(camera_start(objCameraSplit4)); break;
	}
}

function minigame2vs2_start(info, mode = CameraMode.Static) {
	player_2vs2_positioning(info);
	
	switch (mode) {
		case CameraMode.Follow: camera_start(objCamera); break;
		case CameraMode.Split4: camera2vs2_split4(camera_start(objCameraSplit4), info); break;
	}
	
	player_2vs2_teammate();
}

function player_4vs_positioning() {
	objMinigameController.points_teams = [[], [], [], []];
	
	for (var i = 1; i <= global.player_max; i++) {
		var player = focus_player_by_turn(i);
		
		with (objPlayerReference) {
			if (reference == i) {
				player.x = x + 17;
				player.y = y + 23;
				array_push(objMinigameController.points_teams[i - 1], player);
				break;
			}
		}
	}
}

function player_1vs3_positioning(info) {
	objMinigameController.points_teams = [[], []];
	var index = 1;
	
	with (objPlayerInfo) {
		if (player_info.space == info.player_colors[0]) {
			var player = focus_player_by_turn(player_info.turn);
			
			with (objPlayerReference) {
				if (reference == index) {
					player.x = x + 17;
					player.y = y + 23;
					index++;
					array_push(objMinigameController.points_teams[0], player);
					break;
				}
			}
		}
	}
	
	with (objPlayerInfo) {
		if (player_info.space == info.player_colors[1]) {
			var player = focus_player_by_turn(player_info.turn);
			
			with (objPlayerReference) {
				if (reference == 0) {
					player.x = x + 17;
					player.y = y + 23;
					array_push(objMinigameController.points_teams[1], player);
					break;
				}
			}
		}
	}
}

function player_2vs2_positioning(info) {
	objMinigameController.points_teams = [[], []];
	var index = 0;
	
	for (var j = 0; j < array_length(info.player_colors); j++) {
		for (var i = 1; i <= global.player_max; i++) {
			var player = focus_player_by_turn(i);
			var player_info = player_info_by_turn(i);
		
			if (player_info.space == info.player_colors[j]) {
				with (objPlayerReference) {
					if (reference == index) {
						player.x = x + 17;
						player.y = y + 23;
						index++;
						array_push(objMinigameController.points_teams[j], player);
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

function minigame_add_timer(info, player_id) {
	if (!info.is_finished && is_player_local(player_id + 1)) {
		var scoring = info.player_scores[player_id];
		
		if (!scoring.ready) {
			scoring.timer++;
		}
	}
}

function minigame_max_points() {
	return get_frames(1000000);
}

function minigame4vs_points(info, player_id, points = minigame_max_points()) {
	if (!info.is_finished) {
		var scoring = info.player_scores[player_id - 1];
		
		if (!scoring.ready) {
			scoring.points += points;
		}
	}
}

function minigame2vs2_points(info, player_id1, player_id2, points = minigame_max_points()) {
	minigame4vs_points(info, player_id1, points);
	minigame4vs_points(info, player_id2, points);
}

function minigame_finish(signal = false) {
	with (objMinigameController) {
		action_end();
		alarm[10] = 0;
		
		if (info.calculated) {
			return;
		}
		
		if (!info.is_finished) {
			objPlayerBase.frozen = true;
			show_popup("FINISH");
			announcer_finished = true;
			audio_play_sound(sndMinigameFinish, 0, false);
			music_stop();
			info.is_finished = true;
			
			for (var i = 1; i <= global.player_max; i++) {
				if (is_player_local(i)) {
					buffer_seek_begin();
					buffer_write_action(ClientTCP.MinigameFinish);
					buffer_write_data(buffer_u8, i);
					var scoring = info.player_scores[i - 1];
					scoring.ready = true;
					buffer_write_data(buffer_s32, scoring.timer);
					buffer_write_data(buffer_s32, scoring.points);
					buffer_write_data(buffer_bool, signal);
					network_send_tcp_packet();
				}
			}
		}
		
		//popup(string(global.player_id) +  ": " + string(info.player_scores));
		
		for (var i = 0; i < global.player_max; i++) {
			if (!info.player_scores[i].ready) {
				return;
			}
		}
		
		//popup(string(global.player_id) +  ": " + string(info.player_scores));
		//var file = file_text_open_write("Debug.txt");
		//file_text_write_string(file, string(global.player_id) +  ": " + string(info.player_scores));
		//file_text_close(file);
		
		switch (info.type) {
			case "4vs":
				minigame_4vs_winner(info);
				break;
				
			case "1vs3":
				minigame_1vs3_winner(info);
				break;
			
			case "2vs2":
				minigame_2vs2_winner(info);
				break;
		}
			
		info.calculated = true;
		alarm[2] = get_frames(2);
	}
}

function minigame_4vs_winner(info) {
	var max_score = -infinity;
	
	for (var i = 0; i < global.player_max; i++) {
		var scoring = info.player_scores[i];
		max_score = max(max_score, scoring.points);
	}
	
	for (var i = 1; i <= global.player_max; i++) {
		var scoring = info.player_scores[i - 1];
		
		if (scoring.points == max_score) {
			array_push(info.players_won, i);
		}
	}
}

function minigame_1vs3_winner(info) {
	var scores = array_create(2, 0);
	
	for (var i = 0; i < global.player_max; i++) {
		var scoring = info.player_scores[i];
		var color = player_info_by_id(i + 1).space;
		scores[(color == info.player_colors[1])] += scoring.points;
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
			
		if (color == info.color_won) {
			array_push(info.players_won, i);
		}
	}
}

function minigame_2vs2_winner(info) {
	var scores = array_create(2, 0);
	
	for (var i = 0; i < global.player_max; i++) {
		var scoring = info.player_scores[i];
		var color = player_info_by_id(i + 1).space;
		scores[(color == info.player_colors[1])] += scoring.points;
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
			
		if (color == info.color_won) {
			array_push(info.players_won, i);
		}
	}
}
