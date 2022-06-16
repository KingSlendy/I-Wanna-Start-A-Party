fade_start = true;
fade_alpha = 2;

draw_set_font(fntTitle);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
title_start = false;
title_text = "I WANNA START\nA\nPARTY";
title_x = 400;
title_y = 250;
title_w = string_width(title_text);
title_h = string_height(title_text);
title_alpha = 0;
title_scale = 3;
var surf = surface_create(title_w, title_h);
surface_set_target(surf);
draw_clear_alpha(c_black, 0);
draw_text(title_w / 2, title_h / 2, title_text);
gpu_set_colorwriteenable(true, true, true, false);
draw_sprite_tiled(sprTitleStars, 0, 0, 0);
gpu_set_blendmode(bm_add);
draw_sprite_stretched(sprTitleGradient, 0, 0, 0, title_w, title_h);
gpu_set_blendmode(bm_normal);
gpu_set_colorwriteenable(true, true, true, true);
surface_reset_target();

title_sprite = sprite_create_from_surface(surf, 0, 0, title_w, title_h, false, false, title_w / 2, title_h / 2);
surface_free(surf);

start_visible = false;
pressed = false;

function GiftKids(angle, title) constructor {
	self.angle = angle;
	self.title = title;

	static display = function() {
		var chose = self.title.skins[0];
		array_delete(self.title.skins, 0, 1);
		array_push(self.title.skins, chose);
		var skin = get_skin(chose);
		var names = variable_struct_get_names(skin);
		self.sprite = skin[$ names[irandom(array_length(names) - 1)]];
	}
	
	self.display();
	
	static draw = function() {
		draw_sprite_ext(sprite, 0, 400 + 300 * dcos(self.angle), 360 + 50 * dsin(self.angle), 5, 5, 0, c_white, 1);
		self.angle = (self.angle + 360 + 0.5) % 360;
		
		if (floor(self.angle) == 270) {
			self.display();
			self.angle += 0.5;
		}
	}
}

kids = [];
skins = array_sequence(0, array_length(global.skins));
array_shuffle(skins);

for (var i = 0; i < 360; i += 360 / 7) {
	array_push(kids, new GiftKids(i, id));
}
