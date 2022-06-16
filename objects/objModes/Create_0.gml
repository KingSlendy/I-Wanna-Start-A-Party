fade_alpha = 1;
fade_start = true;
state = -1;

function ModeButton(x, y, w, h, label, sprite, scale, offset, color = c_white, selectable = true) constructor {
	self.w = w;
	self.h = h;
	var surf = surface_create(w, h);
	surface_set_target(surf);
	draw_sprite_stretched_ext(sprButtonSlice, 0, 0, 0, w, h, color, 1);
	draw_set_font(fntFilesButtons);
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);
	draw_text_color_outline(w / 2, h - 5, label, c_orange, c_orange, c_yellow, c_yellow, 1, c_black);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	if (sprite != null) {
		draw_sprite_ext(sprite, 0, w / 2, offset, scale, scale, 0, c_white, 1);
	}
	
	surface_reset_target();
	self.sprite = sprite_create_from_surface(surf, 0, 0, w, h, false, false, w / 2, h / 2);
	surface_free(surf);
	
	self.pos = [x, y];
	self.selectable = selectable;
	self.highlight = 0.8;
	
	self.draw = function(alpha) {
		draw_sprite_ext(self.sprite, 0, self.pos[0], self.pos[1], self.highlight, self.highlight, 0, c_white, self.highlight - alpha);
	}
	
	self.check = function(condition_highlight) {
		if (self.selectable) {
			self.highlight = lerp(self.highlight, (!condition_highlight) ? 0.8 : 1, 0.3);
		}
	}
}

mode_buttons = [
	new ModeButton(200, 140, 200, 170, "PARTY", sprModesParty, 0.5, 60, c_white),
	new ModeButton(200, 468, 220, 170, "MINIGAMES", sprModesMinigames, 0.5, 60, c_white),
	new ModeButton(600, 140, 200, 170, "SKINS", sprNothing, 0.5, 60, c_white),
	new ModeButton(600, 468, 220, 170, "TROPHIES", sprNothing, 0.5, 60, c_white)
];

mode_selected = global.mode_selected;

with (objPlayerBase) {
	change_to_object(objPlayerBase);
}
