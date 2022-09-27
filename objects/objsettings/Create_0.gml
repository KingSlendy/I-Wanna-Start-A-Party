fade_start = true;
fade_alpha = 1;
back = false;

function Section(name, options) constructor {
	self.name = name;
	self.options = options;
	self.selected = 0;
	self.in_option = -1;
}

function Option(label, check_option, draw_option) constructor {
	self.label = label;
	self.check_option = method(self, check_option);
	self.draw_option = method(self, draw_option);
	self.highlight = 0.5;
	
	draw_set_font(fntFilesButtons);
	self.label_width = string_width(self.label);
	self.label_height = string_height(self.label);
	self.draw_label = function(x, y, condition, in_option) {
		draw_set_font(fntFilesButtons);
		self.highlight = lerp(self.highlight, (!condition) ? 0.5 : 1, 0.3);
		var color1 = (!in_option) ? c_gray : c_green;
		var color2 = (!in_option) ? c_white : c_lime;
		draw_text_transformed_color_outline(x, y, self.label, self.highlight, self.highlight, 0, color1, color1, color2, color2, self.highlight * draw_get_alpha(), c_black);
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

var controls_draw = function(x, y) {
	draw_sprite_ext(global.actions[$ string_lower(self.label)].bind(), 0, x + 40, y, 0.75, 0.75, 0, c_white, 1);
}

sections = [
	new Section("VOLUME", [
		new Option("MASTER", volume_check, volume_draw),
		new Option("BGM", volume_check, volume_draw),
		new Option("SFX", volume_check, volume_draw)
	]),
	
	new Section("DISPLAY", [
		new Option("FULLSCREEN", display_check, display_draw),
		new Option("VSYNC", display_check, display_draw),
		new Option("SMOOTH", display_check, display_draw)
	]),
	
	new Section("CONTROLS", [])
];

keys = [
	"left",
	"right",
	"up",
	"down",
	"jump",
	"shoot",
	"pause"
];

for (var i = 0; i < array_length(keys); i++) {
	var name = keys[i];
	var action = global.actions[$ name];
	
	array_push(sections[2].options, new Option(string_upper(name), function() {}, controls_draw));
}

section_selected = 0;
section_x = 0;
draw = true;
draw_x = 400;
draw_target_x = draw_x;
draw_y = 200;
draw_target_y = draw_y;

controls_text = new Text(fntControls);
volume_delay = 0;
network_id = 1;