width = 400;
height = 300;
stock = [];

if (is_player_turn()) {
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

	stock[0] = global.board_items[ItemType.Reverse];
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
player_turn_info = get_player_turn_info();
offset_target = 1;
offset_pos = 0;
offset_y = -454;

function shop_end() {
	offset_target = 0;
	
	if (is_player_turn()) {
		buffer_seek_begin();
		buffer_write_action(Client_TCP.EndShop);
		network_send_tcp_packet();
	}
}

if (is_player_turn()) {
	buffer_seek_begin();
	buffer_write_action(Client_TCP.ShowShop);
	
	for (var i = 0; i < array_length(stock); i++) {
		buffer_write_data(buffer_u8, stock[i].id);
	}
	
	network_send_tcp_packet();
}