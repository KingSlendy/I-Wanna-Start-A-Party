depth = -9999;
image_alpha = 0;
x = (display_get_gui_width() - global.main_dialogue_width) / 2;
y = display_get_gui_height() - global.main_dialogue_height;

width = global.main_dialogue_width;
height = global.main_dialogue_height;
border_width = 10;

active = true;
endable = true;
texts = [new Message(new Text(fntDialogue, "Don't expect to get a release date so easily.\nIf you want a release date then visit: iwannastartaparty.com", 1))];
text_branch = null;
text_index = 0;
text_display = texts[0];
text_display.text.tw_active = true;
text_delay = 0;
answer_index = 0;
answer_displays = [];

dialogue_sprite = noone;
text_surf = noone;

alpha_target = 1;
