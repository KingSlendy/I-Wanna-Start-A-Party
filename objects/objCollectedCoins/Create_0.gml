if (instance_number(object_index) > 1) {
	with (object_index) {
		if (id != other.id) {
			instance_destroy();
		}
	}
}

depth = -9999;
y = -20;
yt = 20;
coins = global.collected_coins;
amount = 0;
current = 0;
scale = 1;
alarm[0] = get_frames(1);