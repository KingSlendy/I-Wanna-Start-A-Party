if (array_length(player_info.items) > 3) {
	var items = all_item_stats(player_info);
	
	show_multiple_choices(items.names, items.sprites, items.descs, items.availables).final_action = function() {
		var change = change_items(player_info.items[global.choice_selected], ItemChangeType.Lose);
		change.final_action = final_action;
	}
	
	exit;
}

if (final_action != null && is_local_turn()) {
	final_action();
}