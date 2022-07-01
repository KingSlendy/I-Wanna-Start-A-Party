///@desc Shine Get Animation
if (spawned_shine == noone) {
	spawned_shine = objShine;
	
	if (room == rBoardHotland) {
		with (focus_player) {
			other.spawned_shine = instance_nearest(x, y, objShine);
		}
		
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