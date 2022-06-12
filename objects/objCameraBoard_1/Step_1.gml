if (!global.board_started) {
	exit;
}

//Chooses the target to follow at Begin Step so you can alter it on Step inside another object
target_follow = focused_player();