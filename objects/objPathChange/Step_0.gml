//Temp
if (instance_exists(objMapLook)) {
	exit;
}

for (var i = 0; i < array_length(arrows); i++) {
	var arrow = arrows[i];
	
	if (arrow != null && arrow.image_index == 1 && actions[i].pressed()) {
		arrows[arrow_selected].image_index = 1;
		arrow.image_index = 0; 
		arrow_selected = i;
		audio_play_sound(global.sound_cursor_move, 0, false);
		break;
	}
}

if (global.actions.jump.pressed()) {
	audio_play_sound(global.sound_cursor_select, 0, false);
	instance_destroy();
}