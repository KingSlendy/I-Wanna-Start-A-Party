fade_start = false;
fade_alpha = 1;
alarm[0] = get_frames(1);

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
var surf = noone;

if (!surface_exists(surf)) {
	surf = surface_create(title_w, title_h);
}

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

function GiftKids(angle) constructor {
	self.angle = angle;

	self.display = function() {
		var skin = get_skin(irandom(array_length(global.skin_sprites) - 1));
		var names = variable_struct_get_names(skin);
		self.sprite = skin[$ names[irandom(array_length(names) - 1)]];
	}
	
	self.display();
	
	self.draw = function() {
		draw_sprite_ext(sprite, 0, 400 + round(300 * dcos(self.angle)), 330 + round(50 * dsin(self.angle)), 5, 5, 0, c_white, 1);
		self.angle = (self.angle + 360 + 0.5) % 360;
		
		if (point_distance(0, self.angle, 0, 270) <= 2) {
			self.display();
		}
	}
}

kids = [];

for (var i = 0; i < 360; i += 360 / 7) {
	array_push(kids, new GiftKids(i));
}
