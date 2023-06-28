global.game_started = true;
global.game_id = (!IS_ONLINE) ? "Offline" : "Online";
disable_board();
minigame_info_reset();
trial_info_reset();
fade_alpha = 1;
fade_start = true;
state = -1;

function ModeButton(label, sprite, scale, offset, room_to, selectable = true) constructor {
	self.w = 230;
	self.h = 170;
	self.room_to = room_to;
	self.selectable = selectable;
	var surf = surface_create(w, h);
	surface_set_target(surf);
	draw_sprite_stretched_ext(sprButtonSlice, 0, 0, 0, w, h, (self.selectable) ? c_white : c_gray, 1);
	language_set_font(fntFilesButtons);
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);
	draw_text_color_outline(w / 2, h - 5, label, c_orange, c_orange, c_yellow, c_yellow, 1, c_black);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	if (sprite != null) {
		draw_sprite_ext(sprite, (sprite == sprTrophyCups), w / 2, offset, scale, scale, 0, c_white, 1);
	}
	
	surface_reset_target();
	self.sprite = sprite_create_from_surface(surf, 0, 0, w, h, false, false, w / 2, h / 2);
	surface_free(surf);
	
	self.pos = [400, 254];
	self.highlight = 0.7;
	
	static draw = function(alpha) {
		draw_sprite_ext(self.sprite, 0, self.pos[0], self.pos[1], self.highlight, self.highlight, 0, c_white, self.highlight - alpha);
	}
	
	static check = function(condition_highlight) {
		self.highlight = lerp(self.highlight, (!condition_highlight) ? 0.7 : 1, 0.3);
	}
}

mode_buttons = [
	new ModeButton(language_get_text("MODES_PARTY"), sprModesParty, 0.3, 65, rParty),
	new ModeButton(language_get_text("MODES_MINIGAMES"), sprModesMinigames, 0.3, 65, rMinigames),
	new ModeButton(language_get_text("MODES_TRIALS"), sprModesTrials, 0.3, 65, rTrials, !IS_ONLINE),
	new ModeButton(language_get_text("MODES_STORE"), sprModesStore, 0.3, 65, rStore, !IS_ONLINE),
	new ModeButton(language_get_text("MODES_TROPHIES"), sprModesTrophies, 0.3, 65, rTrophies, !IS_ONLINE)
];

mode_texts = [
	language_get_text("MODES_PARTY_DESCRIPTION"),
	language_get_text("MODES_MINIGAMES_DESCRIPTION"),
	language_get_text("MODES_TRIALS_DESCRIPTION"),
	language_get_text("MODES_STORE_DESCRIPTION"),
	language_get_text("MODES_TROPHIES_DESCRIPTION")
];

mode_prev = global.mode_selected;

if (mode_prev == -1) {
	mode_prev = 0;
}

mode_selected = -1;
mode_target_selected = mode_selected;
mode_x = 0;
mode_target_x = mode_x;

with (objPlayerBase) {
	draw = false;
	lost = false;
	skin = null;
	change_to_object(objPlayerBase);
}

var check = array_get_index(global.all_ai_actions, null);
	
if (check != -1) {
	array_delete(global.all_ai_actions, check, 1);
}

controls_text = new Text(fntControls);
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

function back_to_files() {
	state = 0;
	fade_start = true;
	music_fade();
	audio_play_sound(global.sound_cursor_back, 0, false);
}

var names = variable_struct_get_names(global.board_games);

for (var i = 0; i < array_length(names); i++) {
	var name = names[i];
	
	if (name == "Offline" || name == "Online") {
		continue;
	}
	
	variable_struct_remove(global.board_games, names[i]);
}

save_file();