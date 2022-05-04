animation_state = 1;

if (animation_type == ItemChangeType.Gain) {
	player_info.items[player_info.free_item_slot()] = item;
} else {
	array_delete(player_info.items, slot_removed, 1);
}
