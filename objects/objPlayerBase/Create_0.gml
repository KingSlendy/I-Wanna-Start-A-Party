network_id = 0;
ai = false;

function change_to_object(obj) {
	var a = instance_create_layer(x, y, layer, obj);
	a.ai = ai;
	a.network_id = network_id;
	instance_destroy();
	
	with (objPlayerBase) {
		if (ai && object_index != obj) {
			change_to_object(obj);
		}
	}
}