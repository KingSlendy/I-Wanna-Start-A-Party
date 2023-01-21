if (sprite_index == normal_sprite) {
	exit;
}

sprite_index = normal_sprite;

if (is_player_locality()) {
	for (var i = 0; i < array_length(global.player_scott_shines); i++) {
		var player = global.player_scott_shines[i];
	
		if (object_index == objBoardWorldScott) {
			change_shines(1, ShineChangeType.Spawn, player_info_by_id(player.network_id).turn);
		} else{
			change_shines(-1, ShineChangeType.Lose, player_info_by_id(player.network_id).turn);
		}
	}
}

with (objBoard) {
	alarm_call(7, 4);
}