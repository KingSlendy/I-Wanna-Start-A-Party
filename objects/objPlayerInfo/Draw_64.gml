if (player_info == null || (!IS_BOARD && room != rParty && room != rResults)) {
	exit;
}

with (objChanceTime) {
	if (started && !array_contains(player_ids, other.player_info.turn - 1)) {
		exit;
	}
}

var reactions_x, reactions_y;

if (IS_BOARD && can_controls() && player_info.network_id == global.player_id) {
	reactions_x = draw_x;
	
	switch (player_info.turn) {
		case 1: case 2:
			reactions_y = draw_y + draw_h + 5;
			break;
			
		case 3: case 4:
			reactions_y = draw_y - 28;
			break;
	}

	if (can_react()) {
		controls_text.set((!reactions) ? draw_action_small(global.actions.shoot) + " Reactions" : draw_action_small(global.actions.jump) + " React  " + draw_action_small(global.actions.shoot) + " Cancel");
		controls_text.draw(reactions_x, reactions_y);
	}
	
	if (can_map()) {
		controls_text.set(draw_action_small(global.actions.misc) + " Map");
		controls_text.draw(reactions_x, reactions_y);
	}
}

if (reactions) {
	reactions_y = draw_y;
	var reactions_size = 45;
	var key_size = 40;
	
	switch (player_info.turn) {
		case 1: case 3:
			reactions_x = draw_x + draw_w + key_size;
			break;
			
		case 2: case 4:
			reactions_x = draw_x - reactions_size * 2 - key_size;
			break;
	}
	
	for (var i = 0; i < 4; i++) {
		var image_x = reactions_x + reactions_size * floor(i / 2);
		var image_y = reactions_y + reactions_size * (i % 2);
		var image_selected = i + page * 2;
		var image_color = (have_reaction(image_selected)) ? c_white : c_black;
		
		if (selected == image_selected) {
			image_color = make_color_hsv(10, 120, 255);
		}
		
		if (!have_reaction(image_selected)) {
			gpu_set_fog(true, image_color, 0, 0);
		}
		
		draw_sprite_stretched_ext(sprReactions, image_selected, image_x, image_y, reactions_size, reactions_size, image_color, 1);
		gpu_set_fog(false, c_white, 0, 0);
	}
	
	if (page != 0) {
		draw_sprite_ext(global.actions.left.bind(), 0, reactions_x - 20, reactions_y + 45, 0.5, 0.5, 0, c_white, 1);
	}
	
	if (page != floor(sprite_get_number(sprReactions) / 2) - 2) {
		draw_sprite_ext(global.actions.right.bind(), 0, reactions_x + 110, reactions_y + 45, 0.5, 0.5, 0, c_white, 1);
	}
}

if (reacted != -1) {
	var reactions_size = sprite_get_width(sprReactions) * 0.5;
	reactions_y = draw_y + floor(reactions_size / 2);
	
	switch (player_info.turn) {
		case 1:
			reactions_x = draw_x + draw_w + floor(reactions_size / 2);
			reactions_y = draw_y + floor(reactions_size / 2);
			break;
			
		case 2:
			reactions_x = draw_x - floor(reactions_size / 2);
			reactions_y = draw_y + floor(reactions_size / 2);
			break;
			
		case 3:
			reactions_x = draw_x + draw_w + floor(reactions_size / 2);
			reactions_y = draw_y + floor(reactions_size / 2) - abs(draw_h - reactions_size);
			break;
			
		case 4:
			reactions_x = draw_x - floor(reactions_size / 2);
			reactions_y = draw_y + floor(reactions_size / 2) - abs(draw_h - reactions_size);
			break;
	}
	
	draw_sprite_ext(sprReactions, reacted, reactions_x, reactions_y, reaction_scale, reaction_scale, 0, c_white, reaction_alpha);
	reaction_scale = approach(reaction_scale, 0.5, 0.05);
	reaction_alpha = approach(reaction_alpha, reaction_target, 0.05);
}

draw_set_alpha(1);
draw_box(draw_x, draw_y, draw_w, draw_h, player_info.space, player_color_by_turn(player_info.turn), 0.8,, 3);
draw_set_color(c_black);
draw_circle(draw_x + 23, draw_y + 21, 16, false);
draw_set_color(player_color_by_turn(player_info.turn));
draw_circle(draw_x + 23, draw_y + 21, 15, false);
draw_set_font(fntPlayerInfo);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_sprite(player_idle_image, 0, draw_x + 25, draw_y + 23);
draw_sprite_ext(sprShine, 0, draw_x + 56, draw_y + 45, 0.5, 0.5, 0, c_white, 1);
draw_text_outline(draw_x + 70, draw_y + 33, string(player_info.shines), c_black);
draw_sprite_ext(sprCoin, 0, draw_x + 56, draw_y + 71, 0.6, 0.6, 0, c_white, 1);
draw_text_outline(draw_x + 70, draw_y + 59, string(player_info.coins), c_black);
draw_set_halign(fa_right);

for (var i = 0; i < min(array_length(player_info.items), 3); i++) {
	var item = player_info.items[i];
	
	if (item == null) {
		continue;
	}
	
	var item_x = draw_x + 160 + 35 * (i - 1);
	var item_y = draw_y + 25 + 35;
	
	if (i == 0) {
		item_x = draw_x + 160 + 35 / 2;
		item_y = draw_y + 25;
	}
	
	draw_sprite_ext(item.sprite, 0, item_x, item_y, 0.5, 0.5, 0, c_white, 1);
}

if (player_info.pokemon != -1) {
	draw_sprite_ext(player_info.pokemon, 0, draw_x + 100, draw_y - 15, 0.75, 0.75, 0, c_white, 1);
}

draw_sprite_ext(sprPlayerInfoPlaces, player_info.place - 1, draw_x + 10, draw_y + 57, 0.6, 0.6, 0, c_white, 1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_player_name(draw_x + 44, draw_y + 21, player_info.network_id);