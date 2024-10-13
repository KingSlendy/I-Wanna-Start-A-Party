var doors = [];

for (var r = 0; r < 6; r++) {
	array_push(doors, []);
	
	for (var c = 0; c < 8; c++) {
		with (objMinigame4vs_Mansion_Door) {
			if (row == r && col == c) {
				array_push(doors[r], id);
				break;
			}
		}
	}
}

for (var r = 0; r < 5; r++) {
	var door_row = doors[r];
	
	while (array_length(door_row) > 1) {
		array_shuffle_ext(door_row);
		var door1 = door_row[0];
		var door2 = door_row[1];
		array_delete(door_row, 0, 2);
		door1.link = door2;
		door2.link = door1;
	}
	
	array_shuffle_ext(door_row);
	var door1 = door_row[0];
	var next_door_row = doors[r + 1];
	array_shuffle_ext(next_door_row);
	var door2 = next_door_row[0];
	door1.link = door2;
	door2.link = door1;
	array_delete(door_row, 0, 1);
	array_delete(next_door_row, 0, 1);
}

event_inherited();

with (objCamera) {
	//target_follow = focus_player_by_id();
	boundaries = true;
	camera_correct_position(id);
}