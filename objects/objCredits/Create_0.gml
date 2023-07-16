fade_start = true;
fade_alpha = 1;
back = false;
max_width = 700;

function Credit(font_title, font_desc, color, title = "", desc = "", hpos = fa_left, vpos = fa_top, image = null, index = 0) constructor {
	self.font_title = font_title;
	self.font_desc = font_desc;
	self.color = color;
	self.title = title;
	self.desc = desc;
	self.hpos = hpos;
	self.vpos = vpos;
	self.image = image;
	self.index = index;
	
	static draw = function(x, y) {
		draw_set_halign(fa_center);
		
		var text_y = y;
		var text_max = objCredits.max_width;
		var text_x = x + text_max / 2;
		
		if (self.image != null) {
			var image_w = sprite_get_width(self.image);
			var image_h = sprite_get_height(self.image);
			var image_x = x;
			var image_y = y;
			
			switch (vpos) {
				case fa_middle:
					draw_set_halign(fa_left);
				
					switch (hpos) {
						case fa_left:
							text_x = x + image_w + 10;
							break;
							
						case fa_right:
							text_x = x;
							image_x = text_max - image_w;
							text_max -= image_w + 10;
							break;
					}
					break;
					
				case fa_bottom:
					language_set_font(self.font_title);
					image_y += string_height_ext(self.title, -1, text_max);
					language_set_font(self.font_desc);
					image_y += string_height_ext(self.desc, -1, text_max);
					image_y += 10;
					
				case fa_top:
					switch (hpos) {
						case fa_center:
							image_x += text_max / 2 - image_w / 2;
							break;
							
						case fa_right:
							image_x += text_max - image_w;
							text_max -= image_w + 10;
							break;
					}
					
					if (vpos != fa_bottom) {
						text_y += image_h + 10;
					}
					break;
			}
			
			draw_sprite(self.image, self.index, image_x, image_y);
		}
		
		draw_set_color(self.color);
		language_set_font(self.font_title);
		draw_text_ext_outline(text_x, text_y, self.title, -1, text_max, c_black);
		var title_h = string_height_ext(self.title, -1, text_max);
		language_set_font(self.font_desc);
		draw_text_ext_outline(text_x, text_y + title_h + 10, self.desc, -1, text_max, c_black);
		var desc_h = string_height_ext(self.desc, -1, text_max);
		draw_set_halign(fa_left);
		
		if (self.image == null) {
			return text_y + title_h + 10 + desc_h;
		} else {
			return max(text_y + title_h + 10 + desc_h, image_y + image_h);
		}
	}
}

//sections = [
//	new Credit(global.FilesFile, fntFilesData, c_white, "Maker", "KingSlendy", fa_right, fa_middle, sprMinigamesFangames, 1)
//	//new Credit(global.FilesData, c_white, "Maker"),
//	//new Credit(global.Dialogue, c_white, "KingSlendy"),
//	//new Credit(,,,,, sprMinigamesFangames, 1)
//];