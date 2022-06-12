fade_start = true;
fade_alpha = 1;
fade_ready = true;

files_alpha = 0;
files_fade = -1;
file_sprites = array_create(3, null);
file_width = 32 * 7;

for (var i = 0; i < array_length(file_sprites); i++) {
	file_original_pos[i] = [32 + (file_width + 32) * i, 128];
}

file_pos = [];
array_copy(file_pos, 0, file_original_pos, 0, array_length(file_original_pos));

file_highlights = array_create(3, 0.8);
file_selected = -1;
file_opened = -1;
menu_type = 0;

function FileButton(x, y, w, h, dir, label, color = c_white, selectable = true, sprite = null) constructor {
	self.w = w;
	self.h = h;
	var surf = surface_create(w, h);
	surface_set_target(surf);
	draw_sprite_stretched_ext(sprButtonSlice, 0, 0, 0, w, h, color, 1);
	draw_set_font(fntFilesFile);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text_color_outline(w / 2, h / 2, label, #FFA545, #FFA545, #FF8400, #FF8400, 1, c_black);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	if (sprite != null) {
		draw_sprite(sprite, 0, w / 2, h / 2);
	}
	
	surface_reset_target();
	self.sprite = sprite_create_from_surface(surf, 0, 0, w, h, false, false, w / 2, h / 2);
	surface_free(surf);
	
	self.original_pos = [400 + (800 * dir), y];
	self.pos = [];
	array_copy(self.pos, 0, self.original_pos, 0, 2);
	self.main_pos = [x, y];
	self.target_pos = [x, y];
	self.selectable = selectable;
	self.highlight = 1;
	
	self.draw = function(alpha) {
		draw_sprite_ext(self.sprite, 0, self.pos[0], self.pos[1], self.highlight, self.highlight, 0, c_white, self.highlight - alpha);
	}
	
	self.check = function(condition_pos, condition_highlight) {
		var set_pos = (!condition_pos) ? self.original_pos : self.target_pos;
		self.pos[0] = lerp(self.pos[0], set_pos[0], 0.2);
		self.pos[1] = lerp(self.pos[1], set_pos[1], 0.2);
		
		if (self.selectable) {
			self.highlight = lerp(self.highlight, (!condition_highlight) ? 0.8 : 1, 0.3);
		}
	}
}

menu_buttons = [
	[new FileButton(400, 352, file_width, 64, -1, "START", c_blue), new FileButton(400, 432, file_width, 64, 1, "DELETE", c_red)],
	[new FileButton(400, 352, file_width, 64, -1, "OFFLINE", c_white), new FileButton(400, 432, file_width, 64, 1, "ONLINE", c_aqua)],
	[new FileButton(400, 352, file_width, 64, -1, "CANCEL", c_green), new FileButton(400, 432, file_width, 64, 1, "CONFIRM", c_red)],
	[new FileButton(150, 172, file_width, 64, -1, "NAME", c_white), new FileButton(150, 252, file_width, 64, -1, "IP", c_white), new FileButton(150, 332, file_width, 64, -1, "PORT", c_white), new FileButton(150, 412, file_width, 64, -1, "CONNECT", c_lime), null, new FileButton(520, 172, file_width * 2, 64, 1, "", c_white, false), new FileButton(520, 252, file_width * 2, 64, 1, "", c_white, false), new FileButton(520, 332, file_width * 2, 64, 1, "", c_white, false)],
	[new FileButton(150, 172, file_width, 64, -1, "NAME", c_white), new FileButton(150, 252, file_width, 64, -1, "PASSWORD", c_white), new FileButton(150, 332, file_width, 64, -1, "CREATE", c_lime), new FileButton(150, 402, file_width, 64, -1, "JOIN", c_lime), new FileButton(150, 482, file_width, 64, -1, "LIST", c_blue), null, new FileButton(520, 172, file_width * 2, 64, 1, "", c_white, false), new FileButton(520, 252, file_width * 2, 64, 1, "", c_white, false)],
	[new FileButton(400, 470, file_width, 64, -1, "START", c_lime), null, new FileButton(400, 150, file_width * 2, 64, -1, "",, false), new FileButton(400, 230, file_width * 2, 64, 1, "",, false), new FileButton(400, 310, file_width * 2, 64, -1, "",, false), new FileButton(400, 390, file_width * 2, 64, 1, "",, false)]
];

menu_selected = array_create(array_length(menu_buttons), 0);

for (var i = 0; i < array_length(file_sprites); i++) {
	var surf = surface_create(file_width, file_width);
	surface_set_target(surf);
	draw_sprite_stretched_ext(sprButtonSlice, 0, 0, 0, file_width, file_width, #7FC1FA, 1);
	draw_set_font(fntFilesFile);
	draw_set_halign(fa_center);
	draw_text_color_outline(file_width / 2, 10, "FILE " + string(i + 1), c_lime, c_lime, c_green, c_green, 1, c_black);
	draw_set_halign(fa_left);
	surface_reset_target();
	file_sprites[i] = sprite_create_from_surface(surf, 0, 0, file_width, file_width, false, false, file_width / 2, file_width / 2);
	surface_free(surf);
}

upper_type = 0;
upper_text = "";

finish = false;
online_texts = [
	"Player",
	"iwannastartaparty.sytes.net",
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
