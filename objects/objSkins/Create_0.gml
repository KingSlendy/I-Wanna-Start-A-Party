fade_alpha = 1;
fade_start = true;
back = false;
surf = noone;
timer = 0;
dir = 1;
buying = -1;

skin_selected = 0;
skin_target_selected = 0;
skin_x = 400;
skin_target_x = 400;

action_delay = 0;
network_actions = [];

for (var i = 0; i < array_length(global.skins); i++) {
	global.skins[i].shop_price = global.skins[i].price;
}

function sync_actions(action, network_id) {
	if (action_delay > 0) {
		return false;
	}
	
	if (array_length(network_actions) > 0) {
		var network_action = network_actions[0];
	
		if (network_action[0] == action && network_action[1] == network_id) {
			action_delay = get_frames(0.1);
			array_delete(network_actions, 0, 1);
			return true;
		}
	}
	
	var check_id = network_id;
	
	if (!IS_ONLINE || focus_player_by_id(check_id).ai) {
		check_id = 1;
	}
	
	var pressed = global.actions[$ action].pressed(check_id);
	
	if (pressed) {
		action_delay = get_frames(0.1);
		buffer_seek_begin();
		buffer_write_action(ClientTCP.PartyAction);
		buffer_write_data(buffer_string, action);
		buffer_write_data(buffer_u8, network_id);
		network_send_tcp_packet();
	}
	
	return pressed;
}
