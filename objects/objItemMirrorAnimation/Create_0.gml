event_inherited();

space_shine = null;
space_current = {x: focus_player.x, y: focus_player.y};

state = 0;
scale = 0;
angle = 0;

if (room != rBoardPallet) {
	with (objSpaces) {
		if (image_index == SpaceType.Shine) {
			other.space_shine = id;
			break;
		}
	}
} else {
	var animation = id;
		
	with (objBoardPalletPokemon) {
		if (!has_shine()) {
			continue;
		}
			
		var space_record = infinity;
		
		with (objSpaces) {
			if (image_index != SpaceType.PathEvent) {
				continue;
			}
				
			var dist = point_distance(x + 16, y + 16, other.x, other.y);
						
			if (dist < space_record) {
				space_record = dist;
				animation.space_shine = id;
			}
		}

		break;
	}
}
	
space_shine = {x: space_shine.x + 16, y: space_shine.y + 16};

alarms_init(6);

alarm_create(function() {
	if (is_local_turn()) {
		with (focus_player) {
			board_jump();
		}
	}
	
	alarm_call(1, 0.3);
});

alarm_create(function() {
	if (is_local_turn()) {
		with (focus_player) {
			var diff_y = (jump_y - y);
			jump_y = other.space_shine.y;
			x = other.space_shine.x;
			y = other.space_shine.y - diff_y;
		}
	}
	
	alarm_call(2, 1);
});

alarm_create(function() {
	state = 1;
});

// Alarm 3
alarm_create(function() {
	audio_play_sound(sndItemMirrorAnimation_Start, 0, false);
	audio_play_sound(sndItemMirrorAnimation_NoiseLoop, 0, true);
	
	var cam_x = camera_get_view_x(view_camera[0]);
	var cam_y = camera_get_view_y(view_camera[0]);
	
	// Black screen and particles at the sides
	instance_create_depth(cam_x, cam_y, depth - 1, objItemMirrorAnimation_EffectCreateParticles);
	
	alarm_call(4, 2);
});

// Alarm 4
alarm_create(function() {
	audio_play_sound(sndItemMirrorAnimation_Enter, 0, false);
	
	var cam_center_x = camera_get_view_x(view_camera[0]) + 400;
	var cam_center_y = camera_get_view_y(view_camera[0]) + 304;
	
	// Particle effect
	var bright_effect = instance_create_depth(cam_center_x, cam_center_y, depth - 2, objItemMirrorAnimation_NewEffect);
		bright_effect . duration = floor(50 * 2.5);
		
	alarm_call(5, 2.5);
});

// Alarm 5
alarm_create(function() {
	instance_create_depth(0, 0, depth - 1, objItemMirrorAnimation_EffectScreenFadeOut);
	instance_destroy(objItemMirrorAnimation_EffectCreateParticles);
	instance_destroy(objItemMirrorAnimation_NewEffect);
	
	audio_play_sound(sndItemMirrorAnimation_Teleported, 0, false);
	audio_stop_sound(sndItemMirrorAnimation_NoiseLoop);
});