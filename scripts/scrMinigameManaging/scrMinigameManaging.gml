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
	new Minigame(,,, rMinigame2vs2_Maze)
];

function minigame_info_reset() {
	global.minigame_info = {
		reference: global.minigames[$ "2vs2"][0],
		type: "",
		player_colors: [],
		is_practice: false,
		player_scores: array_create(global.player_max, 0),
		players_won: [],
		color_won: c_white
	}	
}

function player_positioning_4vs() {
}

function player_positioning_2vs2(info) {
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

function player_2vs2_teammate(info) {
	with (objPlayerBase) {
		for (var i = 1; i <= global.player_max; i++) {
			var player = focus_player_by_turn(i);
			
			if (player.id == id) {
				continue;
			}
			
			if (player_info_by_id(player.network_id).space == player_info_by_id(network_id).space) {
				teammate = player;
				break;
			}
		}
	}
}

function minigame_finish(color) {
	with (objMinigameController) {
		info.color_won = color;
		
		if (!finished) {
			event_perform(ev_alarm, 2);
			finished = true;
		}
	}
}