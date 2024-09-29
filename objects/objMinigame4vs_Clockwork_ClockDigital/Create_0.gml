numbers = [];
number_digits = 4;
number_sections = 7;

for (var i = 0; i < number_digits; i++) {
	array_push(numbers, []);
	
	for (var j = 0; j < number_sections; j++) {
		array_push(numbers[i], true);
	}
}