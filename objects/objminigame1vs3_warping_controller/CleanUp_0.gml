event_inherited();
surface_free(surf);
part_emitter_destroy_safe(part_system, part_emitter);
part_type_destroy_safe(part_type);
part_system_destroy_safe(part_system);