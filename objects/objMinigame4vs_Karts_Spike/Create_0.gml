z = 0;
tex_spike = sprite_get_texture(sprite_index, 0);
model_spike = d3d_model_create();
d3d_model_primitive_begin(model_spike, 5);
d3d_model_vertex_normal_texture(model_spike, -0.5, -0.5, 0, 0, 0, 1, 0, 0);
d3d_model_vertex_normal_texture(model_spike, 0.5, -0.5, 0, 0, 0, 1, 1, 0);
d3d_model_vertex_normal_texture(model_spike, -0.5, 0.5, 0, 0, 0, 1, 0, 1);
d3d_model_vertex_normal_texture(model_spike, 0.5, 0.5, 0, 0, 0, 1, 1, 1);
d3d_model_primitive_end(model_spike);

