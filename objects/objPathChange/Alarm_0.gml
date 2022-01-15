paths = (BOARD_NORMAL) ? space.space_directions_normal : space.space_directions_reverse;
arrow_separation = 25;
var separations = [[0, -1], [1, 0], [-1, 0], [0, 1]];
var angles = [90, 0, 180, 270];

for (var i = 0; i < 4; i++) {
	if (paths[i] != null) {
		var separation = separations[i];
		var sep_x = arrow_separation * separation[0];
		var sep_y = arrow_separation * separation[1];
		var focus_player = focused_player();
		var a = instance_create_layer(focus_player.x + sep_x, focus_player.y + sep_y, "Actors", objArrow);
		a.image_angle = angles[i];
		
		if (BOARD_NORMAL) {
			a.space_next = paths[i];
		} else {
			a.space_previous = paths[i];
		}
		
		arrows[i] = a;
	}
}

for (var i = 0; i < array_length(arrows); i++) {
	var arrow = arrows[i];
	
	if (arrow != null) {
		arrow.image_index = 0;
		arrow_selected = i;
		break;
	}
}