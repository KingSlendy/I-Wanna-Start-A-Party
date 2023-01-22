network_id = 0;
network_name = "";
network_mode = PlayerDataMode.Heartbeat;
skin = null;
ai = false;
online = true;
draw = true;
lost = false;
frozen = false;

function change_to_object(obj) {
	if (object_index == objNetworkPlayer) {
		return null;
	}
	
	var a = instance_create_layer(x, y, "Actors", obj);
	a.ai = ai;
	a.network_id = network_id;
	a.network_name = network_name;
	a.skin = skin;
	instance_destroy();
	
	return a;
}

//function change_to_dummy() {
//	var a = instance_create_layer(x, y, "Actors", objPlayerDummy);
//	a.ai = ai;
//	a.network_id = network_id;
//	a.network_name = network_name;
//	a.skin = skin;
//	a.sprite_index = sprite_index;
//	a.image_index = image_index;
//	a.image_xscale = image_xscale;
//	instance_destroy();
//}

alarms_init(12);

alarm_create(11, function() {
	if (network_id == global.player_id || !online) {
		return;
	}
	
	player_leave(network_id);
	network_name = "Left";
});