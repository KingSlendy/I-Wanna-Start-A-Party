/// @desc Free particles
part_particles_clear(ps);

part_emitter_destroy_safe(ps, pe1);
part_emitter_destroy_safe(ps, pe2);
part_type_destroy_safe(pt1);
part_type_destroy_safe(pt2);
part_system_destroy_safe(ps);