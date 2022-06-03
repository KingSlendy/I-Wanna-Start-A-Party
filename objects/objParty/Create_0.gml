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
skin_w = 118;
skin_h = 120;
skin_y = skin_h;
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
board_w = 352;
board_h = 224;
board_img_w = 264;
board_img_h = 193;
board_x = 0;
board_target_x = 0;
board_rooms = [rBoardIsland, rBoardHotland, rBoardBabaIsBoard];
finish = false;
save_present = false;
save_sprite = noone;
save_selected = 0;

if (save_present) {
	for (var i = 1; i <= global.player_max; i++) {
		spawn_player_info(i, i);
		var player_info = focus_info_by_turn(i);
		player_info.target_draw_x = 0;
		player_info.draw_x = player_info.target_draw_x;
		player_info.target_draw_y = player_info.draw_h * (i - 1);
		player_info.draw_y = player_info.target_draw_y;
	}
	
	var surf_board = surface_create(board_w, board_h);
	surface_set_target(surf_board);
	draw_sprite_stretched(sprPartyBoardMark, 1, 0, 0, board_w, board_h);
	gpu_set_colorwriteenable(true, true, true, false);
	draw_sprite_stretched(sprPartyBoardTest, 0, 40, 15, board_img_w, board_img_h);
	gpu_set_colorwriteenable(true, true, true, true);
	draw_sprite_stretched(sprPartyBoardMark, 0, 0, 0, board_w, board_h);
	surface_reset_target();
	save_sprite = sprite_create_from_surface(surf_board, 0, 0, board_w, board_h, false, false, 0, 0);
	surface_free(surf_board);
	menu_page = -1;
}

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

function start_board() {
	finish = true;
	fade_start = true;
	audio_sound_gain(global.music_current, 0, 1000);
	audio_play_sound(sndBoardEnter, 0, false);
}

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
