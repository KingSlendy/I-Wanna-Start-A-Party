var border_length = 9;
var number_length = sprite_get_width(sprMinigame4vs_Clockwork_DigitalBack);
var dots_length = sprite_get_width(sprMinigame4vs_Clockwork_DigitalDots);

draw_self();
draw_sprite(sprMinigame4vs_Clockwork_DigitalBack, 0, x + border_length, y + border_length);
draw_sprite(sprMinigame4vs_Clockwork_DigitalBack, 0, x + number_length + border_length * 2, y + border_length);
draw_sprite(sprMinigame4vs_Clockwork_DigitalDots, 0, x + number_length * 2 + border_length * 3, y + border_length);
draw_sprite(sprMinigame4vs_Clockwork_DigitalBack, 0, x + number_length * 2 + border_length * 4 + dots_length, y + border_length);
draw_sprite(sprMinigame4vs_Clockwork_DigitalBack, 0, x + number_length * 3 + border_length * 5 + dots_length, y + border_length);

var numbers_draw = function(number_x, number_y, number_index) {
	for (var i = 0; i < number_sections; i++) {
		if (!numbers[number_index][i]) {
			continue;
		}
	
		draw_sprite(sprMinigame4vs_Clockwork_DigitalNumber, i, number_x, number_y);
	}
}

var number_x = x + border_length;
var number_y = y + border_length;
var number_index = 0;
numbers_draw(number_x, number_y, number_index);

number_x += number_length + border_length;
number_index++;
numbers_draw(number_x, number_y, number_index);

number_x += number_length + border_length + dots_length + border_length;
number_index++;
numbers_draw(number_x, number_y, number_index);

number_x += number_length + border_length;
number_index++;
numbers_draw(number_x, number_y, number_index);