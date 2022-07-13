gravity = 0.3;
pushable = true;

function push_block(player) {
	if (!pushable || player.bbox_bottom <= bbox_top) {
		return;
	}
	
	x += 2 * sign(player.hspd);
}