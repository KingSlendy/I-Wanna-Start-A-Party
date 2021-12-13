arrow_separation = 40;

if (space.path_north != null) {
	var a = instance_create_layer(objPlayerBoard.x, objPlayerBoard.y - arrow_separation, "Actors", objArrow);
	a.image_angle = 90;
	paths.N = a;
}

if (space.path_east != null) {
	var a = instance_create_layer(objPlayerBoard.x + arrow_separation, objPlayerBoard.y, "Actors", objArrow);
	a.image_angle = 0;
	paths.E = a;
}

if (space.path_west != null) {
	var a = instance_create_layer(objPlayerBoard.x - arrow_separation, objPlayerBoard.y, "Actors", objArrow);
	a.image_angle = 180;
	paths.W = a;
}

if (space.path_south != null) {
	var a = instance_create_layer(objPlayerBoard.x, objPlayerBoard.y + arrow_separation, "Actors", objArrow);
	a.image_angle = 270;
	paths.S = a;
}