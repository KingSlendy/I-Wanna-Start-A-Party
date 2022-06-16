event_inherited();
flag = -1;
sprites = [];
indexes = false;

box_activate = function() {
	if (!indexes) {
		var sprite = show_sprites[0];
		var index = 0;
	} else {
		var sprite = sprChanceTimeExchanges;
		var index = show_sprites[0];
	}
	
	with (objChanceTime) {
		if (array_contains(player_ids, null)) {
			player_ids[array_index(player_ids, null)] = array_index(all_player_sprites(), sprite);
		} else {
			event = events[index];
		}
	}
	
	var c = instance_create_layer(x - 16, y - 37, "Actors", objChanceTimeChoice);
	c.flag = flag;
	c.sprite = sprite;
	c.index = index;
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.HitChanceTimeBox);
		buffer_write_data(buffer_u16, show_sprites[0]);
		network_send_tcp_packet();
	}
	
	instance_destroy();
}

sprites = [];
show_sprites = array_create(3, null);
surf = noone;
yy = -32;
roulette = true;