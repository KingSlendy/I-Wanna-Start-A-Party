if (objMinigameController.info.is_finished || !objMinigame4vs_Clockwork_ClockAnalog.check_target_time || !is_player_local(player.network_id)) {
	exit;
}

var time;

//This stores the time the digital clock needs to be set to, both in 24 hour or AM/PM formats.
with (objMinigame4vs_Clockwork_ClockAnalog) {
	time = [
		[target_hour div 10, (target_hour + 12) div 10],
		[target_hour mod 10, (target_hour + 12) mod 10],
		[target_minutes div 10, target_minutes div 10],
		[target_minutes mod 10, target_minutes mod 10]
	];
}

var check_time = function(time, format) {
	for (var i = 0; i < number_digits; i++) {
		var section = "";
	
		for (var j = 0; j < number_sections; j++) {
			section += (numbers[i][j]) ? string(j) : "";
		}
	
		if (section != objMinigame4vs_Clockwork_ClockAnalog.sections_makes_digits[$ time[i][format]]) {
			return false;
		}
	}
	
	return true;
}

//Checks AM/PM format.
var correct_time = check_time(time, 0);

//Checks 24 format.
if (!correct_time) {
	correct_time = check_time(time, 1);
}

if (correct_time) {
	clock_digital_correct_time();
}