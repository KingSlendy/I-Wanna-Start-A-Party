if (image_speed == 1) {
	if (floor(image_index) >= image_number - 1) {
		image_index = image_number - 1;
	}
	
	if (!place_meeting(x, y, objPlayerBase)) {
		image_speed = -1;
	}
} else if (image_speed == -1 && floor(image_index) <= 0) {
	image_speed = 0;
	image_index = 0;
	audio_play_sound(sndMinigame4vs_Mansion_CloseDoor, 0, false);
}

with (objPlayerBase) {
	if (!is_player_local(network_id) || !frozen || door != other.id) {
		continue;
	}
	
	if (fade == -1) {
		if (other.image_index >= other.image_number - 1) {
			fade = 0;
		}
	} else if (fade == 0) {
		image_alpha -= 0.04;
		
		if (image_alpha <= 0) {
			x = other.link.x + 64 + 1;
			y = other.link.y + 96 - 9;
			
			with (other.link) {
				open_door();
			}
				
			door = other.link;
			fade = 1;
			
			if (network_id == global.player_id && other.y == other.link.y) {
				objMinigameController.trophy_doors = false;
			}
		}
	} else if (fade == 1) {
		image_alpha += 0.04;
					
		if (image_alpha >= 1) {
			door = null;
			fade = -1;
			
			if (!objMinigameController.info.is_finished) {
				frozen = false;
			}
			
			alarm_stop(0);
		}
	}
}
