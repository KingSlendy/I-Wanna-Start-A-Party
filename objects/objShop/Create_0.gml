event_inherited();
width = 400;
height = 300;
stock = [];
stock_total = 5;
timer = 0;

if (is_local_turn()) {
	for (var i = 0; i < array_length(global.board_items); i++) {
		stock[i] = global.board_items[i];
	}

	while (true) {
		array_shuffle_ext(stock);
		var cancel_loop = true;
		
		for (var i = 0; i < stock_total; i++) {
			var item = stock[i];
			
			if (array_contains(item.ignore_in, room)) {
				cancel_loop = false;
				break;
			}
		}
		
		if (cancel_loop) {
			break;
		}
	}

	var has_lowest = false;

	for (var i = 0; i < stock_total; i++) {
		if (stock[i].price == 5) {
			has_lowest = true;
			break;
		}
	}

	if (!has_lowest) {
		for (var i = 5; i < array_length(stock); i++) {
			if (stock[i].price == 5) {
				stock[0] = stock[i];
				break;
			}
		}
	}

	//stock[0] = global.board_items[ItemType.ItemBag];
	array_resize(stock, stock_total);

	var swaps = 1;

	while (swaps > 0) {
		swaps = 0;
	
		for (var i = 0; i < array_length(stock) - 1; i++) {
			if (stock[i].price > stock[i + 1].price) {
				var temp = stock[i + 1];
				stock[i + 1] = stock[i];
				stock[i] = temp;
				swaps++;
			}
		}
	}
}

option_selected = -1;
option_previous = 0;
item_selected = -1;
shopping = true;
player_info = player_info_by_turn();
offset_target = 1;
offset_pos = 0;
offset_y = -454;

if (is_local_turn() && focused_player().ai) {
	var coins = player_info_by_turn().coins;
	var length = array_length(stock);

	while (global.buy_choice == -1) {
		for (var i = length - 1; i >= 0; i--) {
			var price = stock[i].price;
			
			if (room == rBoardBaba && global.baba_toggled[2]) {
				switch (global.baba_blocks[2]) {
					case 0: price *= 2; break;
					case 1: price /= 2; break;
					case 2: price = 0; break;
				}
			
				price = floor(price);
			}
		
			if (coins >= price && (coins - price >= 20 || irandom(length - ((length - 1) - i)) == 1)) {
				global.buy_choice = i;
				break;
			}
		}
	
		if (coins < 60) {
			break;
		}
	}
}

function shop_end() {
	offset_target = 0;
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.EndShop);
		network_send_tcp_packet();
	}
}

if (is_local_turn()) {
	buffer_seek_begin();
	buffer_write_action(ClientTCP.ShowShop);
	
	for (var i = 0; i < array_length(stock); i++) {
		buffer_write_data(buffer_u8, stock[i].id);
	}
	
	network_send_tcp_packet();
}

with (objDialogue) {
	active = false;
	endable = false;
}