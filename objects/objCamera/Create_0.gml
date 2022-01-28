with (objPlayerReference) {
	if (reference == 1) {
		other.target_follow = id;
		break;
	}
}

view_x = target_follow.x;
view_y = target_follow.y;
target_x = view_x;
target_y = view_y;