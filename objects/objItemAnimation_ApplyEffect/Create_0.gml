x_margin = 10;
y_target = ystart - 16;
xx = {p_min: x - x_margin, p_max: x + x_margin};
yy = {p_min: y, p_max: y};

gradient_effect_duration = 30;
timer_spawn_particles = [10, 50]; 
steps_spawn_particles = 3;
fade_out = [60, 100];
total_duration = 180;
timer = 0;

dire_range = 5;
angle_random = 10;

#region Particles
part_system = part_system_create();
part_system_depth(part_system, depth);

part_type = part_type_create();
part_type_sprite(part_type, particle_sprite, false, false, false);
part_type_color2(part_type, image_blend, c_white);
part_type_alpha3(part_type, 0.1, 0.7, 0);
part_type_life(part_type, 10, 80);
part_type_size(part_type, 0.75, 1, 0, 0);
part_type_speed(part_type, 1, 2, 0, 0);
part_type_direction(part_type, 90 - dire_range, 90 + dire_range, 0, 0);
part_type_orientation(part_type, -angle_random, angle_random, 0, 2, false);
part_type_blend(part_type, false);
#endregion

function spawn_particles() {
	var random_x = irandom_range(xx.p_min, xx.p_max);
	part_particles_create(part_system, random_x, yy.p_min, part_type, 1);
}