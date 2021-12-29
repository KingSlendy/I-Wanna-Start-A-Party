draw_set_color(c_white);

if (room == rTitle) {
	draw_text(0, 0, "Client List: " + string(global.player_list_client));
	draw_text(0, 16, "Player ID: " + string(global.player_id));
}