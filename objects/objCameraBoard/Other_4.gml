event_perform(ev_step, ev_step_begin);

try {
	if (target_follow != null) {
		view_x = target_follow.x;
		view_y = target_follow.y;
	}
} catch (ex) {
	log_error(ex);
}