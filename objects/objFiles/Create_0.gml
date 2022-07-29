fade_start = true;
fade_alpha = 1;

files_alpha = 0;
files_fade = -1;
file_sprites = array_create(3, null);
file_width = 32 * 7;
file_height = 32 * 10;

for (var i = 0; i < array_length(file_sprites); i++) {
	file_original_pos[i] = [32 + (file_width + 32) * i, 64];
}

file_pos = [];
array_copy(file_pos, 0, file_original_pos, 0, array_length(file_original_pos));

file_highlights = array_create(3, 0.75);
file_opened = -1;
menu_type = 0;

function FileButton(x, y, w, h, dir, label, color = c_white, selectable = true, sprite = null, lobby = null) constructor {
	self.w = w;
	self.h = h;
	var surf = surface_create(w, h);
	surface_set_target(surf);
	draw_sprite_stretched_ext(sprButtonSlice, 0, 0, 0, w, h, color, 1);
	draw_set_font(fntFilesButtons);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	
	if (lobby == null) {
		draw_text_color_outline(w / 2, h / 2, label, c_orange, c_orange, c_yellow, c_yellow, 1, c_black);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
	
		if (sprite != null) {
			draw_sprite(sprite, 0, w / 2, h / 2);
		}
	} else {
		draw_set_halign(fa_left);
		draw_text_color_outline(20, h / 2, lobby.lobby_name, c_orange, c_orange, c_yellow, c_yellow, 1, c_black);
		draw_set_halign(fa_right);
		draw_text_color_outline(w - 20, h / 2, string(lobby.lobby_clients) + "/4", c_orange, c_orange, c_yellow, c_yellow, 1, c_black);
		draw_set_halign(fa_left);
		
		if (lobby.lobby_password) {
			draw_sprite(sprFilesLock, 0, w - 120, h / 2);
		}
	}
	
	surface_reset_target();
	self.sprite = sprite_create_from_surface(surf, 0, 0, w, h, false, false, w / 2, h / 2);
	surface_free(surf);
	
	if (abs(dir) == 1) {
		self.original_pos = [400 + (800 * dir), y];
		self.pos = [];
		array_copy(self.pos, 0, self.original_pos, 0, 2);
	} else if (abs(dir) == 2) {
		self.original_pos = [x, 304 + (608 * sign(dir))];
		self.pos = [x, y];
	}
	
	self.main_pos = [x, y];
	self.target_pos = [x, y];
	self.selectable = selectable;
	self.lobby = (lobby != null);
	self.highlight = (abs(dir) != 2) ? 1 : 0.75;
	
	self.draw = function(alpha) {
		draw_sprite_ext(self.sprite, 0, self.pos[0], self.pos[1], self.highlight, self.highlight, 0, c_white, self.highlight - alpha);
	}
	
	self.check = function(condition_pos, condition_highlight) {
		var set_pos = (!condition_pos) ? self.original_pos : self.target_pos;
		self.pos[0] = lerp(self.pos[0], set_pos[0], 0.2);
		self.pos[1] = lerp(self.pos[1], set_pos[1], 0.2);
		
		if (self.selectable) {
			self.highlight = lerp(self.highlight, (!condition_highlight) ? 0.75 : 1, 0.3);
		}
		
		if (self.lobby) {
			var dist = point_distance(0, self.pos[1], 0, 412);
			var highlight = remap(dist, 0, 100, 1, 0);
			
			if (!condition_highlight) {
				highlight *= 0.75;
			}
			
			self.highlight = lerp(self.highlight, highlight, 0.3);
		}
	}
}

menu_buttons = [
	[new FileButton(400, 400, file_width, 64, -1, "START", c_lime), new FileButton(400, 480, file_width, 64, 1, "DELETE", c_red)],
	[new FileButton(400, 400, file_width, 64, -1, "OFFLINE", c_white), new FileButton(400, 480, file_width, 64, 1, "ONLINE", c_aqua)],
	[new FileButton(400, 400, file_width, 64, -1, "CANCEL", c_lime), new FileButton(400, 480, file_width, 64, 1, "CONFIRM", c_red)],
	[new FileButton(150, 172, file_width, 64, -1, "NAME", c_white), new FileButton(150, 252, file_width, 64, -1, "IP", c_white), new FileButton(150, 332, file_width, 64, -1, "PORT", c_white), new FileButton(150, 412, file_width, 64, -1, "CONNECT", c_lime), null, new FileButton(520, 172, file_width * 2, 64, 1, "", c_white, false), new FileButton(520, 252, file_width * 2, 64, 1, "", c_white, false), new FileButton(520, 332, file_width * 2, 64, 1, "", c_white, false)],
	[new FileButton(150, 172, file_width, 64, -1, "NAME", c_white), new FileButton(150, 252, file_width, 64, -1, "PASSWORD", c_white), new FileButton(150, 332, file_width, 64, -1, "CREATE", c_lime), new FileButton(150, 402, file_width, 64, -1, "JOIN", c_lime), new FileButton(150, 482, file_width, 64, -1, "LIST", c_blue), new FileButton(150, 562, file_width, 64, -1, "REFRESH", c_aqua), null, new FileButton(520, 172, file_width * 2, 64, 1, "", c_white, false), new FileButton(520, 252, file_width * 2, 64, 1, "", c_white, false)],
	[new FileButton(400, 470, file_width, 64, -1, "START", c_lime), null, new FileButton(400, 150, file_width * 2, 64, -1, "",, false), new FileButton(400, 230, file_width * 2, 64, 1, "",, false), new FileButton(400, 310, file_width * 2, 64, -1, "",, false), new FileButton(400, 390, file_width * 2, 64, 1, "",, false)]
];

menu_selected = array_create(array_length(menu_buttons), 0);

option_buttons = [
	new FileButton(144, 480, file_width, file_width - 64, 2, "SETTINGS"),
	new FileButton(400, 480, file_width, file_width - 64, 2, "DISCORD"),
	new FileButton(656, 480, file_width, file_width - 64, 2, "CREDITS"),
];

option_selected = -1;

var prev_selected = global.file_selected;

function file_sprite(file) {
	try {
		sprite_delete(file_sprites[file]);
	} catch (_) {
	}
	
	global.file_selected = file;
	load_file();
	var surf = surface_create(file_width, file_height);
	surface_set_target(surf);
	draw_sprite_stretched_ext(sprButtonSlice, 0, 0, 0, file_width, file_height, #7FC1FA, 1);
	draw_set_font(fntFilesFile);
	draw_set_halign(fa_center);
	draw_text_color_outline(file_width / 2, 10, "FILE " + string(file + 1), c_lime, c_lime, c_green, c_green, 1, c_black);
	draw_set_font(fntFilesData);
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_sprite_stretched(sprModesParty, 0, 40 - 14, 85 - 20, 32, 32);
	draw_text_outline(70, 85, string(global.games_played), c_black);
	draw_sprite_ext(sprShine, 0, 40, 120, 0.6, 0.6, 0, c_white, 1);
	draw_text_outline(70, 120, string(global.collected_shines), c_black);
	draw_sprite_ext(sprCoin, 0, 40, 155, 0.75, 0.75, 0, c_white, 1);
	draw_text_outline(70, 155, string(global.collected_coins), c_black);
	draw_sprite_stretched(sprModesMinigames, 0, 40 - 16, 190 - 16, 32, 32);
	draw_text_outline(70, 190, string(array_length(global.seen_minigames)) + "/" + string(array_length(global.minigames[$ "4vs"]) + array_length(global.minigames[$ "1vs3"]) + array_length(global.minigames[$ "2vs2"])), c_black);
	draw_sprite_ext(sprNormalPlayerIdle, 0, 40, 225, 1, 1, 0, c_white, 1);
	draw_text_outline(70, 225, string(array_length(global.collected_skins)) + "/" + string(array_length(global.skins)), c_black);
	draw_sprite_stretched(sprModesTrophies, TrophyRank.Gold, 40 - 16, 260 - 16, 32, 32);
	draw_text_outline(70, 260, string(array_length(global.collected_trophies)) + "/" + string(array_length(global.trophies)), c_black);
	draw_sprite(sprFilesClock, 0, 40 - 16, 295 - 16);
	draw_text_outline(70, 295, string_interp("{0}:{1}{2}:{3}{4}", (global.ellapsed_time div 60) div 60, ((global.ellapsed_time div 60) div 10) mod 6, (global.ellapsed_time div 60) mod 10, (global.ellapsed_time div 10) mod 6, global.ellapsed_time mod 10), c_black);
	draw_set_valign(fa_top);
	surface_reset_target();
	file_sprites[file] = sprite_create_from_surface(surf, 0, 0, file_width, file_height, false, false, file_width / 2, file_width / 2);
	surface_free(surf);
}

for (var i = 0; i < array_length(file_sprites); i++) {
	file_sprite(i);
}

global.file_selected = prev_selected;
upper_type = 0;
upper_text = "";

finish = false;
online_texts = [
	"Player",
	"66.228.52.202",
	"33321"
]

online_limits = [16, -1, 5];
online_reading = false;

lobby_texts = [
	"Room",
	""
];

lobby_limits = [20, 20];
lobby_list = [];
lobby_seeing = false;
lobby_selected = 0;
lobby_return = false;

player_texts = array_create(4, "");

back = false;
back_option = false;
global.mode_selected = -1;