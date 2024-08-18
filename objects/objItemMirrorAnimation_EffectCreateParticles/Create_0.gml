image_alpha = 0;
timer_burst = 0;

timer_alpha_black_screen = 0;
duration_alpha_black_screen = 20;

area_rectangle = 2000;

#region Particles
part_system = part_system_create();
part_system_depth(part_system, depth - 1);

part_type[0] = part_type_create();
part_type_sprite(part_type[0], sprItemMirrorAnimation_ParticleEffect, false, false, false);
part_type_life(part_type[0], 100, 100);
part_type_blend(part_type[0], true);
part_type_alpha2(part_type[0], 0.5, 0.2);

part_type_direction(part_type[0], 85, 95, 0, 0);
part_type_speed(part_type[0], 22, 30, 0.1, 0);

part_type_orientation(part_type[0], 0, 0, 0, 0, true);
part_type_scale(part_type[0], 1, 0.5);
part_type_size(part_type[0], 1, 1, -0.0012, 0);

part_type[1] = part_type_create();
part_type_sprite(part_type[1], sprItemMirrorAnimation_ParticleEffect, false, false, false);
part_type_life(part_type[1], 100, 100);
part_type_blend(part_type[1], true);
part_type_alpha2(part_type[1], 0.5, 0.2);

part_type_direction(part_type[1], 265, 275, 0, 0);
part_type_speed(part_type[1], 22, 30, 0.1, 0);

part_type_orientation(part_type[1], 0, 0, 0, 0, true);
part_type_scale(part_type[1], 1, 0.5);
part_type_size(part_type[1], 1, 1, -0.0012, 0);
#endregion