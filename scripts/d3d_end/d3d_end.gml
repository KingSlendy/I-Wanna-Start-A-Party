/// @description d3d - disable 3d
/// @param enable true if enabled, false if disabled
function d3d_end() {
	var ret = global.__d3d;
	global.__d3d = false;
	gpu_set_ztestenable(false);
	gpu_set_zwriteenable(false);
	return ret;



}
