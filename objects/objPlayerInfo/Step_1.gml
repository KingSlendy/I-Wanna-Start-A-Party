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

if (player.network_id == global.player_id) {
	var str_place = string(player_info.place);
	var str_shines = string(player_info.shines);
	var str_coins = string(player_info.coins);
	
	if (string_count(str_place, str_shines) == string_length(str_shines) && string_count(str_place, str_coins) == string_length(str_coins)) {
		achieve_trophy(55);
	}
}

with (objChanceTime) {
	if (started && !array_contains(player_ids, other.player_info.turn - 1)) {
		exit;
	}
}

if (global.player_turn != player_info.turn) {
	if (reactions) {
		var move_v = (global.actions.down.pressed(player_info.network_id) - global.actions.up.pressed(player_info.network_id));
		var move_h = (global.actions.right.pressed(player_info.network_id) - global.actions.left.pressed(player_info.network_id));
		
		if (move_v != 0) {
			selected += move_v;
			move_h = 0;
			audio_play_sound(global.sound_cursor_move, 0, false);
		}
		
		if (move_h != 0) {
			selected += 2 * move_h;
			audio_play_sound(global.sound_cursor_move, 0, false);
		}
		
		selected = clamp(selected, 0, sprite_get_number(sprReactions) - 1);
		
		if (selected < 2 * page) {
			page--;
		}
		
		if (selected >= 2 * (page + 2)) {
			page++;
		}
		
		if (have_reaction(selected) && global.actions.jump.pressed(player_info.network_id)) {
			reaction(selected);
		}
	}
	
	if (can_react() && reaction_target == 0 && reaction_alpha == 0 && global.actions.shoot.pressed(player_info.network_id)) {
		reactions ^= true;
		audio_play_sound(global.sound_cursor_select2, 0, false);
	}
}