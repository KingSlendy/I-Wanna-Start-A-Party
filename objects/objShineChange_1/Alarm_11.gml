if (instance_exists(spawned_shine)) {
	instance_destroy(spawned_shine);
}

animation_state = 1;
player_info.shines += amount;
player_info.shines = clamp(player_info.shines, 0, 999);
calculate_player_place();