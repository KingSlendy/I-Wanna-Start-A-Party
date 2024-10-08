var player = other;

if (!is_player_local(player.network_id)) {
	exit;
}

if (ID != 0) {
    if (other.lapCheckPoint == ID - 1) {
        other.lapCheckPoint = ID;
        other.checkX = checkX;
        other.checkY = checkY;
        other.checkDir = checkDir;
        //with (objKartsGame)
            //event_user(5)
    }
} else if (other.lapCheckPoint == numCPs - 1) {
    other.checkX = checkX;
    other.checkY = checkY;
    other.checkDir = checkDir;
	other.lapCheckPoint = 0;
	
	with (objMinigameController) {
		kart_count_lap(player.network_id);
	}
	
    //with (objKartsGame)
        //event_user(5)
}