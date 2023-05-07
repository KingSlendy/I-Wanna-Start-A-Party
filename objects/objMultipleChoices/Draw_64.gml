if (global.choice_selected == -1) {
	exit;
}

var color = player_color_by_turn(player_info_by_id(network_id).turn);
var total = array_length(choices) - array_count(choices, "");
var total_length = length * total + separation * (total - 1);
var draw_x = display_get_gui_width() / 2 - total_length / 2;
var draw_y = display_get_gui_height() / 2 - length;

draw_set_alpha(image_alpha);

var motive_width = 300;
var motive_x = display_get_gui_width() / 2 - motive_width / 2;
var motive_y = draw_y - 100;
draw_box(motive_x, motive_y, motive_width, 40, c_dkgray, color);
draw_set_font(fntDialogue);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text_info(motive_x + motive_width / 2, motive_y + 40 / 2, motive, motive_width - 25);
draw_set_valign(fa_top);
draw_set_halign(fa_left);

if (array_length(titles) > 0) {
	var title_width = 150;
	var title_x = display_get_gui_width() / 2 - title_width / 2;
	var title_y = draw_y - 50;
	draw_box(title_x, title_y, title_width, 40, c_dkgray, color);
	draw_set_font(fntDialogue);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	//var text = new Text(fntDialogue, titles[global.choice_selected]);
	//text.draw(title_x + 15, title_y + 8);
	draw_text_info(title_x + title_width / 2, title_y + 40 / 2, titles[global.choice_selected], title_width - 25);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
}

if (array_length(descriptions) > 0) {
	var desc_width = 400;
	var desc_x = display_get_gui_width() / 2 - desc_width / 2;
	var desc_y = draw_y + length + 10;
	draw_box(desc_x, desc_y, desc_width, 150, c_dkgray, color);
	var text = new Text(fntDialogue, descriptions[global.choice_selected]);
	text.draw(desc_x + 15, desc_y + 15, desc_width - 30);
}

var index = 0;

for (var i = 0; i < array_length(choices); i++) {
	if (choices[i] == "") {
		continue;
	}
	
	var choice_x = draw_x + (separation + length) * index++;
	var is_selected = (i == global.choice_selected);
	draw_box(choice_x, draw_y, length, length, (is_selected) ? c_gray : c_dkgray, color);
	draw_set_alpha((availables[i]) ? image_alpha : image_alpha * 0.25);
	var text = new Text(fntDialogue, ((is_selected) ? "{SWIRL}" : "") + choices[i]);
	text.draw(choice_x + length / 2, draw_y + length / 2);
	draw_set_alpha(image_alpha);
}

draw_set_alpha(1);