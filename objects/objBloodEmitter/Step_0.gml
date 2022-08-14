repeat (20) {
    var b = instance_create_layer(x, y, "Actors", objBlood);
	b.direction = dir;
	b.speed = max(dir % 3, 1);
	dir = (dir + 9.3284623846 + 360) % 360;
}