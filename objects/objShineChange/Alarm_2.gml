///@desc Shine Lose Animation
if (spawned_shine == noone) {
	var focus = focused_player();
	spawned_shine = instance_create_layer(focus.x, focus.y, "Actors", objShine);
	alarm[ShineChangeType.Lose] = get_frames(1);
} else {
	spawned_shine.vspeed = -6;
	alarm[11] = get_frames(1);
}