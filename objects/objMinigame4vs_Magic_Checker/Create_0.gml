depth = -999;

minigame_times_up();
objPlayerBase.frozen = true;

view_visible[6] = true;
view_wport[6] = 352;
view_hport[6] = 160;
var camera = view_camera[6];
camera_set_view_size(camera, 352, 160);
camera_set_view_pos(camera, 1600 + 192 + 32, 128 + 16);
surf = noone;
view_alpha = 0;
view_start = false;
current_order = 0;

alarms_init(2);

alarm_create(function() {
	view_start = true;
});

alarm_create(function() {
	if (current_order == 10) {
		if (objMinigameController.info.player_scores[global.player_id - 1].points == 10) {
			achieve_trophy(7);
		}
	
		var empty = true;
	
		with (objMinigame4vs_Magic_Holder) {
			if (network_id == global.player_id && place_meeting(x, y, objMinigame4vs_Magic_Items)) {
				empty = false;
				break;
			}
		}
	
		if (empty) {
			achieve_trophy(8);
		}
	
		minigame_finish();
		return;
	}

	with (objMinigame4vs_Magic_Holder) {
		if (order == other.current_order) {
			var item = instance_place(x, y, objMinigame4vs_Magic_Items);
		
			if (item != noone && item.order == order) {
				item.state = 0;
			
				if (item.player_turn != 0) {
					minigame4vs_points(item.player.network_id, 1);
				}
			}
		}
	}

	current_order++;
	audio_play_sound(sndMinigame4vs_Magic_Correct, 0, false);
	alarm_call(1, 0.8);
});

alarm_call(0, 2);