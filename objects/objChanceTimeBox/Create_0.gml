event_inherited();
flag = -1;
sprites = [];
indexes = false;

box_activate = function() {
	var sprite = show_sprites[0];
	objChanceTime.player_ids[flag] = array_index(sprites, sprite);
	var c = instance_create_layer(x - 16, y - 32, "Actors", objChanceTimeChoice);
	c.flag = flag;
	c.sprite = sprite;
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.HitChanceTimeBox);
		buffer_write_data(buffer_u16, c.sprite);
		network_send_tcp_packet();
	}
	
	instance_destroy();
}

sprites = [];
show_sprites = array_create(3, null);
surf = noone;
yy = -32;
roulette = true;