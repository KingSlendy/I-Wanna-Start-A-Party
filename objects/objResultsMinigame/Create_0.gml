info = global.minigame_info;
state = 0;
fade_alpha = 1;

with (objPlayerBase) {
	change_to_object(objPlayerBoardData);
}

function minigame_info_placement() {
	places_minigame_repeated = array_create(global.player_max, 0);
	places_minigame_info = [];
	places_minigame_order = [];
		
	for (var i = 1; i <= global.player_max; i++) {
		var info = focus_info_by_turn(i);
		var order = info.player_info.place + places_minigame_repeated[info.player_info.place - 1];
		places_minigame_repeated[info.player_info.place - 1]++;
		array_push(places_minigame_info, info);
		array_push(places_minigame_order, order);
	}
}

minigame_info_placement();

var player_reference = null;

with (objPlayerReference) {
	if (reference == 1) {
		player_reference = id;
		break;
	}
}

if (info.is_finished) {
	for (var i = 0; i < global.player_max; i++) {
		var player_info = places_minigame_info[i];
		var order = places_minigame_order[i];
		var player = focus_player_by_id(player_info.player_info.network_id);
		player.x = (player_reference.x - camera_get_view_width(view_camera[0]) / 2) + (400 - player_info.draw_w / 2) + 20;
		player.y = (player_reference.y - camera_get_view_height(view_camera[0]) / 2) + (79 + (player_info.draw_h + 30) * (order - 1)) + 24;
	}
}

for (var i = 0; i < array_length(info.space_indexes); i++) {
	var space = info.space_indexes[i];
	
	with (objSpaces) {
		if (x == space.x && y == space.y) {
			image_index = space.index;
			space_shine = space.shine;
			break;
		}
	}
}

for (var i = 0; i < array_length(info.shine_positions); i++) {
	var position = info.shine_positions[i];
	
	with (instance_create_layer(position[0], position[1], "Actors", objShine)) {
		image_xscale = 1;
		image_yscale = 1;
		spawning = false;
		floating = true;
	}
}

//World Board
with (objBoardWorldNegaScott) {
	var position;
			
	if (object_index == objBoardWorldNegaGhost) {
		position = other.info.nega_ghost_position;
	} else {
		position = other.info.nega_scott_position;
	}
			
	x = position.x;
	y = position.y;
}

alarms_init(3);

alarm_create(function() {
	if (is_local_turn()) {
		for (var i = 0; i < array_length(info.players_won); i++) {
			var player_won = info.players_won[i];
			change_coins(10, CoinChangeType.Results, player_info_by_id(player_won).turn);
		}
	}

	alarm_call(1, 1);
});

alarm_create(function() {
	if (instance_exists(objStatChange)) {
		alarm_frames(1, 1);
		return;
	}

	minigame_info_placement();

	for (var i = 0; i < global.player_max; i++) {
		var player_info = places_minigame_info[i];
		var order = places_minigame_order[i];
			
		with (player_info) {
			target_draw_x = 400 - draw_w / 2;
			target_draw_y = 79 + (draw_h + 30) * (order - 1);
		}
	}

	alarm_call(2, 1.5);
});

alarm_create(function() {
	state = 1;
});