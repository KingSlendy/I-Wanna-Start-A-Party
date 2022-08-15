event_inherited();
animation_type = -1;
animation_amount = 0;
animation_alpha = 0;
animation_state = 0;
final_action = null;
amount = 0;

alarms_init(12);

alarm_create(function() {
	alarm_frames(animation_type, 1);
});

alarm_frames(0, 1);