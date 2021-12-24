arrow_separation = 25;

if (space.space_north != null) {
	var a = instance_create_layer(objPlayerBoard.x, objPlayerBoard.y - arrow_separation, "Actors", objArrow);
	a.image_angle = 90;
	a.space_next = space.space_north;
	arrows[0] = a;
}

if (space.space_east != null) {
	var a = instance_create_layer(objPlayerBoard.x + arrow_separation, objPlayerBoard.y, "Actors", objArrow);
	a.image_angle = 0;
	a.space_next = space.space_east;
	arrows[1] = a;
}

if (space.space_west != null) {
	var a = instance_create_layer(objPlayerBoard.x - arrow_separation, objPlayerBoard.y, "Actors", objArrow);
	a.image_angle = 180;
	a.space_next = space.space_west;
	arrows[2] = a;
}

if (space.space_south != null) {
	var a = instance_create_layer(objPlayerBoard.x, objPlayerBoard.y + arrow_separation, "Actors", objArrow);
	a.image_angle = 270;
	a.space_next = space.space_south;
	arrows[3] = a;
}

for (var i = 0; i < array_length(arrows); i++) {
	var arrow = arrows[i];
	
	if (arrow != null) {
		arrow.image_index = 0;
		arrow_selected = i;
		break;
	}
}