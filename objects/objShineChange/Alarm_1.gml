///@desc Shine Get Animation
if (spawned_shine == noone) {
	with (focus_player_by_id(network_id)) {
		other.spawned_shine = instance_nearest(x, y, objShine);
	}
		
	if (room == rBoardHotland) {
		with (objShine) {
			if (id != other.spawned_shine) {
				losing = true;
				faker = true;
				break;
			}
		}
	}
}

spawned_shine.floating = false;
spawned_shine.getting = true;
spawned_shine = noone;