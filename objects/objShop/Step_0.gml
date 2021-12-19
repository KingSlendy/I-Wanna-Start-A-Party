var scroll = (global.down_action.pressed() - global.up_action.pressed());
var prev_selected = option_selected;

if (option_selected == -1) {
	option_selected = 0;
}

option_selected = (option_selected + 5 + scroll) % 5;

if (prev_selected != option_selected) {
	if (instance_exists(objDialogue)) {
		var item = stock[option_selected];
		
		with (objDialogue) {
			text_change(item.name + "\n\n\n" + item.desc);
		}
	}
}