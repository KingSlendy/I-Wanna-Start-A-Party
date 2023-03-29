if (!global.board_started) {
	exit;
}

//Chooses the target to follow at Begin Step so you can alter it on Step inside another object
try {
	target_follow = focused_player();
} catch (_) {
	target_follow = null;
}