global.minigame_price = 5000;

function Minigame(title, instructions, preview, scene, fangame_name) constructor {
	self.title = title;
	self.instructions = instructions;
	self.preview = preview;
	self.scene = scene;
	self.fangame_name = fangame_name;
	
	var w = sprite_get_width(sprMinigameOverview_Preview);
	var h = sprite_get_height(sprMinigameOverview_Preview);
	var w_half = floor(w / 2);
	var h_half = floor(h / 2);
	var p_surf = surface_create(w, h);
	surface_set_target(p_surf);
	draw_sprite(sprMinigameOverview_Preview, 1, w_half, h_half);
	gpu_set_colorwriteenable(true, true, true, false);
	draw_sprite_stretched(sprMinigameOverview_Pictures, self.preview, 44, 15, w - 88, h - 31);
	gpu_set_colorwriteenable(true, true, true, true);
	draw_sprite(sprMinigameOverview_Preview, 0, w_half, h_half);
	surface_reset_target();
	self.portrait = sprite_create_from_surface(p_surf, 0, 0, w, h, false, false, w_half, h_half);

	surface_set_target(p_surf);
	draw_clear_alpha(c_black, 0);
	draw_sprite(sprMinigameOverview_Preview, 1, w_half, h_half);
	gpu_set_colorwriteenable(true, true, true, false);
	draw_sprite_stretched(sprMinigameOverview_Pictures, 0, 44, 15, w - 88, h - 31);
	gpu_set_colorwriteenable(true, true, true, true);
	draw_sprite(sprMinigameOverview_Preview, 0, w_half, h_half);
	surface_reset_target();
	self.hidden = sprite_create_from_surface(p_surf, 0, 0, w, h, false, false, w_half, h_half);
	surface_free(p_surf);
}

global.minigames = {};

function minigame_init() {
	var m = global.minigames;
	m[$ "4vs"] = [
		new Minigame("Follow The Lead", ["{COLOR,0000FF}Rules{COLOR,FFFFFF}:\nTBD", "{COLOR,0000FF}Controls{COLOR,FFFFFF}:\nTBD"], 2, rMinigame4vs_Lead, "I Wanna Be The Boshy"),
		new Minigame("Tower Ascension", ["{COLOR,0000FF}Rules{COLOR,FFFFFF}:\nTBD", "{COLOR,0000FF}Controls{COLOR,FFFFFF}:\n" + draw_action(global.actions.left) + draw_action(global.actions.right) + " Move"], 4, rMinigame4vs_Tower, "I Wanna Be The Guy"),
		new Minigame("Haunted Forest", ["{COLOR,0000FF}Rules{COLOR,FFFFFF}:\nTBD", "{COLOR,0000FF}Controls{COLOR,FFFFFF}:\n" + draw_action(global.actions.left) + draw_action(global.actions.right) + " Move"], 8, rMinigame4vs_Haunted, "I Wanna Kill The Guy"),
		new Minigame("Magic Memory", ["{COLOR,0000FF}Rules{COLOR,FFFFFF}:\nA set of items are above the pedestals.\nRemember the order of each item before\nthe earthquake strikes!\nPut them all back in the correct order.", "{COLOR,0000FF}Controls{COLOR,FFFFFF}:\n" + draw_action(global.actions.left) + draw_action(global.actions.up) + draw_action(global.actions.down) + draw_action(global.actions.right) + " Move\n" + draw_action(global.actions.jump) + " Hold/Release Item\n" + draw_action(global.actions.shoot) + " Cover Items"], 9, rMinigame4vs_Magic, "Not Another Magic Tower Game"),
		new Minigame("Mansion Escape", ["{COLOR,0000FF}Rules{COLOR,FFFFFF}:\nYou've been trapped in the attic of an old\nmansion!\nBe the first to escape!\nFind all the doors that lead downstairs.", "{COLOR,0000FF}Controls{COLOR,FFFFFF}:\n" + draw_action(global.actions.left) + draw_action(global.actions.right) + " Move\n" + draw_action(global.actions.up) + " Open Door"], 10, rMinigame4vs_Mansion, "Kid World"),
		new Minigame("Painting Platforms", ["{COLOR,0000FF}Rules{COLOR,FFFFFF}:\nTBD", "{COLOR,0000FF}Controls{COLOR,FFFFFF}:\nTBD"], 16, rMinigame4vs_Painting, "I Wanna Thank You MJIWBT"),
		new Minigame("Bugs Around", ["{COLOR,0000FF}Rules{COLOR,FFFFFF}:\nTBD", "{COLOR,0000FF}Controls{COLOR,FFFFFF}:\nTBD"], 17, rMinigame4vs_Bugs, "I Wanna Delete The Huge Bug"),
		new Minigame("Unstable Blocks", ["{COLOR,0000FF}Rules{COLOR,FFFFFF}:\nTBD", "{COLOR,0000FF}Controls{COLOR,FFFFFF}:\nTBD"], 18, rMinigame4vs_Blocks, "I Wanna Thank You TNG"),
		new Minigame("Crazy Chests", ["{COLOR,0000FF}Rules{COLOR,FFFFFF}:\nTBD", "{COLOR,0000FF}Controls{COLOR,FFFFFF}:\nTBD"], 19, rMinigame4vs_Chests, "I Wanna Be The Fangame"),
		new Minigame("Slime Annoyer", ["{COLOR,0000FF}Rules{COLOR,FFFFFF}:\nTBD", "{COLOR,0000FF}Controls{COLOR,FFFFFF}:\nTBD"], 23, rMinigame4vs_Slime, "SlimePark"),
		new Minigame("Rocket Ignition", ["{COLOR,0000FF}Rules{COLOR,FFFFFF}:\nTBD", "{COLOR,0000FF}Controls{COLOR,FFFFFF}:\nTBD"], 24, rMinigame4vs_Rocket, "I Wanna Walk OIT Morning Dew"),
		new Minigame("Dizzy Conundrum", ["{COLOR,0000FF}Rules{COLOR,FFFFFF}:\nTBD", "{COLOR,0000FF}Controls{COLOR,FFFFFF}:\nTBD"], 25, rMinigame4vs_Dizzy, "VoVoVo"),
		new Minigame("Targeting Targets", ["{COLOR,0000FF}Rules{COLOR,FFFFFF}:\nTBD", "{COLOR,0000FF}Controls{COLOR,FFFFFF}:\nTBD"], 27, rMinigame4vs_Targets, "I Wanna Be The Micromedley"),
		new Minigame("Uncertain Bullets", ["{COLOR,0000FF}Rules{COLOR,FFFFFF}:\nTBD", "{COLOR,0000FF}Controls{COLOR,FFFFFF}:\nTBD"], 30, rMinigame4vs_Bullets, "I Wanna Be A Big Man"),
		new Minigame("Drawn Keys", ["{COLOR,0000FF}Rules{COLOR,FFFFFF}:\nTBD", "{COLOR,0000FF}Controls{COLOR,FFFFFF}:\nTBD"], 31, rMinigame4vs_Drawn, "I Wanna Be Drawn"),
		new Minigame("Bubble Derby", ["{COLOR,0000FF}Rules{COLOR,FFFFFF}:\nTBD", "{COLOR,0000FF}Controls{COLOR,FFFFFF}:\nTBD"], 36, rMinigame4vs_Bubble, "I Wanna Enjoy The Excursion"),
		new Minigame("Whac-an-idol", ["{COLOR,0000FF}Rules{COLOR,FFFFFF}:\nTBD", "{COLOR,0000FF}Controls{COLOR,FFFFFF}:\nTBD"], 37, rMinigame4vs_Idol, "I Wanna Be The iDOLM@STER"),
		new Minigame("Sky Diving", ["{COLOR,0000FF}Rules{COLOR,FFFFFF}:\nTBD", "{COLOR,0000FF}Controls{COLOR,FFFFFF}:\nTBD"], 38, rMinigame4vs_Sky, "I Wanna Kill The Kamilia"),
		new Minigame("Golf Course", ["{COLOR,0000FF}Rules{COLOR,FFFFFF}:\nTBD", "{COLOR,0000FF}Controls{COLOR,FFFFFF}:\nTBD"], 39, rMinigame4vs_Golf, "I Wanna Run The Marathon"),
		new Minigame("Waka Evasion", ["{COLOR,0000FF}Rules{COLOR,FFFFFF}:\nTBD", "{COLOR,0000FF}Controls{COLOR,FFFFFF}:\nTBD"], 40, rMinigame4vs_Waka, "I Wanna Be The Onelife")
	];

	m[$ "1vs3"] = [
		new Minigame("Avoid The Anguish", ["{COLOR,0000FF}Rules{COLOR,FFFFFF}:\nTBD", "{COLOR,0000FF}Controls{COLOR,FFFFFF}:\nTBD"], 5, rMinigame1vs3_Avoid, "I Wanna Be The Lucky"),
		new Minigame("Conveyor Havoc", ["{COLOR,0000FF}Rules{COLOR,FFFFFF}:\nTBD", "{COLOR,0000FF}Controls{COLOR,FFFFFF}:\nTBD"], 7, rMinigame1vs3_Conveyor, "Not Another Needle Game"),
		new Minigame("Number Showdown", ["{COLOR,0000FF}Solo Player{COLOR,FFFFFF}:\nPick a number between 1 and 3.\nIf you happen to choose the same number as\none of your opponents, their block\nfalls apart.", "{COLOR,0000FF}Team Players{COLOR,FFFFFF}:\nPick a number between 1 and 3.\nThat number will be on your block.\nIf that number is the same as the one that\n{COLOR,0000FF}Solo Player{COLOR,FFFFFF} picked, then your\nblock breaks.", "{COLOR,0000FF}Controls{COLOR,FFFFFF}:\n" + draw_action(global.actions.jump) + " Select Number\n" + draw_action(global.actions.left) + draw_action(global.actions.right) + " Change Number"], 11, rMinigame1vs3_Showdown, "I Wanna Be The Showdown"),
		new Minigame("Getting Coins", ["{COLOR,0000FF}Rules{COLOR,FFFFFF}:\nTBD", "{COLOR,0000FF}Controls{COLOR,FFFFFF}:\nTBD"], 13, rMinigame1vs3_Coins, "I Wanna Get The Coins"),
		new Minigame("Gigantic Race", ["{COLOR,0000FF}Rules{COLOR,FFFFFF}:\nTBD", "{COLOR,0000FF}Controls{COLOR,FFFFFF}:\nTBD"], 15, rMinigame1vs3_Race, "I Wanna Kill The Kamilia 2"),
		new Minigame("Warping Up", ["{COLOR,0000FF}Rules{COLOR,FFFFFF}:\nTBD", "{COLOR,0000FF}Controls{COLOR,FFFFFF}:\nTBD"], 22, rMinigame1vs3_Warping, "I Wanna GameOver"),
		new Minigame("Hunt Trouble", ["{COLOR,0000FF}Rules{COLOR,FFFFFF}:\nTBD", "{COLOR,0000FF}Controls{COLOR,FFFFFF}:\nTBD"], 26, rMinigame1vs3_Hunt, "I Wanna Be The Ultimatum"),
		new Minigame("Aiming Tiles", ["{COLOR,0000FF}Rules{COLOR,FFFFFF}:\nTBD", "{COLOR,0000FF}Controls{COLOR,FFFFFF}:\nTBD"], 32, rMinigame1vs3_Aiming, "I Wanna Be The Farewell"),
		new Minigame("Hidden Host", ["{COLOR,0000FF}Rules{COLOR,FFFFFF}:\nTBD", "{COLOR,0000FF}Controls{COLOR,FFFFFF}:\nTBD"], 33, rMinigame1vs3_Host, "I Wanna Escape Heavenly Host"),
		new Minigame("Bad House", ["{COLOR,0000FF}Rules{COLOR,FFFFFF}:\nTBD", "{COLOR,0000FF}Controls{COLOR,FFFFFF}:\nTBD"], 34, rMinigame1vs3_House, "Crimson Needle 3")
	];

	m[$ "2vs2"] = [
		new Minigame("A-Maze-Ing", ["{COLOR,0000FF}Rules{COLOR,FFFFFF}:\nTBD", "{COLOR,0000FF}Controls{COLOR,FFFFFF}:\nTBD"], 1, rMinigame2vs2_Maze, "I Wanna Kill The Kamilia 3"),
		new Minigame("Catch The Fruits", ["{COLOR,0000FF}Rules{COLOR,FFFFFF}:\nTBD", "{COLOR,0000FF}Controls{COLOR,FFFFFF}:\nTBD"], 6, rMinigame2vs2_Fruits, "I Wanna Be The Aura"),
		new Minigame("Buttons Everywhere", ["{COLOR,0000FF}Rules{COLOR,FFFFFF}:\nTBD", "{COLOR,0000FF}Controls{COLOR,FFFFFF}:\nTBD"], 3, rMinigame2vs2_Buttons, "I Wanna Destroy The 6 Players"),
		new Minigame("Fitting Squares", ["{COLOR,0000FF}Rules{COLOR,FFFFFF}:\nEach team must assemble\ntheir squares,\nput both of them in the correct orientation\nto fit them!\nPlayers control half square each.", "{COLOR,0000FF}Controls{COLOR,FFFFFF}:\n" + draw_action(global.actions.left) + draw_action(global.actions.right) + " Change Square Angle"], 12, rMinigame2vs2_Squares, "I Wanna Reach The Moon"),
		new Minigame("Colorful Insanity", ["{COLOR,0000FF}Rules{COLOR,FFFFFF}:\nTBD", "{COLOR,0000FF}Controls{COLOR,FFFFFF}:\nTBD"], 14, rMinigame2vs2_Colorful, "I Wanna Be A Charr"),
		new Minigame("Springing Piranha", ["{COLOR,0000FF}Rules{COLOR,FFFFFF}:\nTBD", "{COLOR,0000FF}Controls{COLOR,FFFFFF}:\nTBD"], 20, rMinigame2vs2_Springing, "I Wanna Be The Co-op"),
		new Minigame("Dinnyamic Duos", ["{COLOR,0000FF}Rules{COLOR,FFFFFF}:\nTBD", "{COLOR,0000FF}Controls{COLOR,FFFFFF}:\nTBD"], 21, rMinigame2vs2_Duos, "I Wannyaaaaaaa"),
		new Minigame("Western Duel", ["{COLOR,0000FF}Rules{COLOR,FFFFFF}:\nTBD", "{COLOR,0000FF}Controls{COLOR,FFFFFF}:\nTBD"], 28, rMinigame2vs2_Duel, "I Wanna Be The Galaxy"),
		new Minigame("Soccer Match", ["{COLOR,0000FF}Rules{COLOR,FFFFFF}:\nTBD", "{COLOR,0000FF}Controls{COLOR,FFFFFF}:\nTBD"], 29, rMinigame2vs2_Soccer, "I Wanna Be The GReeeeN"),
		new Minigame("Jingle Sledge", ["{COLOR,0000FF}Rules{COLOR,FFFFFF}:\nTBD", "{COLOR,0000FF}Controls{COLOR,FFFFFF}:\nTBD"], 35, rMinigame2vs2_Jingle, "Jingle Jam")
	];
}

function minigame_types() {
	return ["4vs", "1vs3", "2vs2"];
}

function minigame_unlock(title) {
	if (!array_contains(global.seen_minigames, title)) {
		array_push(global.seen_minigames, title);
	}
	
	if (array_length(global.seen_minigames) == array_length(global.minigames[$ "4vs"]) + array_length(global.minigames[$ "1vs3"]) + array_length(global.minigames[$ "2vs2"])) {
		achieve_trophy(64);
	}
}

function minigame_info_reset() {
	global.minigame_info = {
		reference: null,
		type: "",
		player_colors: [],
		is_practice: false,
		is_finished: false,
		is_minigames: false,
		
		previous_board: null,
		player_positions: [],
		space_indexes: [],
		shine_positions: []
	}
	
	minigame_info_score_reset();
}

function minigame_info_score_reset() {
	var info = global.minigame_info;
	info.player_scores = [];
	info.players_won = [];
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
	Split4,
	Center
}

function players_start() {
	var apply = minigame_players;
	
	with (objPlayerBase) {
		with (change_to_object(other.player_type)) {
			apply();
			event_perform(ev_other, ev_room_start);
			frozen = true;
		}
	}
	
	for (var i = 0; i < array_length(points_teams); i++) {
		for (var j = 0; j < array_length(points_teams[i]); j++) {
			objMinigameController.points_teams[i][j] = focus_player_by_turn(objMinigameController.points_teams[i][j]);
		}
	}
}

function minigame4vs_start(info, mode = CameraMode.Static) {
	player_4vs_positioning();
	players_start();
	
	switch (mode) {
		case CameraMode.Follow: camera_start(objCamera); break;
		case CameraMode.Split4: camera4vs_split4(camera_start(objCameraSplit4)); break;
		case CameraMode.Center: camera_start(objCameraCenter); break;
	}
}

function minigame1vs3_start(info, mode = CameraMode.Static) {
	player_1vs3_positioning(info);
	players_start();
	
	switch (mode) {
		case CameraMode.Follow: camera_start(objCamera); break;
		case CameraMode.Split4: camera4vs_split4(camera_start(objCameraSplit4)); break;
		case CameraMode.Center: camera_start(objCameraCenter); break;
	}
}

function minigame2vs2_start(info, mode = CameraMode.Static) {
	player_2vs2_positioning(info);
	players_start();
	
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
				array_push(objMinigameController.points_teams[i - 1], i);
				break;
			}
		}
	}
}

function player_1vs3_positioning(info) {
	objMinigameController.points_teams = [[], []];
	var index = 1;
	
	for (var i = 1; i <= global.player_max; i++) {
		var player = focus_player_by_turn(i);
		var player_info = player_info_by_turn(i);
		
		if (player_info.space == info.player_colors[0]) {
			with (objPlayerReference) {
				if (reference == index) {
					player.x = x + 17;
					player.y = y + 23;
					index++;
					array_push(objMinigameController.points_teams[0], i);
					break;
				}
			}
		}
	}
	
	for (var i = 1; i <= global.player_max; i++) {
		var player = focus_player_by_turn(i);
		var player_info = player_info_by_turn(i);
		
		if (player_info.space == info.player_colors[1]) {
			with (objPlayerReference) {
				if (reference == 0) {
					player.x = x + 17;
					player.y = y + 23;
					array_push(objMinigameController.points_teams[1], i);
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
						array_push(objMinigameController.points_teams[j], i);
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

function minigame4vs_points(player_id, points = minigame_max_points()) {
	var info = global.minigame_info;
	
	if (!info.is_finished) {
		var scoring = info.player_scores[player_id - 1];
		
		if (!scoring.ready) {
			scoring.points += points;
		}
	}
}

function minigame1vs3_points(points = minigame_max_points()) {
	for (var i = 0; i < array_length(points_teams[0]); i++) {
		minigame4vs_points(points_teams[0][i].network_id, points);
	}
}

function minigame2vs2_points(player_id1, player_id2, points = minigame_max_points()) {
	minigame4vs_points(player_id1, points);
	minigame4vs_points(player_id2, points);
}

function minigame4vs_get_points(player_id) {
	var info = global.minigame_info;
	return info.player_scores[player_id - 1].points;
}

function minigame2vs2_get_points(player_id1, player_id2) {
	return minigame4vs_get_points(player_id1) + minigame4vs_get_points(player_id2);
}

function minigame2vs2_get_points_team(id) {
	return minigame2vs2_get_points(points_teams[id][0].network_id, points_teams[id][1].network_id);	
}

function minigame_finish(signal = false) {
	with (objMinigameController) {
		action_end();
		alarm_stop(10);
		alarm_stop(11);
		
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
					var player_info = player_info_by_id(i);
					buffer_write_data(buffer_u16, player_info.shines);
					buffer_write_data(buffer_u16, player_info.coins);
					buffer_write_data(buffer_bool, signal);
					network_send_tcp_packet();
				}
			}
		}
		
		for (var i = 0; i < global.player_max; i++) {
			if (!info.player_scores[i].ready) {
				return;
			}
		}
		
		switch (info.type) {
			case "4vs": minigame4vs_winner(); break;
			case "1vs3": minigame1vs3_winner(); break;
			case "2vs2": minigame2vs2_winner(); break;
		}
			
		info.calculated = true;
		alarm_call(2, 2);
	}
}

function minigame4vs_winner() {
	var info = global.minigame_info;
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

function minigame1vs3_winner() {
	var info = global.minigame_info;
	var scores = array_create(2, 0);
	
	for (var i = 0; i < global.player_max; i++) {
		var scoring = info.player_scores[i];
		var color = player_info_by_id(i + 1).space;
		scores[(color == info.player_colors[1])] += scoring.points;
	}
	
	if (scores[0] == scores[1]) {
		//Both teams have tied
		var color_won = c_white;
	} else {
		//Determines which team color wins
		var color_won = info.player_colors[(scores[1] > scores[0])];
	}
	
	for (var i = 1; i <= global.player_max; i++) {
		var color = player_info_by_id(i).space;
			
		if (color == color_won) {
			array_push(info.players_won, i);
		}
	}
}

function minigame2vs2_winner() {
	var info = global.minigame_info;
	var scores = array_create(2, 0);
	
	for (var i = 0; i < global.player_max; i++) {
		var scoring = info.player_scores[i];
		var color = player_info_by_id(i + 1).space;
		scores[(color == info.player_colors[1])] += scoring.points;
	}
	
	if (scores[0] == scores[1]) {
		//Both teams have tied
		var color_won = c_white;
	} else {
		//Determines which team color wins
		var color_won = info.player_colors[(scores[1] > scores[0])];
	}
	
	for (var i = 1; i <= global.player_max; i++) {
		var color = player_info_by_id(i).space;
			
		if (color == color_won) {
			array_push(info.players_won, i);
		}
	}
}

function minigame_times_up() {
	show_popup("TIMES UP");
	audio_play_sound(sndMinigameTimesUp, 0, false);
	music_stop();
}

function minigame_lost_all(count_last = false) {
	var lost_count = 0;

	with (objPlayerBase) {
		lost_count += lost;
	}
	
	var count = (!count_last) ? global.player_max - 1 : global.player_max;
	return (lost_count >= count);
}

function minigame_lost_points() {
	with (objPlayerBase) {
		if (lost) {
			continue;
		}
		
		minigame4vs_points(network_id);
	}
}

function minigame1vs3_lost() {
	for (var i = 0; i < array_length(points_teams[0]); i++) {
		if (!points_teams[0][i].lost) {
			return false;
		}
	}
	
	return true;
}