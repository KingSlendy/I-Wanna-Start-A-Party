/// @desc Free particles and alarms
//alarm_stop(0);

if part_type_exists(typ) {
	part_type_destroy(typ);
	print($"{object_get_name(object_index)}: particle type destroyed");
}
	
if part_system_exists(sys) {
	part_system_destroy(sys);
	print($"{object_get_name(object_index)}: particle system destroyed");
}

alarms_destroy();