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
	self.draw_label = function(x, y, condition, in_option) {
		self.highlight = lerp(self.highlight, (!condition) ? 0.5 : 1, 0.3);
		var color1 = (!in_option) ? c_orange : c_green;
		var color2 = (!in_option) ? c_yellow : c_lime;
		draw_text_transformed_color_outline(x, y, self.label, self.highlight, self.highlight, 0, color1, color1, color2, color2, self.highlight, c_black);
	}
}

sections = [
	new Section("VOLUME", [
		new Option("MASTER", function() {
			var scroll = (global.actions.right.pressed() - global.actions.left.pressed());
		}, function() {
			
		}),
		
		new Option("BGM", function() {
		}, function() {
			
		}),
		
		new Option("SFX", function() {
		}, function() {
			
		})
	])
];

section_selected = 0;
section_x = 0;