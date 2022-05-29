var player_gone = [];
var place = -1;

for (var i = 4; i >= 1; i--) {
	with (objPlayerBase) {
		if (lost) {
			continue;
		}
		
		var player_info = player_info_by_id(network_id);
		print(player_info.place);
		
		if (player_info.place == i) {
			array_push(player_gone, player_info.turn);
		}
	}
	
	if (array_length(player_gone) > 0) {
		place = i;
		break;
	}
}

if (place == 1) {
}

for (var i = 1; i <= global.player_max; i++) {
	var player = focus_player_by_turn(i);
	
	if (player.lost) {
		continue;
	}
	
	var c = instance_create_layer(player.x, -32, "Actors", objResultsCherry);
	
	switch (place) {
		case 4: c.sprite_index = sprResultsCherry4th; break;
		case 3: c.sprite_index = sprResultsCherry3rd; break;
		case 2: c.sprite_index = sprResultsCherry2nd; break;
	}
	
	c.image_xscale = 5 - place;
	c.image_yscale = 5 - place;
	c.place = place;
	c.down = array_contains(player_gone, i);
}
