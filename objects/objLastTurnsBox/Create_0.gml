event_inherited();

box_activate = function() {
	var sprite = sprLastTurnsEvents;
	var index = show_sprites[0];
	objLastTurns.event = index;
	
	var c = instance_create_layer(x - 16, y - 37, "Actors", objLastTurnsChoice);
	c.sprite = sprite;
	c.index = index;
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.HitLastTurnsBox);
		buffer_write_data(buffer_u16, show_sprites[0]);
		network_send_tcp_packet();
	}
	
	audio_play_sound(sndChanceTime, 0, false);
	instance_destroy();
}

sprites = array_sequence(0, sprite_get_number(sprLastTurnsEvents));
show_sprites = array_create(3, null);
surf = noone;
yy = -32;
roulette = true;