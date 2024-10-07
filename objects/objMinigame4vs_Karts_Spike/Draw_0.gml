var cdir = objMinigame4vs_Karts_Controller.dir - 90;
var cdirtan = 90;
d3d_transform_set_translation(0, -0.5, 0);
d3d_transform_add_scaling(8, 8, 8);
d3d_transform_add_rotation_x(cdirtan);
d3d_transform_add_rotation_z(cdir);
d3d_transform_add_translation(x, y, z);
d3d_model_draw(model_spike, 0, 0, 0, tex_spike);
d3d_transform_set_identity();
d3d_transform_set_translation(0, -0.5, 0);
d3d_transform_add_scaling(8, 8, 8);
d3d_transform_add_rotation_x(cdirtan);
d3d_transform_add_rotation_z(cdir + 90);
d3d_transform_add_translation(x, y, z);
d3d_model_draw(model_spike, 0, 0, 0, tex_spike);
d3d_transform_set_identity();

//d3d_draw_cone(x - sprite_width / 2, y - sprite_height / 2, z, x + sprite_width / 2, y + sprite_height / 2, z + 12, sprite_get_texture(sprMinigame4vs_Karts_Spike, 0), 4, 1, false, 4);

