fade_start = true;
fade_alpha = 1;
surf = noone;

menu_page = 0;

skin_row = 0;
skin_col = 0;
skins = [];
skin_show = 4;
skin_y = 118;
skin_target_y = skin_y;
skin_target_row = skin_row;

for (var i = 0; i < array_length(global.skin_sprites); i++) {
	var r = i % skin_show;
	var c = floor(i / skin_show);
	
	if (r == 0) {
		array_push(skins, []);
	}
	
	array_push(skins[c], i);
}

skin_player = 0;
skin_selected = array_create(global.player_max, -1);

with (objPlayerBase) {
	change_to_object(objPlayerParty);
}

with (objPlayerBase) {
	image_xscale = 2;
	image_yscale = 2;
	x = 230 + 110 * (network_id - 1);
	y = 500;
}
