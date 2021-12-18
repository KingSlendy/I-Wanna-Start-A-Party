function array_shuffle(array) {
	for (var i = 0; i < array_length(array); i++) {
		var rnd = irandom(array_length(array) - 1);
		var temp = array[rnd];
		array[@ rnd] = array[i];
		array[@ i] = temp;
	}
}