event_inherited();

action_end = function() {
	alarm_stop(4);
}

player_type = objPlayerPlatformer;

alarm_override(1, function() {
	alarm_inherited(1);
	alarm_instant(4);
});

alarm_create(4, function() {
	
});