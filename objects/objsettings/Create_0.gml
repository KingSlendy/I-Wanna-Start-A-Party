fade_start = true;
fade_alpha = 1;
back = false;

function Section(name, text, options) constructor {
	self.name = name;
	self.text = text;
	self.options = options;
	self.selected = 0;
	self.in_option = -1;
}

function Option(label, text, check_option, draw_option) constructor {
	self.label = label;
	self.text = text;
	self.check_option = method(self, check_option);
	self.draw_option = method(self, draw_option);
	self.highlight = 0.5;
	self.changing = false;
	
	language_set_font(fntFilesButtons);
	//self.label_width = string_width(self.label);
	//self.label_height = string_height(self.label);
	self.draw_label = function(x, y, condition, in_option) {
		language_set_font(fntFilesButtons);
		self.highlight = lerp(self.highlight, (!condition) ? 0.5 : 1, 0.3);
		var color1 = (!in_option) ? c_gray : c_green;
		var color2 = (!in_option) ? c_white : c_lime;
		draw_text_transformed_color_outline(x, y, self.text, self.highlight, self.highlight, 0, color1, color1, color2, color2, self.highlight * draw_get_alpha(), c_black);
	}
}

var volume_check = function() {
	var scroll_held = (global.actions.right.held() - global.actions.left.held());
	var scroll_pressed = (global.actions.right.pressed() - global.actions.left.pressed());
			
	if ((scroll_held != 0 && objSettings.volume_delay == 25) || scroll_pressed != 0) {
		switch (self.label) {
			case "MASTER": global.master_volume = clamp(global.master_volume + 0.01 * scroll_held, 0, 1); break;
			case "BGM": global.bgm_volume = clamp(global.bgm_volume + 0.01 * scroll_held, 0, 1); break;
			case "SFX": global.sfx_volume = clamp(global.sfx_volume + 0.01 * scroll_held, 0, 1); break;
		}
		
		if (room == rSettings) {
			apply_volume();
		}
	}
	
	if (scroll_held != 0) {
		objSettings.volume_delay = min(++objSettings.volume_delay, 25);
	}
	
	if (scroll_held == 0 && scroll_pressed == 0) {
		objSettings.volume_delay = 0;
	}
}

var volume_draw = function(x, y) {
	switch (self.label) {
		case "MASTER": var volume = global.master_volume; break;
		case "BGM": var volume = global.bgm_volume; break;
		case "SFX": var volume = global.sfx_volume; break;
	}
	
	draw_set_halign(fa_right);
	draw_text_outline(x + 100, y, string(round(volume * 100)) + "%", c_black);
	draw_set_color(c_dkgray);
	draw_triangle(x + 100, y + 10, x + 320, y - 20, x + 320, y + 10, false);
	draw_set_color(c_white);
	var triangle_x = x + 100 + 220 * volume;
	var triangle_y = y - 20 + 30 * (1 - volume);
	draw_triangle(x + 100, y + 10, triangle_x, triangle_y, triangle_x, y + 10, false);
}

var display_check = function() {
	var scroll = (global.actions.right.pressed() - global.actions.left.pressed());
	
	if (scroll != 0) {
		switch (self.label) {
			case "FULLSCREEN":
				if (global.fullscreen_delay == 0) {
					global.fullscreen_display ^= true;
					global.fullscreen_delay = get_frames_static(0.5);
				}
				break;
				
			case "VSYNC": global.vsync_display ^= true; break;
			case "SMOOTH": global.smooth_display ^= true; break;
		}
		
		apply_display();
		audio_play_sound(global.sound_cursor_select, 0, false);
	}
}

var display_draw = function(x, y) {
	switch (self.label) {
		case "FULLSCREEN": var display = global.fullscreen_display; break;
		case "VSYNC": var display = global.vsync_display; break;
		case "SMOOTH": var display = global.smooth_display; break;
	}
	
	draw_set_color((display) ? c_lime : c_red);
	draw_text_outline(x + 40, y, (display) ? "ON" : "OFF", c_black);
}

var game_check = function() {
}

var game_draw = function(x, y) {
	switch (self.label) {
		case "LANGUAGE": var display = language_get_text($"SETTINGS_GAME_{string_replace_all(string_upper(global.language_game), " ", "_")}"); break;
	}
	
	draw_set_color(c_white);
	draw_text_outline(x + 40, y, string_upper(display), c_black);
}

var controls_check = function() {
	if (!input_binding_scan_in_progress()) {
		input_binding_scan_start(function(bind) {
			checking_bind = bind;
			var forbidden_binds = [
				vk_f4,
				vk_escape,
				gp_axislh,
				gp_axislv,
				gp_axisrh,
				gp_axisrv
			];
			
			if (array_all(forbidden_binds, function(x) { return (checking_bind.value != x); })) {
				input_binding_set_safe(string_lower(self.label), bind);
			}
			
			with (objSettings) {
				sections[section_selected].in_option = -1;
			}
			
			self.changing = false;
			audio_play_sound(global.sound_cursor_select, 0, false);
		}, function() {
			with (objSettings) {
				sections[section_selected].in_option = -1;
			}
			
			self.changing = false;
			audio_play_sound(global.sound_cursor_select, 0, false);
		});
		
		self.changing = true;
		audio_play_sound(global.sound_cursor_select, 0, false);
	}
}

var controls_draw = function(x, y) {
	if (self.changing) {
		return;
	}
	
	draw_sprite_ext(global.actions[$ string_lower(self.label)].bind(), 0, x + 40, y, 0.75, 0.75, 0, c_white, draw_get_alpha());
}

var defaults_check = function() {
	input_profile_reset_bindings(input_profile_get() ?? "keyboard_and_mouse");
	
	with (objSettings) {
		sections[section_selected].in_option = -1;
	}
	
	audio_play_sound(global.sound_cursor_select, 0, false);
}

var defaults_draw = function() {}

var hotswap_check = function() {
	var scroll = (global.actions.right.pressed() - global.actions.left.pressed());
	
	if (scroll != 0) {
		global.controls_hotswap ^= true;
		apply_hotswap();
	}
}

var hotswap_draw = function(x, y) {
	draw_set_color((global.controls_hotswap) ? c_lime : c_red);
	draw_text_outline(x + 30, y, (global.controls_hotswap) ? "ON" : "OFF", c_black);
}

sections = [
	new Section("VOLUME", language_get_text("SETTINGS_VOLUME"), [
		new Option("MASTER", language_get_text("SETTINGS_VOLUME_MASTER"), volume_check, volume_draw),
		new Option("BGM", language_get_text("SETTINGS_VOLUME_BGM"), volume_check, volume_draw),
		new Option("SFX", language_get_text("SETTINGS_VOLUME_SFX"), volume_check, volume_draw)
	]),
	
	new Section("DISPLAY", language_get_text("SETTINGS_DISPLAY"), [
		new Option("FULLSCREEN", language_get_text("SETTINGS_DISPLAY_FULLSCREEN"), display_check, display_draw),
		new Option("VSYNC", language_get_text("SETTINGS_DISPLAY_VSYNC"), display_check, display_draw),
		new Option("SMOOTH", language_get_text("SETTINGS_DISPLAY_SMOOTH"), display_check, display_draw)
	]),
	
	new Section("GAME", language_get_text("SETTINGS_GAME"), [
		new Option("LANGUAGE", language_get_text("SETTINGS_GAME_LANGUAGE"), game_check, game_draw)
	]),
	
	new Section("CONTROLS", language_get_text("SETTINGS_CONTROLS"), [])
];

keys = [
	"left",
	"right",
	"up",
	"down",
	"jump",
	"shoot",
	"misc",
	"pause"
];

for (var i = 0; i < array_length(keys); i++) {
	var name = keys[i];
	var action = global.actions[$ name];
	var control = string_upper(name);
	
	array_push(sections[3].options, new Option(control, language_get_text($"SETTINGS_CONTROLS_{control}"), controls_check, controls_draw));
}

array_push(sections[3].options,
	new Option("RESET DEFAULTS", language_get_text("SETTINGS_CONTROLS_RESET_DEFAULTS"), defaults_check, defaults_draw),
	new Option("HOTSWAP", language_get_text("SETTINGS_CONTROLS_HOTSWAP"), hotswap_check, hotswap_draw)
);

section_selected = 0;
section_x = 0;
draw = true;
draw_x = 400;
draw_target_x = draw_x;
draw_y = 200;
draw_target_y = draw_y;

controls_text = new Text(fntControls);
volume_delay = 0;