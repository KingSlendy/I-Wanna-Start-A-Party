depth = layer_get_depth("Tiles") - 1;
image_index = objMinigameController.item_order[order];

player_turn = 0;
player = null;
hspd = 0;
vspd = 0;
grav = 0;
held = false;
grab = true;
pedestal = false;
state = -1;
audio_played = false;
pitch_range = 0.1;

function init_item() {
	giver = instance_place(x, y, objMinigame4vs_Magic_GiverID);

	if (giver != noone && giver.player_turn != 0) {
		player_turn = giver.player_turn;
		player = focus_player_by_turn(player_turn);
	}

	with (instance_create_layer(x, y, "Actors", objMinigame4vs_Magic_Holder)) {
		order = other.order;
	
		if (other.player != null) {
			network_id = other.player.network_id;
		}
	}
}

function hold_item(network = true) {
	var holder = instance_place(x, y, objMinigame4vs_Magic_Holder);
	
	if (holder != noone) {
		holder.item = -1;
		pedestal = false;
	}
	
	with (object_index) {
		if (player_turn == other.player_turn) {
			grab = false;
		}
	}
	
	vspd = 0;
	held = true;
	player.item = id;
	// Audio
	if !audio_played
	{
		audio_play_sound(sndMinigame4vs_Magic_GrabItem, 0, false, 1, , 1 + random_range(-pitch_range, pitch_range));
		audio_played = true;	
	}
	
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
			grav = 0;
		}
		
		holder.item = order;
		pedestal = true;
	} else {
		grav = 0.1;
	}
	
	with (object_index) {
		if (player_turn == other.player_turn) {
			grab = true;
		}
	}
	
	vspd = 0;
	held = false;
	player.item = null;
	
	// Audio
	audio_play_sound(sndMinigame4vs_Magic_DropItem, 0, false, 1, , 1 + random_range(-pitch_range, pitch_range));
	audio_played = false;	
	
	
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