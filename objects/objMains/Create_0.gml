fade_start = true;
fade_alpha = 1;
surf = noone;
controls_text = new Text(fntDialogue);

menu_page = 0;
menu_sep = 1000;
menu_x = 0;
draw_x = 160;
draw_y = 32;
draw_w = 32 * 15;
draw_h = 32 * 15 - 112;

skin_row = 0;
skin_col = 0;
skins = ds_list_create();
skin_show = 4;
skin_w = 118;
skin_h = 120;
skin_y = skin_h;
skin_target_y = skin_y;
skin_target_row = skin_row;
var skin_total = array_length(global.skins);

for (var i = 0; i < skin_total; i++) {
	var r = i % skin_show;
	var c = floor(i / skin_show);
	
	if (r == 0) {
		ds_list_add(skins, ds_list_create());
		ds_list_mark_as_list(skins, c);
	}
	
	ds_list_add(skins[| c], i);
}

ds_list_add(skins, ds_list_create());
ds_list_mark_as_list(skins, floor(skin_total / skin_show));
ds_list_add(skins[| floor(skin_total / skin_show)], noone);

skin_player = 0;
prev_skin_player = skin_player;
skin_selected = array_create(global.player_max, null);

global.max_board_turns = 20;
global.give_bonus_shines = true;

board_selected = 0;
board_target_selected = 0;
board_w = 352;
board_h = 224;
board_img_w = 264;
board_img_h = 193;
board_x = 0;
board_target_x = 0;
board_options_selected = 0;
board_options_y = 0;
board_options_w = 440;
board_options_h = board_h + 32;
state = -1;
save_present = (room == rParty && array_length(global.player_game_ids) > 0);
save_sprite = noone;
save_board_turn = 0;
save_max_turns = 0;
save_selected = 0;

if (save_present && room == rParty) {
	try {
		board = global.board_games[$ global.game_id];
		board_selected = board.saved_board.saved_board;
		board_target_selected = board_selected;
		save_board_turn = board.saved_board.saved_board_turn;
		save_max_turns = board.saved_board.saved_max_turns;
		save_give_bonus_shines = board.saved_board.saved_give_bonus_shines;
	
		var surf_board = surface_create(board_w, board_h);
		surface_set_target(surf_board);
		draw_sprite_stretched(sprPartyBoardMark, 1, 0, 0, board_w, board_h);
		gpu_set_colorwriteenable(true, true, true, false);
		var pic_x = 44;
		var pic_y = 15;
		draw_sprite_stretched(sprPartyBoardPictures, board_selected + 1, pic_x, pic_y, board_img_w, board_img_h);
		draw_sprite_ext(sprPartyBoardLogos, board_selected + 1, pic_x + board_img_w / 2, pic_y + board_img_h / 2, 0.75, 0.75, 0, c_white, 1);
		gpu_set_colorwriteenable(true, true, true, true);
		draw_sprite_stretched(sprPartyBoardMark, 0, 0, 0, board_w, board_h);
		surface_reset_target();
		save_sprite = sprite_create_from_surface(surf_board, 0, 0, board_w, board_h, false, false, 0, 0);
		surface_free(surf_board);
		menu_page = -1;
	
		for (var i = 1; i <= global.player_max; i++) {
			var saved_player = board.saved_players[global.player_game_ids[i - 1] - 1];
			spawn_player_info(i, saved_player.saved_turn);
			var player_info = focus_info_by_id(i);
			player_info.player_idle_image = asset_get_index(saved_player.saved_skin);
			player_info.player_info.shines = saved_player.saved_shines;
			player_info.player_info.coins = saved_player.saved_coins;
				
			for (var j = 0; j < array_length(player_info.player_info.items); j++) {
				var item = saved_player.saved_items[j];
					
				if (item != -1) {
					player_info.player_info.items[j] = global.board_items[item];
				} else {
					player_info.player_info.items[j] = null;
				}
			}
		
			player_info.player_info.pokemon = saved_player.saved_pokemon;
				
			player_info.target_draw_x = 0;
			player_info.draw_x = player_info.target_draw_x;
			player_info.target_draw_y = player_info.draw_h * (player_info.player_info.turn - 1);
			player_info.draw_y = player_info.target_draw_y;
		}
	
		calculate_player_place();
	} catch (_) {
		save_present = false;
		menu_page = 0;
		board_selected = 0;
		board_target_selected = 0;
		instance_destroy(objPlayerInfo);
		show_message("An error occurred while trying to load the saved Party and it has been ignored.");
	}
}

minigames_show_x = 0;
minigames_show_y = 0;
minigames_target_show_x = 0;
minigames_target_show_y = 0;
minigames_row_selected = 0;
minigames_col_selected = 0;
minigames_target_row_selected = 0;
minigames_target_col_selected = 0;
minigame_selected = null;
minigame_colors = [
	[1, 2, 3, 4],
	[1],
	[1, 2],
];

if (room == rMinigames) {
	var info = global.minigame_info;

	if (info.is_minigames) {
		menu_page = 1;
		var types = minigame_types();
		minigames_row_selected = array_index(types, info.type);
		minigames_target_row_selected = minigames_row_selected;
		minigames_col_selected = array_index(global.minigames[$ types[minigames_row_selected]], info.reference);
		minigames_target_col_selected = minigames_col_selected;
		minigame_info_reset();
	}
}

trials_show_x = 0;
trials_target_show_x = 0;
trials_show_y = 0;
trials_target_show_y = 0;
trials_selected = 0;
trials_target_selected = 0;
trials_minigame_selected = 0;
trials_minigame_target_selected = 0;

if (room == rTrials) {
	var info = global.minigame_info;
	
	if (info.is_trials) {
		menu_page = 1;
		trials_selected = global.trial_info.reference.index;
		trials_target_selected = trials_selected;
		minigame_info_reset();
		trial_info_reset();
	}
}

with (objPlayerBase) {
	change_to_object(objPlayerParty);
}

with (objPlayerBase) {
	draw = true;
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
	state = 0;
	fade_start = true;
	music_fade();
	audio_play_sound(sndBoardEnter, 0, false);
}

action_delay = 0;
network_actions = [];

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
		buffer_write_action(ClientTCP.ModesAction);
		buffer_write_data(buffer_string, action);
		buffer_write_data(buffer_u8, network_id);
		network_send_tcp_packet();
	}
	
	return pressed;
}