draw_self();

if (selectable && selected != -1 && image_index == 0) {
	draw_sprite(get_skin_pose_object(focus_player_by_id(selected), "Idle"), 0, x - 15, y - 15);
}