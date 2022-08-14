if (BOARD_NORMAL) {
	space.space_next = arrows[arrow_selected].space_next;
} else {
	space.space_previous = arrows[arrow_selected].space_previous;
}

instance_destroy(objArrow);
board_advance();