event_inherited();

minigame_camera = CameraMode.Split4;
points_draw = true;

player_type = objPlayerStatic;

part_system = part_system_create();

part_type_wood_crate = part_type_create();
part_type_sprite(part_type_wood_crate, sprCratePart, false, false, false);
part_type_scale(part_type_wood_crate, 0.5, 1);
part_type_size(part_type_wood_crate, 0.5, 0.5, 0, 0);
part_type_blend(part_type_wood_crate, true);
part_type_orientation(part_type_wood_crate, 0, 359, 7, 0, false);
part_type_direction(part_type_wood_crate, 45, 135, 0, 0);
part_type_speed(part_type_wood_crate, 1, 2, 0, 0);
part_type_gravity(part_type_wood_crate, 0.1, 270);
part_type_alpha2(part_type_wood_crate, 1, 0);
part_type_life(part_type_wood_crate, 60, 60);

part_type_wood_tnt = part_type_create();
part_type_sprite(part_type_wood_tnt, sprCratePart, false, false, false);
part_type_scale(part_type_wood_tnt, 0.5, 1);
part_type_size(part_type_wood_tnt, 0.5, 0.5, 0, 0);
part_type_blend(part_type_wood_tnt, true);
part_type_colour1(part_type_wood_tnt, c_red);
part_type_orientation(part_type_wood_tnt, 0, 359, 7, 0, false);
part_type_direction(part_type_wood_tnt, 45, 135, 0, 0);
part_type_speed(part_type_wood_tnt, 1, 2, 0, 0);
part_type_gravity(part_type_wood_tnt, 0.1, 270);
part_type_alpha2(part_type_wood_tnt, 1, 0);
part_type_life(part_type_wood_tnt, 60, 60);

part_type_wood_nitro = part_type_create();
part_type_sprite(part_type_wood_nitro, sprCratePart, false, false, false);
part_type_scale(part_type_wood_nitro, 0.5, 1);
part_type_size(part_type_wood_nitro, 0.5, 0.5, 0, 0);
part_type_blend(part_type_wood_nitro, true);
part_type_colour1(part_type_wood_nitro, c_lime);
part_type_orientation(part_type_wood_nitro, 0, 359, 7, 0, false);
part_type_direction(part_type_wood_nitro, 45, 135, 0, 0);
part_type_speed(part_type_wood_nitro, 1, 2, 0, 0);
part_type_gravity(part_type_wood_nitro, 0.1, 270);
part_type_alpha2(part_type_wood_nitro, 1, 0);
part_type_life(part_type_wood_nitro, 60, 60);

part_type_explosion_tnt = part_type_create();
part_type_shape(part_type_explosion_tnt, pt_shape_sphere);
part_type_size(part_type_explosion_tnt, 0.2, 0.3, 0, 0);
part_type_blend(part_type_explosion_tnt, true);
part_type_colour1(part_type_explosion_tnt, c_orange);
part_type_alpha3(part_type_explosion_tnt, 1, 1, 0);
part_type_direction(part_type_explosion_tnt, 0, 359, 0, 0);
part_type_speed(part_type_explosion_tnt, 0.5, 1.5, -0.01, 0);
part_type_life(part_type_explosion_tnt, 30, 40);

part_type_explosion_nitro = part_type_create();
part_type_shape(part_type_explosion_nitro, pt_shape_sphere);
part_type_size(part_type_explosion_nitro, 0.2, 0.3, 0, 0);
part_type_blend(part_type_explosion_nitro, true);
part_type_colour1(part_type_explosion_nitro, c_lime);
part_type_alpha3(part_type_explosion_nitro, 1, 1, 0);
part_type_direction(part_type_explosion_nitro, 0, 359, 0, 0);
part_type_speed(part_type_explosion_nitro, 0.5, 1.5, -0.01, 0);
part_type_life(part_type_explosion_nitro, 30, 40);

crate_types = [];
next_seed_inline();

repeat (200) {
	array_push(crate_types, choose(sprMinigame4vs_Crates_Crate, sprMinigame4vs_Crates_CrateTNT, sprMinigame4vs_Crates_CrateNITRO));
}

crate_count = array_create(global.player_max, 0);

alarm_override(1, function() {
	alarm_inherited(1);
	
	for (var i = 0; i < global.player_max; i++) {
		crate_create(96, 64, i + 1);
	}
});

function crate_create(x, y, network_id) {
	var c = instance_create_layer(x, y + 32 * network_id - 1, "Crates", objMinigame4vs_Crates_Crate);
	c.network_id = network_id;
	c.sprite_index = crate_types[crate_count[network_id - 1]++];
}