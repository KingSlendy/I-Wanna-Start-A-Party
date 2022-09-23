angle_interval = 15;
angle_speed = 0.3;

part_system = part_system_create();
part_system_depth(part_system, depth);

part_type = part_type_create();
part_type_sprite(part_type, sprMinigame4vs_Haunted_LightEffect, 0, 0, 0);
part_type_alpha3(part_type, 0, 0.2, 0);
part_type_blend(part_type, true);
part_type_orientation(part_type, 180 - angle_interval, 180 + angle_interval, angle_speed, 0, 0);
part_type_scale(part_type, 1, 2);
part_type_life(part_type, 100, 100);
part_type_size(part_type, 1, 1, -0.0001, 0);

part_type2 = part_type_create();
part_type_sprite(part_type2,sprMinigame4vs_Haunted_LightEffect, 0, 0, 0);
part_type_alpha3(part_type2, 0, 0.2, 0);
part_type_blend(part_type2, true);
part_type_orientation(part_type2, 180 - angle_interval, 180 + angle_interval, -angle_speed, 0, 0);
part_type_scale(part_type2, 1, 2);
part_type_life(part_type2, 100, 100);
part_type_size(part_type2, 1, 1, -0.0001, 0);

alarms_init(1);

alarm_create(function() {
	part_type_orientation(part_type, 180 - angle_interval, 180 + angle_interval, angle_speed, 0, 0);
	part_type_orientation(part_type2, 180 - angle_interval, 180 + angle_interval, -angle_speed, 0, 0);
	part_particles_create(part_system, x + 32, y, part_type, 1);
	part_particles_create(part_system, x + 32, y, part_type2, 1);

	alarm_call(0, 0.18);
})

alarm_instant(0);