if (info.is_finished) {
	exit;
}

var all_warps = true;
		
with (objMinigame4vs_Dizzy_Warp) {
	if (!trophy) {
		all_warps = false;
		break;
	}
}
		
if (all_warps) {
	gain_trophy(43);
}