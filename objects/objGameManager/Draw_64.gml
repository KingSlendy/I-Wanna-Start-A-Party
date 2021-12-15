draw_set_color(c_white);

if (room == rTitle) {
	draw_text(0, 0, "Host List: " + string(global.player_list_host));
	draw_text(0, 16, "Client List: " + string(global.player_list_client));
	draw_text(0, 32, "Player ID: " + string(global.player_id));
}