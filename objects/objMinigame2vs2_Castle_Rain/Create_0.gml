part_system = part_system_create();
part_system_layer(part_system, layer);

part_type = part_type_create();

part_type_sprite(part_type, sprMinigame2vs2_Castle_Rain, 0, 0, 0);
part_type_blend(part_type, true);
part_type_life(part_type, 100, 150);

part_type_speed(part_type, 10, 14, 0.05, 0);
part_type_direction(part_type, 245 - 10, 245 + 10, 0, 0.4);
part_type_orientation(part_type, 0, 0, 0, 0, true);

part_type_alpha1(part_type, 0.2);
part_type_scale(part_type, 1.5, 1);
part_type_size(part_type, 1, 1.5, 0, 0);
part_type_color_mix(part_type, c_grey, c_white);

repeat (10) {
	part_system_update(part_system);	
}

alarm[0] = 1;