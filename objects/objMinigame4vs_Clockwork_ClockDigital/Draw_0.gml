if (view_current != network_id - 1) {
	exit;
}

draw_self();
draw_sprite(sprMinigame4vs_Clockwork_DigitalBack, 0, x + border_length, y + border_length);
draw_sprite(sprMinigame4vs_Clockwork_DigitalBack, 0, x + number_length + border_length * 2, y + border_length);
draw_sprite(sprMinigame4vs_Clockwork_DigitalDots, 0, x + number_length * 2 + border_length * 3, y + border_length);
draw_sprite(sprMinigame4vs_Clockwork_DigitalBack, 0, x + number_length * 2 + border_length * 4 + dots_length, y + border_length);
draw_sprite(sprMinigame4vs_Clockwork_DigitalBack, 0, x + number_length * 3 + border_length * 5 + dots_length, y + border_length);

var number_x = x + border_length;
var number_y = y + border_length;
var number_index = 0;
clock_digital_digits_draw(number_x, number_y, number_index, true);

number_x += number_length + border_length;
number_index++;
clock_digital_digits_draw(number_x, number_y, number_index, true);

number_x += number_length + border_length + dots_length + border_length;
number_index++;
clock_digital_digits_draw(number_x, number_y, number_index, true);

number_x += number_length + border_length;
number_index++;
clock_digital_digits_draw(number_x, number_y, number_index, true);