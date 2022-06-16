depth = -10010;
state = 0;
alpha = 0;
zoom = false;
player_colors = [];
info = global.minigame_info;
minigame_total = 5;
minigames_alpha = 0;
minigames_width = 300;
minigames_height = 40;
minigames_timer = 3;
shuffle_seed_inline();
reset_seed_inline();
minigames_chosen = irandom(minigame_total - 1);
global.choice_selected = irandom(minigame_total - 1);

//Temp
force_type = null;
force_num = 1;
//Temp

objBoard.alarm[11] = 0;

function choosed_minigame() {
	var minigame = minigame_list[global.choice_selected];
	info.reference = minigame;
	
	if (!array_contains(global.seen_minigames, minigame.title)) {
		array_push(global.seen_minigames, minigame.title);
	}
	
	alarm[3] = get_frames(1);
	audio_play_sound(sndRoulettePick, 0, false);
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