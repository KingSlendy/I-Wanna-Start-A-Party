if (!is_local_turn()) {
	exit;
}

if (array_length(player_info.items) > 3) {
	var items = all_item_stats(player_info, false);
	
	show_multiple_choices(language_get_text("PARTY_ITEM_WHAT_ITEM_DISCARD"), items.names, items.sprites, items.descs, items.availables).final_action = function() {
		var change = change_items(player_info.items[global.choice_selected], ItemChangeType.Lose);
		change.final_action = final_action;
	}
	
	exit;
}

if (final_action != null) {
	final_action();
}