draw_primitive_begin(pr_trianglestrip);
draw_vertex_color(xx.p_min, yy.p_min, image_blend, image_alpha);
draw_vertex_color(xx.p_max, yy.p_min, image_blend, image_alpha);
draw_vertex_color(xx.p_min, yy.p_max, image_blend, 0);
draw_vertex_color(xx.p_max, yy.p_min, image_blend, image_alpha);
draw_vertex_color(xx.p_min, yy.p_max, image_blend, 0);
draw_vertex_color(xx.p_max, yy.p_max, image_blend, 0);
draw_primitive_end();