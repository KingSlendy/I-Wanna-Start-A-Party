event_inherited();
width = 400;
height = 300;
stock = [];

if (is_local_turn()) {
	for (var i = 0; i < array_length(global.board_items); i++) {
		stock[i] = global.board_items[i];
	}

	array_shuffle(stock);

	var has_lowest = false;

	for (var i = 0; i < 5; i++) {
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
	
	if (room == rBoardNsanity) {
		for (var i = 0; i < 5; i++) {
			if (stock[i].id == ItemType.Reverse) {
				array_delete(stock, i, 1);
				break;
			}
		}
	}

	//stock[0] = global.board_items[ItemType.ItemBag];
	array_resize(stock, 5);

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

if (focused_player().ai) {
	var coins = player_info_by_turn().coins;
	var length = array_length(stock);

	while (global.buy_choice == -1) {
		for (var i = length - 1; i >= 0; i--) {
			var price = stock[i].price;
		
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