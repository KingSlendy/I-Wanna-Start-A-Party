next_seed_inline();
var start_y = infinity;

with (objMinigame4vs_Tower_Block) {
	start_y = min(start_y, y);
}

start_y -= 32;

for (var i = 0; i < global.player_max; i++) {
	var can_crack = (irandom(4) == 0);
	var created_crack = false;
	var start_x = 32 + (32 * 6) * i;

	for (var j = 0; j < 4; j++) {
		instance_create_layer(start_x - 32, start_y - 32 * j, "Collisions", objMinigame4vs_Tower_Block2);
			
		if (i == 3) {
			instance_create_layer(start_x + 32 * 5, start_y - 32 * j, "Collisions", objMinigame4vs_Tower_Block2);
		}
	}
		
	var opening = -1;
		
	if (prev_openings[i] == -1) {
		var opening = irandom(4);
	} else {
		var opening = clamp(prev_openings[i] + choose(-1, 1), 0, 4);
	}
		
	for (var j = 0; j < 5; j++) {
		if (j == opening) {
			continue;
		}
			
		instance_create_layer(start_x + 32 * j, start_y, "Collisions", objMinigame4vs_Tower_Block);
		instance_create_layer(start_x + 32 * j, start_y + 32, "Actors", objMinigame4vs_Tower_Spike);
		
		if (j < 4 && !can_crack && !created_crack && irandom(4) == 0) {
			instance_create_layer(start_x + 32 * (j - 1), start_y - 32 * 4, "Cracks", objMinigame4vs_Tower_Crack);
			created_crack = true;
		}
	}
		
	prev_openings[i] = opening;
}

set_spd(scene_spd);
alarm[4] = 50 - clamp(scene_spd * 4.15, 0, 38);
