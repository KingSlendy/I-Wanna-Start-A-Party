image_alpha = 0;
space_x = 0;
space_y = 0;
final_action = null;

if (global.dice_roll > 0) {
	final_action = board_advance;
} else if (global.board_turn == 1) {
	final_action = turn_start;
}

fade_state = 0;

function spawn_shine() {
	if (!instance_exists(objShine)) {
		instance_create_layer(space_x + 16, space_y + 16, "Actors", objShine);
		alarm[0] = get_frames(2);
		audio_play_sound(sndShineSpawn, 0, false);
	}
}