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
			//board_advance();
			if (get_player_info().coins >= 5) {
				start_dialogue(fntDialogue, [
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
				//board_advance();
			} else {
				start_dialogue(fntDialogue, [
					new Message("You don't have enough money to enter the shop!", [], board_advance)
				]);
			}
			return true;
		
		case SpaceType.Shine:
			if (get_player_info().coins >= 20) {
				global.show_dice_roll = false;
				
				change_coins(-20, CoinChangeType.Spend).final_action = function() {
					change_shines(1, ShineChangeType.Get).final_action = choose_shine;
				}
			} else {
				board_advance();
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