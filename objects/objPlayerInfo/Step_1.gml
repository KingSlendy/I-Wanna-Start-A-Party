if (player_focus == null) {
	player_focus = focus_player(player_info.network_id);
	exit;
}

with (player_focus) {
	switch (other.player_info.item_effect) {
		case ItemType.Poison:
			image_blend = c_fuchsia;
			break;
		
		case ItemType.Ice:
			image_speed = 0;
			image_blend = c_aqua;
			break;
		
		default:
			image_speed = 1;
			image_blend = c_white;
			break;
	}
}