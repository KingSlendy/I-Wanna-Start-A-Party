if (global.debug_mode) {
	if (image_index == SpaceType.PathChange && path_north == null && path_east == null && path_west == null && path_south == null) {
		image_blend = c_red;
	}
}

space_shine = false;

if (image_index == SpaceType.Shine) {
	space_shine = true;
	image_index = SpaceType.Blue;
}

glowing = false;

function space_passing_event() {
	switch (image_index) {
		case SpaceType.Pink:
			var my_info = get_player_info();
			
			if (my_info.free_item_slot() != -1) {
				if (get_player_info().coins >= 5) {
					start_dialogue([
						new Message("Do you wanna enter the shop?", [
							["Yes", [
								new Message("",, function() {
									instance_create_layer(0, 0, "Managers", objShop);
									objDialogue.endable = false;
								})
							]],
						
							["No", [
								new Message("",, board_advance)
							]]
						])
					]);
				} else {
					start_dialogue([
						new Message("You don't have enough money to enter the shop!",, board_advance)
					]);
				}
			} else {
				start_dialogue([
					new Message("You don't have item space!\nCome back later.",, board_advance)
				]);
			}
			return true;
		
		case SpaceType.Shine:
			if (get_player_info().coins >= 20) {
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
			if (global.path_direction == 1) {
				var p = instance_create_layer(0, 0, "Managers", objPathChange);
				p.space = id;
			}
			
			global.path_number = 0;
			return true;
	}
	
	return false;
}

function space_finish_event() {
	switch (image_index) {
		case SpaceType.Blue:
			var blue_event = next_turn;
			
			if (1 / 50 > random(1)) {
				blue_event = show_chest;
			}
			
			change_coins(3, CoinChangeType.Gain).final_action = blue_event;
			break;
			
		case SpaceType.Red:
			change_coins(-3, CoinChangeType.Lose).final_action = next_turn;
			break;
			
		case SpaceType.Green:
			next_turn();
			break;
			
		default: break;
	}
	
	change_space(image_index);
}