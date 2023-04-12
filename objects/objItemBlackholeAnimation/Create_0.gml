event_inherited();
player1 = focus_player_by_turn();
player2 = focus_player_by_turn(global.choice_selected + 1);
current_player = player2;

state = -2;
scale = 0;
angle = 0;
stealed = false;

steal_min = min(irandom_range(8, 12), player_info_by_id(player2.network_id).coins);
steal_xoff = 0;
steal_yoff = 0;

part_system = part_system_create();
part_system_depth(part_system, -10000);

part_type = part_type_create();
part_type_shape(part_type, pt_shape_smoke);
part_type_size(part_type, 0.1, 0.3, 0, 0);
part_type_alpha3(part_type, 0, 1, 0);
part_type_color1(part_type, c_ltgray);
part_type_speed(part_type, 2, 2, 0, 0);
part_type_life(part_type, 30, 30);

controls_text = new Text(fntControls);

function start_blackhole_steal() {
	state = 0;
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.StartBlackholeSteal);
		network_send_tcp_packet();
	}
}

function end_blackhole_steal() {
	state = 1;
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.EndBlackholeSteal);
		buffer_write_data(buffer_u8, steal_count);
		network_send_tcp_packet();
	}
}

alarms_init(4);

alarm_create(function() {
	turn_previous = global.player_turn;
	global.player_turn = global.choice_selected + 1;
	player_info = player_info_by_turn();
	
	switch (additional) {
		case 0: steal_count = clamp(player_info.coins, 0, 20); break;
		case 1: steal_count = 1; break;
	}

	switch_camera_target(current_player.x, current_player.y).final_action = function() {
		if (is_local_turn()) {
			var text;
	
			switch (additional) {
				case 0:
					text = "The blackhole is gonna steal your Coins!\nMash as fast as you can to reduce the amount!";
					break;
			
				case 1:
					text = "Oh no!\nThe blackhole is gonna steal a Shine!";
					break;
			}
	
			start_dialogue([
				new Message(text,, start_blackhole_steal)
			]);
		}
	}
});

alarm_create(function() {
	var hole_x = current_player.x;
	var hole_y = current_player.y - 50;
	var spawn_angle = irandom(359);
	var spawn_x = hole_x + 70 * dcos(spawn_angle);
	var spawn_y = hole_y + 70 * dsin(spawn_angle);
	var spawn_dir = point_direction(spawn_x, spawn_y, hole_x, hole_y);
	part_type_direction(part_type, spawn_dir, spawn_dir, 0, 0);
	part_particles_create(part_system, spawn_x, spawn_y, part_type, 1);

	alarm_frames(1, 4);
});

alarm_create(function() {
	steal_count = ceil(steal_count);
	steal_xoff = 0;
	steal_yoff = 0;
	state = -2;

	switch (additional) {
		case 0:
			if (!stealed) {
				var c = change_coins(steal_count * -1, CoinChangeType.Lose, global.choice_selected + 1);
				bonus_shine_by_id(BonusShines.MostSteals).increase_score(global.player_turn, steal_count);
			} else {
				var c = change_coins(steal_count * -1, CoinChangeType.Gain);
			}
		
			c.final_action = end_blackhole_steal;
			break;
		
		case 1:
			if (!stealed) {
				var s = change_shines(steal_count * -1, ShineChangeType.Lose, global.choice_selected + 1);
				bonus_shine_by_id(BonusShines.MostSteals).increase_score(global.player_turn, 20);
			} else {
				var s = change_shines(steal_count * -1, ShineChangeType.Spawn);
			}
		
			s.final_action = end_blackhole_steal;
			break;
	}
});

alarm_create(function() {
	current_player = player1;
		
	switch_camera_target(current_player.x, current_player.y).final_action = function() {
		global.player_turn = turn_previous;
		state = 0;
	}
});

alarm_frames(0, 1);