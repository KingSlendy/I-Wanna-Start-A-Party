///@desc Item Use Animation
if (!used_item) {
	player_info.items[global.choice_selected] = null;
	player_info.item_used = true;
	
	if (focus_player != null && instance_exists(focus_player)) {
		spawned_item = instance_create_layer(focus_player.x, focus_player.y - 40, "Actors", objItem);
		spawned_item.focus_player = focus_player;
		spawned_item.sprite_index = item.sprite;
	}
	
	used_item = true;
	alarm[3] = get_frames(1.5);
} else {
	if (spawned_item != null) {
		spawned_item.vspeed = 3;
		spawned_item.used = true;
	}
	
	animation_state = 2;
	animation_alpha = 1;
	
	final_action = function() {
		item_applied(item);
	}
}