for (var i = 0; i < 2; i++) {
	var f = instance_create_layer(fruit_positions[i][current], 256, "Actors", objMinigame2vs2_Fruits_Fruit);
	var type = fruit_types[i][current++];
	f.type = type;

	switch (type) {
		case -2:
			with (f) {
				instance_change(objMinigame2vs2_Fruits_Gordo, false);
				vspeed = 5;
			}
			break;
	
		case 0:
			f.vspeed = 2;
			break;
		
		case 1:
			f.image_xscale = 0.5;
			f.image_yscale = 0.5;
			f.vspeed = 4;
			break;
		
		case 2:
			f.image_xscale = 0.25;
			f.image_yscale = 0.25;
			f.vspeed = 6;
			break;
	}
}

alarm[4] = get_frames(0.5);
