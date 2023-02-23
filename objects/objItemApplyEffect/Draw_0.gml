/// @description Draw gradient animation

// Make a gradient light effect at the player's feet
draw_primitive_begin(pr_trianglestrip);
draw_vertex_color(xx.p_min, yy.p_min, image_blend, image_alpha); // Bottom left
draw_vertex_color(xx.p_max, yy.p_min, image_blend, image_alpha); // Bottom Right
draw_vertex_color(xx.p_min, yy.p_max, image_blend, 0);           // Top left
draw_vertex_color(xx.p_max, yy.p_min, image_blend, image_alpha); // Bottom Right (again)
draw_vertex_color(xx.p_min, yy.p_max, image_blend, 0);           // Top left (again)
draw_vertex_color(xx.p_max, yy.p_max, image_blend, 0);           // Top Right
draw_primitive_end();