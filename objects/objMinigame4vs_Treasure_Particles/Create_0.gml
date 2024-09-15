function create_star(alarm_num) {
	with (instance_create_layer(irandom(room_width) + irandom(512), room_height + 256, "Actors", objMinigame4vs_Treasure_Star)) {
		depth = layer_get_depth("Tiles") + 1;
		var sizing = irandom(100);
	
		if (sizing > 70) {
			image_xscale = 1;
		} else if (sizing > 20) {
			image_xscale = 2;
		} else if (sizing > 8) {
			image_xscale = 4;
		} else if (sizing > 2) {
			image_xscale = 6;
		} else {
			image_xscale = 8;
		}
		
		image_yscale = image_xscale;
	}
	
	alarm[alarm_num] = random(10) + 5;
}

alarm[0] = irandom(5);
alarm[1] = irandom(5);
alarm[2] = 5 + irandom(5);
alarm[3] = 5 + irandom(5);
alarm[4] = 10;