event_inherited();

enum ShineChangeType {
	None,
	Get,
	Lose,
	Spawn,
	Exchange
}

spawned_shine = noone;
animation_type = ShineChangeType.None;
final_action = choose_shine;

alarm_create(function() {
	if (spawned_shine == noone) {
		with (focus_player_by_id(network_id)) {
			other.spawned_shine = instance_nearest(x, y, objShine);
		}
		
		if (room == rBoardHotland) {
			with (objShine) {
				if (id != other.spawned_shine) {
					losing = true;
					faker = true;
					break;
				}
			}
		}
	}

	spawned_shine.floating = false;
	spawned_shine.getting = true;
	spawned_shine = noone;
});

alarm_create(function() {
	focus_player = focus_player_by_id(network_id);

	if (spawned_shine == noone) {
		spawned_shine = instance_create_layer(focus_player.x, focus_player.y, "Actors", objShine);
		spawned_shine.focus_player = focus_player;
		alarm_call(ShineChangeType.Lose, 1);
	} else {
		spawned_shine.vspeed = -6;
		spawned_shine.losing = true;
		
		if (room == rBoardHyrule && !global.board_light) {
			audio_sound_pitch(sndShineGet, 0.75);
		} else {
			audio_sound_pitch(sndShineGet, 1);
		}
		
		audio_play_sound(sndShineGet, 0, false);
	}
});

alarm_create(function() {
	focus_player = focus_player_by_id(network_id);
	spawned_shine = instance_create_layer(focus_player.x, focus_player.y, "Actors", objShine);
	spawned_shine.focus_player = focus_player;

	if (instance_exists(objChooseShine)) {
		if (room == rBoardHyrule && !global.board_light) {
			audio_sound_pitch(sndShineSpawn, 0.75);
		} else {
			audio_sound_pitch(sndShineSpawn, 1);
		}
		
		audio_play_sound(sndShineSpawn, 0, false);
	}

	alarm_call(ShineChangeType.Get, 1);
});

alarm_create(11, function() {
	if (instance_exists(spawned_shine)) {
		instance_destroy(spawned_shine);
	}

	animation_state = 1;
	player_info.shines += amount;
	player_info.shines = clamp(player_info.shines, 0, 999);
	calculate_player_place();
});