depth = layer_get_depth("Tiles") - 1;
idol = -1;
portion = 0;
show = -1;
spd = 0;
hit = 0;
width = sprite_get_width(sprMinigame2vs2_Idol_Idol);
height = sprite_get_height(sprMinigame2vs2_Idol_Idol);

function change_idol() {
	next_seed_inline();
	idol = irandom(sprite_get_number(sprMinigame2vs2_Idol_Idol) - 2);
	//image_index = idol;
	show = 0;
	spd = irandom_range(1, 3);
	hit = 0;
	alarm_call(0, random_range(2, 4));
}

function hide_idol() {
	next_seed_inline();
	show = 1;
	spd = 1;
	alarm_call(1, random_range(2, 4));
}

function whac_idol(player_id, network = true) {
	idol = sprite_get_number(sprMinigame2vs2_Idol_Idol) - 1;
	hit = player_id;
	hide_idol();
	minigame4vs_points(player_id, 1);
	audio_play_sound(sndMinigame2vs2_Idol_Bonk, 0, false);
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame2vs2_Idol_WhacIdol);
		buffer_write_data(buffer_s32, x);
		buffer_write_data(buffer_s32, y);
		buffer_write_data(buffer_u8, player_id);
		network_send_tcp_packet();
	}
}

alarms_init(2);

alarm_create(function() {
	hide_idol();
});

alarm_create(function() {
	change_idol();
});

change_idol();