focus_player = focused_player();
network_id = focus_player.network_id;

if (is_local_turn()) {
	prev_player_positions = array_create(global.player_max, null);

	for (var i = 1; i <= global.player_max; i++) {
		var player = focus_player_by_turn(i);
		prev_player_positions[i - 1] = {x: player.x, y: player.y};
	}

	with (focus_player) {
		with (objPlayerReference) {
			if (reference == 1) {
				other.x = x;
				other.y = y;
			}
		}
	}
}

current_flag = 0;
current_player = focus_player;
player_ids = array_create(2, null);

function begin_chance_time() {
	if (is_local_turn()) {
		start_dialogue([
			"Welcome to chance time!\nThe exciting event that could change the board around!",
			new Message("Jump and hit the blocks to decide what players are gonna be involved!",, objChanceTime.spawn_chance_time_box)
		]);
	}
}

function spawn_chance_time_box() {
	var b = null;
	
	if (current_flag != 2) {
		b = instance_create_layer(focus_player.x, focus_player.y - 37, "Actors", objChanceTimeBox);
		b.flag = current_flag;
	}
	
	if (is_local_turn()) {
		switch (current_flag) {
			case 0:
				b.sprites = all_player_sprites();
				break;
			
			case 1:
				b.sprites = all_player_sprites();
				var other_sprite = objChanceTimeChoice.sprite;
				var del_index = array_index(b.sprites, other_sprite);
				array_delete(b.sprites, del_index, 1);
				break;
				
			case 2:
				var names = all_player_names();
				var players = [names[player_ids[0]], names[player_ids[1]]];
			
				start_dialogue([
					"It seems the chosen players would be {COLOR,0000FF}" + players[0] +"{COLOR,FFFFFF} and {COLOR,0000FF}" + players[1] + "{COLOR,FFFFFF}!",
					new Message("Now I wonder what the exchange will be...",, function() {
						with (objChanceTime) {
							current_flag++;
							spawn_chance_time_box();
						}
					})
				]);
				break;
				
			case 3:
				b.sprites = [];
				b.indexes = true;
				break;
		}

		if (b != null) {
			buffer_seek_begin();
			buffer_write_action(ClientTCP.SpawnChanceTimeBox);
			buffer_write_data(buffer_u32, random_get_seed());
			buffer_write_array(buffer_u32, b.sprites);
			network_send_tcp_packet();
		}
	}
	
	return b;
}

function end_chance_time() {
	
}

switch_camera_target(focus_player.x, focus_player.y).final_action = begin_chance_time;