for (var i = 0; i < array_length(pictures); i++) {
	if (sprite_exists(pictures[i])) {
		sprite_delete(pictures[i]);
	}
}

alarms_destroy();