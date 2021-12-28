space_next = null;
space_previous = null;

space_north = null;
space_east = null;
space_west = null;
space_south = null;

var paths = ds_list_create();
var count = instance_place_list(x, y, objPath, paths, false);
mask_index = sprNothing;

for (var i = 0; i < count; i++) {
	var path = paths[| i];
	var space_collide = null;
		
	with (path) {
		space_collide = instance_place(x, y, objSpaces);
	}
	
	if (path.x == x + 16 && path.y == y + 16) {
		if (path.image_index == 1) {
			switch ((path.image_angle + 360) % 360) {
				case 90: space_north = space_collide; break;
				case 0: space_east = space_collide; break;
				case 180: space_west = space_collide; break;
				case 270: space_south = space_collide; break;
			}
		} else {
			space_next = space_collide;
		}
	} else if (path.image_index != 2) {
		space_previous = space_collide;
	}
}

mask_index = sprite_index;
ds_list_destroy(paths);

space_shine = false;

if (image_index == SpaceType.Shine) {
	space_shine = true;
	image_index = SpaceType.Blue;
}

glowing = false;

function space_passing_event() {
	var player_turn_info = get_player_turn_info();
	
	switch (image_index) {
		case SpaceType.Pink:
			call_shop();
			return true;
		
		case SpaceType.Shine:
			if (player_turn_info.coins >= 20) {
				var buy_shine = function() {
					change_coins(-20, CoinChangeType.Spend).final_action = function() {
						change_shines(1, ShineChangeType.Get).final_action = choose_shine;
					}
				}
				
				start_dialogue([
					new Message("Do you wanna buy a shine?", [
						["Buy (" + draw_coins_price(20) + ")", [
							new Message("Here you go! The shine is yours!",, buy_shine)
						]],
						
						["Pass", [
							new Message("Are you really sure you don't want it?", [
								["Buy (" + draw_coins_price(20) + ")", [
									new Message("Good choice! Here you go!",, buy_shine)
								]],
								
								["Pass", [
									new Message("Are you really really sure?", [
										["Buy (" + draw_coins_price(20) + ")", [
											new Message("You were starting to worry me for a second!",, buy_shine)
										]],
										
										["Pass", [
											new Message("Well too bad then, I hope next time you think it through.",, board_advance)
										]]
									])
								]]
							])
						]]
					])
				]);
			} else {
				start_dialogue([
					new Message("You don't have enough coins ({SPRITE,sprCoin,0,0,0,0.6,0.6}20) to buy the shine!\nCome back later.",, board_advance)
				]);
			}
			return true;
		
		case SpaceType.PathChange:
			if (player_turn_info.item_effect != ItemType.Reverse) {
				var p = instance_create_layer(0, 0, "Managers", objPathChange);
				p.space = id;
			}
			
			global.can_open_map = true;
			return true;
	}
	
	return false;
}

function space_finish_event() {
	switch (image_index) {
		case SpaceType.Blue:
			var blue_event = turn_next;
			
			if (1 / 50 > random(1)) {
				blue_event = show_chest;
			}
			
			change_coins(3, CoinChangeType.Gain).final_action = blue_event;
			break;
			
		case SpaceType.Red:
			change_coins(-3, CoinChangeType.Lose).final_action = turn_next;
			break;
			
		case SpaceType.Green:
			turn_next();
			break;
			
		default: break;
	}
	
	change_space(image_index);
}