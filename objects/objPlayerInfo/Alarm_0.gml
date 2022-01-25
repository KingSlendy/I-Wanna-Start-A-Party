draw_x = 0;
draw_y = 0;

switch (player_info.turn) {
	case 1:
		draw_x = 0;
		draw_y = 0;
		break;
		
	case 2:
		draw_x = display_get_gui_width() - draw_w;
		draw_y = 0;
		break;
		
	case 3:
		draw_x = 0;
		draw_y = display_get_gui_height() - draw_h;
		break;
		
	case 4:
		draw_x = display_get_gui_width() - draw_w;
		draw_y = display_get_gui_height() - draw_h;
		break;
		
	default: exit;
}

main_draw_x = draw_x;
main_draw_y = draw_y;