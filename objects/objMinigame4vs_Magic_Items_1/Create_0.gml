depth = 500;

if (order >= 0) {
	image_index = objMinigameController.item_order[order];
	
	with (instance_create_layer(x, y, "Actors", objMinigame4vs_Magic_Holder)) {
		order = other.order;
	}
} else {
	image_index = objMinigameController.mimic_order[abs(order) - 1];
	next_seed_inline();
	x += irandom_range(-32, 32);
}

player_turn = 0;
player = null;
hspd = 0;
vspd = 0;
grav = 0;
held = false;
grab = true;
state = -1;

function hold_item(network = true) {
	var holder = instance_place(x, y, objMinigame4vs_Magic_Holder);
	
	if (holder != noone) {
		holder.item = -1;
	}
	
	with (object_index) {
		if (player_turn == other.player_turn) {
			grab = false;
		}
	}
	
	held = true;
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame4vs_Magic_Hold);
		buffer_write_data(buffer_u8, player_turn);
		buffer_write_data(buffer_s8, order);
		network_send_tcp_packet();
	}
}

function release_item(place = true, network = true) {
	var holder = instance_place(x, y, objMinigame4vs_Magic_Holder);
	
	if (holder != noone && holder.item == -1) {
		if (place) {
			x = holder.x;
			y = holder.y;
		}
		
		holder.item = order;
	} else {
		grav = 0.1;
	}
	
	held = false;
	
	with (object_index) {
		if (player_turn == other.player_turn) {
			grab = true;
		}
	}
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame4vs_Magic_Release);
		buffer_write_data(buffer_u8, player_turn);
		buffer_write_data(buffer_s8, order);
		buffer_write_data(buffer_s32, x);
		buffer_write_data(buffer_s32, y);
		network_send_tcp_packet();
	}
}
