event_inherited();

with (objPlayerBase) {
	ypos = y;
	
	with (objMinigame2vs2_Jingle_Sledge) {
		if ((other.y < 304 && y > 304) || (other.y > 304 && y < 304)) {
			continue;
		}
			
		other.sledge = id;
	}
}