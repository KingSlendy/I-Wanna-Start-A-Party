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
final_action = null;

alarm_create(function() {
	var player = focus_player_by_id(network_id);
	
	//Only if the animation type is Get then the "remove Shine Space" event gets triggered
	if (spawned_shine == noone) {
		with (player) {
			other.spawned_shine = instance_nearest(x, y, objShine);
		}
		
		if (room == rBoardHotland) {
			with (objShine) {
				if (id != other.spawned_shine) {
					losing = true;
					
					if (other.animation_type == ShineChangeType.Get) {
						changing = true;
					}
					
					faker = true;
					break;
				}
			}
		}
	}

	with (spawned_shine) {
		floating = false;
		spawning = false;
		getting = true;
		
		if (other.animation_type == ShineChangeType.Get) {
			changing = true;
		}
	}

	spawned_shine = noone;
	
	if (IS_BOARD && network_id == global.player_id) {
		if (!player.got_shine) {
			player.got_shine = true;
		} else {
			achieve_trophy(98);
		}
	}
	
	var pitch = (room != rBoardHyrule || global.board_light) ? 1 : 0.75;
	audio_play_sound(sndShineGet, 0, false, 1, 0, pitch);
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
		audio_play_sound(sndShineLose, 0, false);
	}
});

alarm_create(function() {
	focus_player = focus_player_by_id(network_id);
	spawned_shine = instance_create_layer(focus_player.x, focus_player.y, "Actors", objShine);
	spawned_shine.focus_player = focus_player;
	alarm_call(ShineChangeType.Get, 1);
});

alarm_create(11, function() {
	if (instance_exists(spawned_shine)) {
		instance_destroy(spawned_shine);
		spawned_shine = noone;
	}

	animation_state = 1;
	player_info.shines += amount;
	player_info.shines = clamp(player_info.shines, 0, 999);
	calculate_player_place();
	
	if (network_id == global.player_id && amount >= 3) {
		achieve_trophy(99);
	}
});