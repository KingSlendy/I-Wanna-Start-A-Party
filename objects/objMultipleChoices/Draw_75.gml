var total = array_length(choices) - array_count(choices, "");
var total_length = length * total + separation * (total - 1);
var draw_x = display_get_gui_width() / 2 - total_length / 2;
var draw_y = display_get_gui_height() / 2 - length;

draw_set_alpha(image_alpha);
var index = 0;

for (var i = 0; i < array_length(choices); i++) {
	if (choices[i] == "") {
		continue;
	}
	
	var choice_x = draw_x + (separation + length) * index++;
	var is_selected = (i == global.choice_selected);
	draw_box(choice_x, draw_y, length, length, (is_selected) ? c_gray : c_dkgray);
	var text = new Text(fntDialogue, ((is_selected) ? "{SWIRL}" : "") + choices[i]);
	text.draw(choice_x + length / 2, draw_y + length / 2);
}

draw_set_alpha(1);