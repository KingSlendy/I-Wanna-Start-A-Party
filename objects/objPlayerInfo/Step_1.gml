var player = focus_player_by_id(player_info.network_id);

if (player != null) {
	player.image_speed = 1;
	player.image_blend = c_white;
}

if (!IS_BOARD) {
	exit;
}

with (player) {
	switch (other.player_info.item_effect) {
		case ItemType.Poison:
			image_blend = c_fuchsia;
			break;
		
		case ItemType.Ice:
			image_speed = 0;
			image_blend = c_aqua;
			break;
	}
}