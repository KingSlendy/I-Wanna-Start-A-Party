width = 400;
height = 300;

with (objDialogue) {
	text_change("Welcome!");
}

stock = [];

for (var i = 0; i < array_length(global.shop_items); i++) {
	array_push(stock, i);
}

array_shuffle(stock);
array_resize(stock, 5);

for (var i = 0; i < array_length(stock); i++) {
	stock[i] = global.shop_items[stock[i]];
}

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

option_selected = -1;