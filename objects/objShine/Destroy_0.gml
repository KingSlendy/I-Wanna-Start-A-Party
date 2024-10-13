if (room == rBoardNsanity) {
	exit;
}

with (shine_nearest_vessel()) {
	if (room != rBoardPallet) {
		image_index = SpaceType.Blue;
		space_was_shine = true;
	} else {
		pokemon_was_shine = true;
	}
}