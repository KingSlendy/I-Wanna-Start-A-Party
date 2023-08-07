global.main_dialogue_width = 500;
global.main_dialogue_height = 150;

function Text(font, text = "", tw_spd = 0) constructor {
	self.font = font;
	self.text = text;
	self.tw_spd = tw_spd;
	self.original_text = text;
	self.tw_active = false;
	
	self.formats = [];
	
	static init_formats = function() {
		if (array_length(self.formats) > 0) {
			self.formats = [];
		}
		
		if (string_count("{", self.text) == 0 || string_count("}", self.text) == 0) {
			return;
		}
		
		var active_format = false;
		var store_format = "";
		
		for (var i = 1; i <= string_length(self.text); i++) {
			var char = string_char_at(self.text, i);
			
			if (char == "}") {
				string_insert("@", self.text, i);
				array_push(self.formats, store_format);
				active_format = false;
				store_format = "";
				continue;
			} else if (char == "{") {
				active_format = true;
				continue;
			}
			
			if (!active_format) {
				continue;
			}
			
			store_format += char;
		}
		
		for (var i = 0; i < array_length(self.formats); i++) {
			self.text = string_replace_all(self.text, self.formats[i], "@");
			self.formats[i] = new Format(self.formats[i]);
		}
		
		self.text = string_replace_all(self.text, "{", "");
		self.text = string_replace_all(self.text, "}", "");
	}
	
	static draw = function(x, y, max_width = 5000, outline = c_black, c1 = c_white, c2 = c_white, c3 = c_white, c4 = c_white) {
		language_set_font(self.font);
		draw_set_color(c_white);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		
		//Effects
		self.text_wave = false;
		self.text_swirl = false;
		self.text_shake = false;
		self.text_rainbow = false;
		
		var show = self.text;
		var width = 0;
		var height = 0;
		var max_height = 0;

		if (self.tw_active && self.tw_spd > 0) {
			show = string_copy(self.text, 1, self.tw_count);
		}
		
		var current_format = 0;
		
		for (var i = 1; i <= string_length(show); i++) {
			var char = string_char_at(show, i);
			
			//Checks if there's enough space for the next word
			if (array_contains(["ZH", "JA"], global.language_codes[$ global.language_game])) {
				if (width + string_width(char) >= max_width) {
					width = 0;
					height = max_height;
				}
			}
			
			if (char == " ") {
				if (width == 0) {
					continue;
				}
				
				var space_i = i + 1;
				var space_width = width + string_width(char);
				var space_char = "";
				var space_format = current_format;
				
				while (true) {
					space_char = string_char_at(self.text, space_i++);
					
					if (space_char == "" || space_char == " " || space_char == "\n") {
						break;
					}
					
					if (space_char == "@") {
						var format = self.formats[space_format++];
						var margins = format.apply(self, x, y, space_width, max_width, height, max_height, true);
						space_width = margins.w;
					} else {
						space_width += string_width(space_char);
					}
					
					if (space_width >= max_width) {
						char = "\n";
						break;
					}
				}	
			}
			
			if (char == "\n") {
				width = 0;
				height = max_height;
				continue;
			}
			
			var offset_x = 0;
			var offset_y = 0;
			
			if (self.text_wave || self.text_swirl) {
				offset_y = sin((current_time / 100) + i);
			}
			
			if (self.text_swirl) {
				offset_x = cos((current_time / 100) + i);
			}
			
			if (self.text_shake) {
				offset_x = random_range(-0.6, 0.6);
				offset_y = random_range(-0.6, 0.6);
			}
			
			if (char == "@") {
				var format = self.formats[current_format++];
				var margins = format.apply(self, x + offset_x, y + offset_y, width, max_width, height, max_height);
				width = margins.w;
				height = margins.h;
				max_height = margins.mh;
				continue;
			}
			
			if (self.text_rainbow) {
				draw_set_color(make_color_hsv((current_time / 10 + i) % 256, 255, 255));
			}
			
			if (draw_get_color() == c_white) {
				draw_text_color_outline(x + width + offset_x, y + height + offset_y, char, c1, c2, c3, c4, draw_get_alpha(), outline);
			} else {
				draw_text_outline(x + width + offset_x, y + height + offset_y, char, outline);
			}
			
			width += string_width(char);
			max_height = max(max_height, height + string_height(char));
		}
		
		//Increments the typewriter timer
		if (self.tw_active && self.tw_spd > 0) {
			if (self.tw_delay > 0) {
				self.tw_delay--;
				return;
			}
			
			if (++self.tw_timer > self.tw_spd) {
				var tw_char = "";
			
				while (tw_char == "" || tw_char == " " || tw_char == "\n") {
					tw_char = string_char_at(self.text, ++self.tw_count);
				}
				
				if (tw_char != "@") {
					//audio_play_sound(sndTest, 0, false);
				}
			
				if (self.tw_count >= string_length(self.text)) {
					self.tw_active = false;
				}
			
				self.tw_timer = 0;
			}
		}
		
		return max_height;
	}
	
	static set = function(text) {
		if (text == self.text) {
			return;
		}
		
		self.text = text;
		self.init_formats();
	}
	
	static skip = function() {
		self.tw_spd = 0;
		self.tw_active = false;
		//sound
	}
	
	static tw_reset = function() {
		self.tw_timer = 0;
		self.tw_count = 0;
		self.tw_delay = 0;
		self.tw_active = true;
	}
	
	//static toString = function() {
		//return string("{ Text: {0} | Formats: {1} }", self.text, self.formats);
	//}
	
	self.init_formats();
	self.tw_reset();
}

function Format(text) constructor {
	var data = string_split(text, ",");
	self.params = [];
	
	if (is_array(data)) {
		self.type = data[0];
		array_copy(self.params, 0, data, 1, array_length(data) - 1);
	} else {
		self.type = data;
	}
	
	self.delayed = false;
	
	static apply = function(text, x, y, width, max_width, height, max_height, ignore = false) {
		if (self.type == "SPRITE") {
			var parsed = {
				sprite: asset_get_index(self.params[0]),
				subimg: real(self.params[1]),
				xoff: real(self.params[2]),
				yoff: real(self.params[3]),
				xscale: real(self.params[4]),
				yscale: real(self.params[5])
			};
				
			if (!ignore) {
				draw_sprite_ext(parsed.sprite, parsed.subimg, x + width + sprite_get_xoffset(parsed.sprite) * parsed.xscale + parsed.xoff, y + height + sprite_get_yoffset(parsed.sprite) * parsed.yscale + parsed.yoff, parsed.xscale, parsed.yscale, 0, c_white, draw_get_alpha());
			}
				
			width += sprite_get_width(parsed.sprite) * parsed.xscale + parsed.xoff;
			max_height = max(max_height, height + sprite_get_height(parsed.sprite) * parsed.yscale + parsed.yoff);
		} else if (!ignore) {
			switch (self.type) {
				case "COLOR": draw_set_color(real("0x" + self.params[0])); break;
				case "FONT": language_set_font(asset_get_index(self.params[0])); break;
				case "WAVE": text.text_wave = !text.text_wave; break;
				case "SWIRL": text.text_swirl = !text.text_swirl; break;
				case "SHAKE": text.text_shake = !text.text_shake; break;
				case "RAINBOW": text.text_rainbow = !text.text_rainbow; break;
					
				case "DELAY":
					if (!self.delayed) {
						text.tw_delay = real(self.params[0]);
						self.delayed = true;
					}
					break;
				
				case "STOP": text.tw_active = false; break;
				default: print("Invalid format type: " + self.type); break;
			}
		}
		
		return {
			w: width,
			h: height,
			mh: max_height
		};
	}
	
	//static toString = function() {
		//return string("{ Type: {0} | Params: {1} }", self.type, self.params);
	//}
}

function Message(text, branches = [], event = null) constructor {
	self.text = text;
	self.branches = branches;
	self.event = event;
	
	//static toString = function() {
		//return string("{ Text: {0} | Branches: {1} | Event: {2} }", self.text, self.branches, self.event);
	//}
}

function set_texts_deep(texts, font, tw_spd) {
	for (var i = 0; i < array_length(texts); i++) {
		var text = texts[i];

		if (instanceof(text) == "Message") {
			text.text = new Text(font, text.text, tw_spd);
				
			if (array_length(text.branches) > 0) {
				set_texts_deep(text.branches, font, tw_spd);
			}
		} else if (is_array(text)) {
			//text[@ 0] = language_get_text(text[0]);
			set_texts_deep(text[1], font, tw_spd);
		} else {
			//language_get_text(text)
			texts[@ i] = new Message(new Text(font, text, tw_spd));
		}
	}
}

function start_dialogue(texts, tw_spd = 1) {
	var xx = (display_get_gui_width() - global.main_dialogue_width) / 2;
	
	if (room != rResults) {
		var yy = display_get_gui_height() - global.main_dialogue_height;
	} else {
		var yy = 0;
	}
	
	var ww = global.main_dialogue_width;
	var hh = global.main_dialogue_height;
	var font = global.fntDialogue;
	
	set_texts_deep(texts, font, tw_spd);
	
	var dialogue = instance_create_layer(xx, yy, "Managers", objDialogue);
	dialogue.width = ww;
	dialogue.height = hh;
	dialogue.texts = texts;
	
	with (dialogue) {
		text_start();
	}
	
	return dialogue;
}

function change_dialogue(texts, tw_spd = 1) {
	var ww = global.main_dialogue_width;
	var hh = global.main_dialogue_height;
	var font = global.fntDialogue;
	
	set_texts_deep(texts, font, tw_spd);
	
	with (objDialogue) {
		event_perform(ev_create, 0);
		image_alpha = 1;
		width = ww;
		height = hh;
		self.texts = texts;
		curve_pos = 1;
		
		text_start();
	}
}