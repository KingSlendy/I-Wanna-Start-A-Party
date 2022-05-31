fade_start = true;
fade_alpha = 1;
surf = noone;

menu_page = 0;
menu_sep = 1000;
menu_x = 0;

skin_row = 0;
skin_col = 0;
skins = [];
skin_show = 4;
skin_y = 118;
skin_target_y = skin_y;
skin_target_row = skin_row;

for (var i = 0; i < array_length(global.skin_sprites); i++) {
	var r = i % skin_show;
	var c = floor(i / skin_show);
	
	if (r == 0) {
		array_push(skins, []);
	}
	
	array_push(skins[c], i);
}

skin_player = 0;
skin_selected = array_create(global.player_max, null);

board_selected = 0;
board_target_selected = 0;
board_x = 0;
board_target_x = 0;
board_rooms = [rBoardIsland, rBoardHotland];
finish = false;

with (objPlayerBase) {
	change_to_object(objPlayerParty);
}

with (objPlayerBase) {
	image_xscale = 2;
	image_yscale = 2;
	x = 230 + 110 * (network_id - 1);
	y = 500;
}

var check = array_index(global.all_ai_actions, null);
	
if (check != -1) {
	array_delete(global.all_ai_actions, check, 1);
}
	
array_insert(global.all_ai_actions, global.player_id - 1, null);

network_actions = [];

function sync_actions(action, network_id) {
	if (array_length(network_actions) > 0) {
		var network_action = network_actions[0];
	
		if (network_action[0] == action && network_action[1] == network_id) {
			array_delete(network_actions, 0, 1);
			return true;
		}
	}
	
	var check_id = network_id;
	
	if (!instance_exists(objNetworkClient) || focus_player_by_id(check_id).ai) {
		check_id = 1;
	}
	
	var pressed = global.actions[$ action].pressed(check_id);
	
	if (pressed) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.PartyAction);
		buffer_write_data(buffer_string, action);
		buffer_write_data(buffer_u8, network_id);
		network_send_tcp_packet();
	}
	
	return pressed;
}
