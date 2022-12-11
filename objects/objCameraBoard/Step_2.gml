view_spd = (!instance_exists(objChooseShine)) ? 0.2 : 0.05;
event_inherited();

with (objBoard) {
	event_perform(ev_step, ev_step_end);
}