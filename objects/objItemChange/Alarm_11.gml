var player_turn_info = get_player_turn_info();

if (slot == -1) {
	animation_state = 1;
	player_turn_info.items[player_turn_info.free_item_slot()] = item;
} else {
	spawned_item.vspeed = 3;
	player_turn_info.items[slot] = null;
	player_turn_info.item_used = item;
	item_applied(item);
	instance_destroy();
}