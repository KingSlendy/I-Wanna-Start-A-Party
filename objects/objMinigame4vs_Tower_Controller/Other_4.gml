var current = 0;
var start_x = 32;

repeat (4) {
	var ceiling = 0;
	var total = 100;
	var start_y = 448;
	var prev_opening = -1;

	repeat (total) {
		for (var i = 0; i < 4; i++) {
			var b = instance_create_layer(start_x - 32, start_y + 32 * i, "Collisions", objBlock);
			b.visible = true;
			b.sprite_index = sprMinigame4vs_Tower_Block2;
			
			if (current == 3) {
				var b = instance_create_layer(start_x + 32 * 5, start_y + 32 * i, "Collisions", objBlock);
				b.visible = true;
				b.sprite_index = sprMinigame4vs_Tower_Block2;
			}
		}
		
		var opening = -1;
		
		if (ceiling < 99) {
			if (prev_opening == -1) {
				var opening = irandom(4);
			} else {
				var opening = clamp(prev_opening + choose(-1, 1), 0, 4);
			}
		}
		
		for (var i = 0; i < 5; i++) {
			if (i == opening) {
				continue;
			}
			
			var b = instance_create_layer(start_x + 32 * i, start_y, "Collisions", objBlock);
		    b.visible = true;
		    b.sprite_index = sprMinigame4vs_Tower_Block;
			
			instance_create_layer(start_x + 32 * i, start_y + 32, "Actors", objMinigame4vs_Tower_Spike);
		}
		
		prev_opening = opening;
		start_y -= 32 * 4;
		ceiling++;
	}
	
	start_x += 32 * 6;
	current++;
}

event_inherited();
objCameraSplit4.lock_x = true;
