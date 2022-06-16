if (!IS_ONLINE || room != rParty) {
	instance_destroy();
	exit;
}

with (objPlayerBase) {
	change_to_object(objPlayerBoardID);
}

sent_id = false;
sent_data = false;
