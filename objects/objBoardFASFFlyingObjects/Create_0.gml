/// @desc

sys = part_system_create();
part_system_depth(sys, depth);

typ = part_type_create();
part_type_sprite(typ, sprBoardFASFFlyingObjects, false, false, true);
part_type_life(typ, 600, 600);

part_type_alpha3(typ, 0.5, 0, 0);

part_type_direction(typ, 180, 180, 0, 0);
part_type_speed(typ, 2, 5, 0, 0);

part_type_orientation(typ, 0, 360, random_range(2, 3), 0, 0);
part_type_scale(typ, 2, 2);

//alarm[0] = 1;

alarms_init(1);

// Alarm 0

alarm_create(function() {
	if camera_get_view_width(view_camera[0]) == 800 {
		var camX = camera_get_view_x(view_camera[0]);
		var camY = camera_get_view_y(view_camera[0]);
		part_particles_create(sys, camX + 832, camY + irandom(608), typ, 1);

		alarm_frames(0, irandom_range(25, 300));
	}
	//alarm[0] = irandom_range(25, 300);
});

alarm_call(0, 1);