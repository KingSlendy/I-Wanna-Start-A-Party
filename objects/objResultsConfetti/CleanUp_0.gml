/// @desc Free particles
try {
	part_particles_clear(ps);
} catch (_) {}

part_emitter_destroy_safe(ps, pe1);
part_type_destroy_safe(pt1);
part_system_destroy_safe(ps);