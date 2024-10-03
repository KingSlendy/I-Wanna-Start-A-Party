///@description Burst rain
repeat (5) {
	part_particles_create(part_system, irandom_range(0, room_width + 300), -8, part_type, 1);	
}

alarm[0] = 3;