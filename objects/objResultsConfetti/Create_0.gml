#region Define particle 
//ParticleSystem
var _ps = part_system_create();
part_system_draw_order(_ps, true);

//Type
var _ptype1 = part_type_create();
part_type_sprite(_ptype1, sprResultsConfetti, false, false, true);
part_type_size(_ptype1, 0.4, 0.6, 0, 0);
part_type_scale(_ptype1, 1, 0.9);
part_type_speed(_ptype1, 6, 8, 0, 0);
part_type_direction(_ptype1, 240, 300, 0, 10);
part_type_orientation(_ptype1, 0, 360, 9, 0, false);
part_type_colour3(_ptype1, $FFFFFF, $FFFFFF, $FFFFFF);
part_type_alpha3(_ptype1, 1, 1, 0);
part_type_blend(_ptype1, false);
part_type_life(_ptype1, 90, 120);

//Emitter
var _pemit1 = part_emitter_create(_ps);
part_emitter_region(_ps, _pemit1, -150, 150, -32, 32, ps_shape_rectangle, ps_distr_linear);
part_emitter_stream(_ps, _pemit1, _ptype1, 0);
part_emitter_interval(_ps, _pemit1, 1, 3, time_source_units_frames);

part_system_position(_ps, x, y);

ps = _ps;
pt1 = _ptype1;
pe1 = _pemit1;

#endregion


start_create_particles = function()
{
	part_emitter_stream(ps, pe1, pt1, 1);
}