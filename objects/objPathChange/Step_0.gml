//Temp
if (!is_local_turn() || instance_exists(objMapLook)) {
	exit;
}

for (var i = 0; i < array_length(arrows); i++) {
	var arrow = arrows[i];
	
	if (arrow != null && arrow.image_index == 1 && actions[i].pressed(network_id)) {
		arrows[arrow_selected].image_index = 1;
		arrow.image_index = 0; 
		arrow_selected = i;
		audio_play_sound(global.sound_cursor_move, 0, false);
		break;
	}
}

if (global.actions.jump.pressed(network_id)) {
	audio_play_sound(global.sound_cursor_select, 0, false);
	instance_destroy();
	exit;
}

if (global.actions.shoot.pressed(global.player_id)) {
	show_map();
}