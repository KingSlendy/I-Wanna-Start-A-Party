image_speed = 0;
image_xscale = 0;
image_yscale = 0;
increase = true;
bonus = null;
dir_y_float = 0;
dir_angle_float = 90;

function go_up() {
	vspeed = -8;
	alarm_call(0, 2);
	
	if (global.player_id == 1) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.ResultsBonusShineGoUp);
		network_send_tcp_packet();
	}
}

function next_bonus() {
	with (objResults) {
		results_bonus();	
	}
			
	instance_destroy();
	
	if (global.player_id == 1) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.ResultsBonusShineNextBonus);
		network_send_tcp_packet();
	}
}

alarms_init(2);

alarm_create(function() {
	if (global.player_id == 1) {
		var players = bonus.max_players();

		for (var i = 0; i < array_length(players); i++) {
			change_shines(1, ShineChangeType.Spawn, players[i]);
		}

		alarm_call(1, 3);
	}
});

alarm_create(function() {
	if (global.player_id != 1) {
		return;
	}
	
	var players = bonus.max_players();
	var names = "";

	for (var i = 1; i <= global.player_max; i++) {
		if (!array_contains(players, i)) {
			continue;
		}
		
		names += "{COLOR,0000FF}" + focus_player_by_turn(i).network_name + "{COLOR,FFFFFF}, "
	}

	names = string_copy(names, 1, string_length(names) - 2);
	var text = "";

	switch (array_length(players)) {
		case 1: text = "Congratulations!"; break;
		case 2: text = "I applaud both of you!"; break;
		case 3: text = "Wow, three of you got it!\nI'm impressed!"; break;
		case 4: text = "What!? All of you managed to get it??\nYou're all so good!"
	}

	start_dialogue([
		new Message(string_interp("{0}!\n{1}", names, text),, function() {
			with (objResultsBonusShine) {
				next_bonus();
			}
		})
	]);
});