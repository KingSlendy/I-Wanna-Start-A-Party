depth = (!instance_exists(objTheGuy)) ? -9002 : -9005;
image_alpha = 0;
event_perform(ev_step, ev_step_begin);
spawning = true;
floating = false;
y_float = 0;
angle_float = 0;
dir_y_float = 0;
dir_angle_float = 90;
getting = false;
losing = false;
changing = false;
faker = false;

function shine_nearest_vessel() {
	if (!changing) {
		return noone;
	}
	
	if (room != rBoardPallet) {
		return instance_nearest_any(x, y, objSpaces, function(x) { return (x.space_shine && x.image_index == SpaceType.Shine); });
	} else {
		return instance_nearest_any(x, y, objBoardPalletPokemon, function(x) { return (x.has_shine()); });
	}
}