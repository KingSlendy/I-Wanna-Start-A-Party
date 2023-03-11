if (sprite_index == normal_sprite) {
	exit;
}

sprite_index = normal_sprite;

if (is_local_turn()) {
	var player = focus_player_by_id(global.player_ghost_shines[0]);
	change_shines(-1, ShineChangeType.Lose, player_info_by_id(player.network_id).turn);
}

alarm_call(0, 4);