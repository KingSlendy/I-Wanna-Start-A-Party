image_alpha = 0;
space_x = 0;
space_y = 0;
final_action = null;
spawned = false;

if (global.dice_roll > 0) {
	final_action = board_advance;
} else if (global.board_turn == 1) {
	final_action = turn_start;
}

fade_state = 0;

function spawn_shine() {
	if (!spawned) {
		instance_create_layer(space_x + 16, space_y + 16, "Actors", objShine);
		spawned = true;
		alarm_call(0, 2);
		var pitch = (room != rBoardHyrule || global.board_light) ? 1 : 0.75;
		audio_play_sound(sndShineSpawn, 0, false, 1, 0, pitch);
	}
}

alarms_init(1);

alarm_create(function() {
	if (instance_number(objShine) < global.shine_spawn_count) {
		if (is_local_turn()) {
			choose_shine();
		}
	
		instance_destroy(id, false);
		return;
	}

	fade_state = 1;
});