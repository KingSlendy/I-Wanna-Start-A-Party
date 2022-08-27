switch (room) {
	case rBoardIsland:
		if (!global.board_day) {
			sprite_index = sprShineNight;
			exit;
		}
		break;
		
	case rBoardHyrule:
		if (!global.board_light) {
			sprite_index = sprShineEvil;
			exit;
		}
		break;
}

sprite_index = sprShine;