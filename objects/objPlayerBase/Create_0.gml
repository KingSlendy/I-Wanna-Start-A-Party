network_id = 0;
network_name = "CPU";
skin = get_skin();
ai = false;
send_timer = 0;

function change_to_object(obj) {
	if (object_index != objNetworkPlayer) {
		var a = instance_create_layer(x, y, "Actors", obj);
		a.ai = ai;
		a.network_id = network_id;
		a.network_name = network_name;
		a.skin = skin;
		instance_destroy();
	}
}

alarm[0] = 1;