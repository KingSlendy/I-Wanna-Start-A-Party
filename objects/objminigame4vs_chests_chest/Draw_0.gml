draw_sprite_ext(sprite_index, image_index, x, y + lengthdir_y(30, angle), image_xscale, image_yscale, image_angle, image_blend, image_alpha);

if (selectable && selected != -1 && image_index == 0) {
	draw_sprite(get_skin_pose_object(focus_player_by_id(selected), "Idle"), 0, x - 15, y - 15);
}