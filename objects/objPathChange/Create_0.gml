focus_player = focused_player();
network_id = focus_player.network_id;
space = null;
arrows = array_create(4, null);
actions = [global.actions.up, global.actions.right, global.actions.left, global.actions.down];
arrow_selected = -1;

alarms_init(1);

alarm_create(function() {
	paths = (BOARD_NORMAL) ? space.space_directions_normal : space.space_directions_reverse;
	arrow_separation = 25;
	var separations = [[0, -1], [1, 0], [-1, 0], [0, 1]];
	var angles = [90, 0, 180, 270];

	for (var i = 0; i < array_length(paths); i++) {
		if (paths[i] == null) {
			continue;
		}
	
		var separation = separations[i];
		var sep_x = arrow_separation * separation[0];
		var sep_y = arrow_separation * separation[1];
		var a = instance_create_layer(focus_player.x + sep_x, focus_player.y + sep_y, "Actors", objArrow);
		a.image_angle = angles[i];
		
		if (BOARD_NORMAL) {
			a.space_next = paths[i];
		} else {
			a.space_previous = paths[i];
		}
		
		arrows[i] = a;
	}

	board_path_finding();

	for (var i = 0; i < array_length(paths); i++) {
		if (paths[i] == null) {
			continue;
		}
	
		if ((array_length(global.path_spaces) == 0 || paths[i] == global.path_spaces[1])) {
			var arrow = arrows[i];
			arrow.image_index = 0;
			arrow_selected = i;
			break;
		}
	}
});

alarm_instant(0);