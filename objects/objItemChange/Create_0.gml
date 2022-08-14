enum ItemChangeType {
	None,
	Gain,
	Lose,
	Use
}

event_inherited();
item = null;
spawned_item = null;
used_item = false;

alarm_create(function() {
	focus_player = focus_player_by_id(network_id);
	var i = instance_create_layer(focus_player.x, focus_player.y - 40, "Actors", objItem);
	i.focus_player = focus_player;
	i.sprite_index = item.sprite;
	i.vspeed = -6;
	i.gravity = 0.3;

	alarm_call(11, 1);
});

alarm_create(function() {
	focus_player = focus_player_by_id(network_id);
	var i = instance_create_layer(focus_player.x, focus_player.y - 40, "Actors", objItem);
	i.focus_player = focus_player;
	i.sprite_index = item.sprite;
	
	with (i) {
		alarm_call(0, 1);
	}

	alarm_call(11, 1.5);
});

alarm_create(function() {
	if (!used_item) {
		player_info.items[global.choice_selected] = null;
		player_info.item_used = item.id;
		focus_player = focus_player_by_id(network_id);
		spawned_item = instance_create_layer(focus_player.x, focus_player.y - 40, "Actors", objItem);
		spawned_item.focus_player = focus_player;
		spawned_item.sprite_index = item.sprite;
		used_item = true;
		alarm_call(3, 1.5);
	} else {
		if (spawned_item != null && instance_exists(spawned_item)) {
			spawned_item.vspeed = 3;
			spawned_item.used = true;
		}
	
		animation_state = 2;
		animation_alpha = 1;
	
		final_action = function() {
			item_applied(item);
		}
	}
});

alarm_create(11, function() {
	animation_state = 1;

	if (animation_type == ItemChangeType.Gain) {
		player_info.items[player_info.free_item_slot()] = item;
	} else {
		array_delete(player_info.items, global.choice_selected, 1);
	}
});