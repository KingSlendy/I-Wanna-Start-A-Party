/// Init particles
//ParticleSystem1
var _ps = part_system_create();
part_system_draw_order(_ps, true);

pt1_scaleX = 1.3;
pt1_scaleY = 1.1;

pt2_scale = 1.0;

scale_factor = 1;


//Emitter_1
var _ptype1 = part_type_create();
part_type_sprite(_ptype1, sprParticleTexture_star_06, false, true, false)
part_type_size(_ptype1, 0.5, 1.2, 0.002, 0);
part_type_scale(_ptype1, pt1_scaleX, pt1_scaleY);
part_type_speed(_ptype1, 0, 0, 0, 0);
part_type_direction(_ptype1, 0, 360, 0, 0);
part_type_gravity(_ptype1, 0, 270);
part_type_orientation(_ptype1, 0, 360, -0.3, 0, false);
part_type_colour3(_ptype1, $6DF2FF, $A8FFFD, $63ECFF);
part_type_alpha3(_ptype1, 0, 0.322, 0);
part_type_blend(_ptype1, true);
part_type_life(_ptype1, 70, 70);

var _pemit1 = part_emitter_create(_ps);
part_emitter_region(_ps, _pemit1, -16, 16, -16, 16, ps_shape_rectangle, ps_distr_linear);
//part_emitter_stream(_ps, _pemit1, _ptype1, 1);

//Emitter
var _ptype2 = part_type_create();
part_type_sprite(_ptype2, sprParticleTexture_star_06, false, true, false)
part_type_size(_ptype2, 0.5, 1.2, 0.002, 0);
part_type_scale(_ptype2, pt2_scale, pt2_scale);
part_type_speed(_ptype2, 0, 0, 0, 0);
part_type_direction(_ptype2, 0, 360, 0, 0);
part_type_gravity(_ptype2, 0, 270);
part_type_orientation(_ptype2, 0, 360, 0.3, 0, false);
part_type_colour3(_ptype2, $6DF2FF, $DDFFFE, $63ECFF);
part_type_alpha3(_ptype2, 0, 0.42, 0);
part_type_blend(_ptype2, true);
part_type_life(_ptype2, 70, 70);

var _pemit2 = part_emitter_create(_ps);
part_emitter_region(_ps, _pemit2, -16, 16, -16, 16, ps_shape_rectangle, ps_distr_linear);
//part_emitter_stream(_ps, _pemit2, _ptype2, 1);

part_system_position(_ps, x, y);

ps = _ps;
pt1 = _ptype1;
pe1 = _pemit1;

pt2 = _ptype2;
pe2 = _pemit2;

alarm[0] = 1;

time = 0;
duration = 30;