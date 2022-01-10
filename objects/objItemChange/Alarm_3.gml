///@desc Item Use Animation
if (!used_item) {
	player_turn_info.items[global.choice_selected] = null;
	player_turn_info.item_used = true;
	var focus = focused_player_turn();
	spawned_item = instance_create_layer(focus.x, focus.y - 40, "Actors", objItem);
	spawned_item.sprite_index = item.sprite;
	alarm[3] = get_frames(1.5);
	used_item = true;
} else {
	spawned_item.vspeed = 3;
	spawned_item.used = true;
	animation_state = 2;
	animation_alpha = 1;
	
	final_action = function() {
		item_applied(item);
	}
}