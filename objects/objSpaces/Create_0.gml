function space_directions() {
	space_next = null;
	space_previous = null;
	space_directions_normal = array_create(4, null);
	space_directions_reverse = array_create(4, null);

	var paths = ds_list_create();
	var count = instance_place_list(x, y, objPath, paths, false);
	instance_deactivate_object(id);

	for (var i = 0; i < count; i++) {
		var path = paths[| i];
		var space_collide;
		
		with (path) {
			space_collide = instance_place(x, y, objSpaces);
		}

		if (path.x == x + 16 && path.y == y + 16) {
			var space_array = space_directions_normal;
			var invert = 0;
		} else {
			if (path.image_index == 1) {
				continue;
			}
		
			var space_array = space_directions_reverse;
			var invert = 3;
		}
	
		switch ((path.image_angle + 360) % 360) {
			case 90: space_array[@ abs(invert - 0)] = space_collide; break;
			case 0: space_array[@ abs(invert - 1)] = space_collide; break;
			case 180: space_array[@ abs(invert - 2)] = space_collide; break;
			case 270: space_array[@ abs(invert - 3)] = space_collide; break;
		}
	}

	if (array_count(space_directions_normal, null) == 3) {
		space_next = array_first(array_filter(space_directions_normal, function(x) {
			return (x != null);
		}));
	}
	
	if (array_count(space_directions_reverse, null) == 3) {
		space_previous = array_first(array_filter(space_directions_reverse, function(x) {
			return (x != null);
		}));
	}

	if (array_count(space_directions_normal, null) < 3 || array_count(space_directions_reverse, null) < 3) {
		image_index = SpaceType.PathChange;
	}

	instance_activate_object(id);
	ds_list_destroy(paths);
}

space_directions();

space_shine = false;

if (image_index == SpaceType.Shine) {
	space_shine = true;
	image_index = SpaceType.Blue;
}

event = null;
glowing = false;

function space_glow(state) {
	glowing = state;
	
	if (glowing) {
		audio_play_sound(sndSpacePass, 0, false);
	}
}

function space_passing_event() {
	var focus_player = focused_player();
	
	if (room == rBoardWorld) {
		with (focus_player) {
			var player_collide = (is_player_turn()) ? objBoardWorldScott : objPlayerBase;
			var player_collision = collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, player_collide, false, true);
			
			if (player_collision != noone && (is_player_turn() || (player_collision.object_index != objBoardWorldScott && player_collision.object_index != objBoardWorldNega))) {
				board_world_scott_interact();
				return 1;
			}
		}
	}
	
	var space_array = (BOARD_NORMAL) ? space_directions_normal : space_directions_reverse;
	var is_change = (array_count(space_array, null) < 3);
	
	if (!is_player_turn()) {
		if (is_change) {
			next_seed_inline();
			var space_valid = array_filter(space_array, function(x) { return (x != null); });
			space_next = space_valid[irandom(array_length(space_valid) - 1)];
			return 2;
		}
		
		if (array_any([SpaceType.Shop, SpaceType.Blackhole, SpaceType.PathChange], function(x) { return (image_index == x); })) {
			return 2;
		}
		
		with (focus_player) {
			if (collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, objBoardWorldScott, false, true) != noone) {
				return 2;
			}
		}
		
		return 0;
	}
	
	var player_info = player_info_by_turn();
	
	switch (image_index) {
		case SpaceType.Shop:
			call_shop();
			return 1;
			
		case SpaceType.Blackhole:
			call_blackhole();
			return 1;
		
		case SpaceType.Shine:
			if (room != rBoardHyrule || global.board_light) {
				if (room == rBoardBaba) {
					if (!global.baba_toggled[0]) {
						global.shine_price = 20;
					} else {
						switch (global.baba_blocks) {
							case 0: global.shine_price = 40; break;
							case 1: global.shine_price = 10; break;
							case 2: global.shine_price = 0; break;
						}
					}
				}
				
				if (player_info.coins >= global.shine_price) {
					var buy_shine = function() {
						change_coins(-global.shine_price, CoinChangeType.Spend).final_action = function() {
							switch (room) {
								case rBoardIsland:
									if (focused_player().network_id == global.player_id && !global.board_day) {
										if (global.shine_price == 0) {
											achieve_trophy(34);
										}
							
										if (global.shine_price == 40) {
											achieve_trophy(35);
										}
									}
									break;
								
								case rBoardHotland:
									if (instance_number(objShine) > 1 && irandom(1) == 0) {
										board_hotland_annoying_dog();
										return;
									}
									break;
							}
						
							change_shines(1, ShineChangeType.Get).final_action = choose_shine;
						}
					}
				
					start_dialogue([
						new Message("Do you wanna buy a Shine?", shine_ask(buy_shine))
					]);
				} else {
					start_dialogue([
						new Message("You don't have " + draw_coins_price(global.shine_price) + " to buy the Shine!\nCome back later.",, board_advance)
					]);
				
					if (player_info.network_id == global.player_id && player_info.item_used == ItemType.Mirror) {
						achieve_trophy(41);
					}
				}
			} else {
				if (player_info.shines > 0) {
					var buy_shine = function() {
						change_shines(-1, ShineChangeType.Get).final_action = choose_shine;
					}
				} else {
					var buy_shine = function() {
						change_coins(-global.shine_price, CoinChangeType.Lose).final_action = function() {
							change_shines(-1, ShineChangeType.Get).final_action = choose_shine;
						};
					}
				}
				
				start_dialogue([
					new Message("Oh no! The Evil Shine is looking at you menacingly!\nIt won't accept a no for an answer!",, buy_shine)
				]);
				
				if (player_info.network_id == global.player_id && player_info.item_used == ItemType.Mirror) {
					achieve_trophy(50);
				}
			}
			
			return 1;
			
		case SpaceType.PathEvent:
			if (event != null) {
				event();
			} else {
				if (room == rBoardPallet) {
					board_pallet_pokemons();
				}
			}
			
			return 1;
	}
	
	if (is_change) {
		space_choose_path();
		return 1;
	}
	
	if (image_index == SpaceType.PathChange) {
		return 2;
	}
	
	return 0;
}

function space_finish_event() {
	if (!is_player_turn()) {
		with (objBoard) {
			alarm_frames(4, 50);
		}
		
		return;
	}
	
	change_space(image_index);
	var space_give = (global.board_turn <= global.max_board_turns - 5) ? 3 : 6;
	
	if (room == rBoardBaba && global.baba_toggled[1]) {
		switch (global.baba_blocks[1]) {
			case 0: space_give *= 2; break;
			case 1: space_give /= 2; break;
			case 2: space_give = 0; break;
		}
	}
	
	space_give = floor(space_give);
	
	switch (image_index) {
		case SpaceType.Blue:
			var blue_event = turn_next;
			
			if (1 / 50 > random(1)) {
				blue_event = show_chest;
			}
			
			change_coins(space_give, CoinChangeType.Gain).final_action = blue_event;
			
			if (focused_player().network_id == global.player_id && space_number(SpaceType.Blue) < space_number(SpaceType.Red)) {
				achieve_trophy(56);
			}
			break;
			
		case SpaceType.Red:
			change_coins(-space_give, CoinChangeType.Lose).final_action = turn_next;
			bonus_shine_by_id(BonusShines.MostRedSpaces).increase_score();
			
			if (focused_player().network_id == global.player_id && player_info_by_turn().coins == 0) {
				achieve_trophy(23);
			}
			break;
			
		case SpaceType.Green:
			space_give *= 2;
		
			if (irandom(1) == 0) {
				change_coins(space_give, CoinChangeType.Gain).final_action = turn_next;
			} else {
				change_coins(-space_give, CoinChangeType.Lose).final_action = turn_next;
			}
			
			bonus_shine_by_id(BonusShines.MostCoinSpaces).increase_score();
			break;
			
		case SpaceType.Item:
			var rnd = irandom(99);
			
			if (rnd <= 80) {
				var item = choose(ItemType.Poison, ItemType.Cellphone);
			} else if (rnd >= 81 && rnd <= 95) {
				var item = choose(ItemType.DoubleDice, ItemType.TripleDice);
			} else {
				if (room != rBoardWorld) {
					var item = choose(ItemType.Blackhole, ItemType.Mirror);
				} else {
					var item = ItemType.Blackhole;
				}
				
				if (focused_player().network_id == global.player_id) {
					achieve_trophy(60);
				}
			}
		
			change_items(global.board_items[item], ItemChangeType.Gain).final_action = turn_next;
			bonus_shine_by_id(BonusShines.MostItemSpaces).increase_score();
			break;
			
		case SpaceType.ChanceTime:
			start_chance_time();
			bonus_shine_by_id(BonusShines.MostChanceTimeSpaces).increase_score();
			break;
			
		case SpaceType.TheGuy:
			start_the_guy();
			bonus_shine_by_id(BonusShines.MostTheGuySpaces).increase_score();
			break;
	}
}

function space_choose_path() {
	var p = instance_create_layer(0, 0, "Managers", objPathChange);
	p.space = id;
}

function space_number(type) {
	var count = 0;
	
	with (objSpaces) {
		count += (image_index == type);
	}
	
	return count;
}