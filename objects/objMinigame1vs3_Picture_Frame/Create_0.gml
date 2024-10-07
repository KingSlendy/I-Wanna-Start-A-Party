picture_border = 18;
picture_length = 298;
picture_divisions = (x < 400) ? 2 : 3;
picture_divisions_length = picture_length / picture_divisions
picture_divisions_alpha = 1;
picture_divisions_fade = false;
picture_divisions_cover = 0;
picture_divisions_cover_alpha = 1;

picture_rotate = false;
picture_travel = 1;

alarms_init(2);

alarm_create(function() {
	picture_rotate = true;
	alarm_call(0, 1);
});

alarm_create(function() {
	picture_divisions_cover = 1;
});

function picture_section_toggle(r, c, section_locked, section_current, network = true) {
	picture_locked[r][c] = section_locked;
	picture_current[r][c] = section_current;
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame1vs3_Picture_PictureSectionToggle);
		buffer_write_data(buffer_s16, x);
		buffer_write_data(buffer_u8, r);
		buffer_write_data(buffer_u8, c);
		buffer_write_data(buffer_bool, section_locked);
		buffer_write_data(buffer_u8, section_current);
		network_send_tcp_packet();
	}
}