draw_set_color(c_white);

if (room == rTemplate) {
	draw_text(0, 0, "Client List: " + string(global.player_client_list));
	draw_text(0, 16, "Player ID: " + string(global.player_id));
}