var hole_x = current_player.x;
var hole_y = current_player.y - 50;
var spawn_angle = irandom(359);
var spawn_x = hole_x + 50 * dcos(spawn_angle);
var spawn_y = hole_y + 50 * dsin(spawn_angle);
var spawn_dir = point_direction(spawn_x, spawn_y, hole_x, hole_y);

var part_type = part_type_create();
part_type_shape(part_type, pt_shape_circle);
part_type_alpha3(part_type, 0, 1, 0);
part_type_color1(part_type, c_gray);
part_type_speed(part_type, 2, 2, 0, 0);
part_type_direction(part_type, spawn_dir, spawn_dir, 0, 0);
part_type_life(part_type, 25, 25);
part_particles_create(global.part_system, spawn_x, spawn_y, part_type, 1);
part_type_destroy(part_type);

alarm[1] = 4;