part_sys = part_system_create();
part_system_depth(part_sys, layer_get_depth("Background") - 1);

var c1 = 16777215;
var c2 = 12632256;
var c3 = 4235519;
var c4 = 255;

part_cloud_type = part_type_create();
part_type_shape(part_cloud_type, pt_shape_cloud);
part_type_size(part_cloud_type, 5, 7, 0, 0);
part_type_color2(part_cloud_type, c1, c2);
part_type_alpha3(part_cloud_type, 0.1, 0.2, 0.1);
part_type_speed(part_cloud_type, 0.4, 0.8, 0.005, 0);
part_type_direction(part_cloud_type, 180, 180, 0, 2);
part_type_orientation(part_cloud_type, -5, 5, 0, 0, 0);
part_type_life(part_cloud_type, 600, 700);

part_cloud_type2 = part_type_create();
part_type_shape(part_cloud_type2, pt_shape_cloud);
part_type_size(part_cloud_type2, 4, 8, 0, 0);
part_type_color2(part_cloud_type2, c2, c1);
part_type_alpha3(part_cloud_type2, 0.2, 0.1, 0.2);
part_type_speed(part_cloud_type2, 0.5, 1, 0.005, 0);
part_type_direction(part_cloud_type2, 180, 180, 0, 2);
part_type_orientation(part_cloud_type2, -5, 5, 0, 0, 0);
part_type_life(part_cloud_type2, 600, 700);

part_leaf_type = part_type_create();
part_type_sprite(part_leaf_type, sprMinigame2vs2_Stacking_Leaf, false, false, false);
part_type_alpha1(part_leaf_type, 0.5);
part_type_life(part_leaf_type, 200, 200);
part_type_size(part_leaf_type, 1, 1, 0, 0);
part_type_speed(part_leaf_type, 3, 4, 0.05, 0);
part_type_direction(part_leaf_type, 190, 220, 0, 5);
part_type_orientation(part_leaf_type, 0, 360, 1.3194, 0.6044, 0);
part_type_gravity(part_leaf_type, 0, 270);
part_type_blend(part_leaf_type, 0);

part_cloud_emitter = part_emitter_create(part_sys);
part_emitter_region(part_sys, part_cloud_emitter, (room_width + 350), (room_width + 350), -50, (room_height + 50), ps_shape_diamond, ps_distr_linear);
part_emitter_stream(part_sys, part_cloud_emitter, part_cloud_type, -25);

part_cloud_emitter2 = part_emitter_create(part_sys);
part_emitter_region(part_sys, part_cloud_emitter2, (room_width + 350), (room_width + 350), -50, (room_height + 50), ps_shape_diamond, ps_distr_linear);
part_emitter_stream(part_sys, part_cloud_emitter2, part_cloud_type2, -20);

part_leaf_emitter = part_emitter_create(part_sys);
part_emitter_region(part_sys, part_leaf_emitter, 800, 800, -200, 600, ps_shape_rectangle, ps_distr_linear);
part_emitter_stream(part_sys, part_leaf_emitter, part_leaf_type, -5);
	
repeat (game_get_speed(gamespeed_fps) * 30) {
    part_system_update(part_sys);
}