/// @desc

// Define color
color = [ // Unused
		[
		$599EFF, $3D84FF, $599EFF], 
		[
		$FF6868, $FF4242, $FF6868], 
		[
		$6DFF70, $49FF56, $6DFF70],
		[
		$FFFC7C, $F2FF49, $FFFC7C]
		];
		
confetti_sprite = [sprConfettiBlue, sprConfettiRed, sprConfettiGreen, sprConfettiYellow];
		
//var get_color = color[player_won_color - 1];
var get_sprite = confetti_sprite[player_won_color - 1];


#region Define particle 

//Confeti
//var _ps = part_system_create();
//part_system_draw_order(_ps, true);

////Emitter
//var _ptype1 = part_type_create();
//part_type_sprite(_ptype1, sprParticleTexture_trace_07, false, true, false)
//part_type_size(_ptype1, 1, 1, -0.01, 0.2);
//part_type_scale(_ptype1, 0.3, 0.2);
//part_type_speed(_ptype1, 5, 7, 0, 1);
//part_type_direction(_ptype1, 245, 295, 0, 0);
//part_type_gravity(_ptype1, 0, 271);
//part_type_orientation(_ptype1, 0, 360, 3, 14, false);
//part_type_colour3(_ptype1, get_color[0], get_color[1], get_color[2]);
//part_type_alpha3(_ptype1, 0, 0.698, 0);
//part_type_blend(_ptype1, true);
//part_type_life(_ptype1, 80, 90);

//var _pemit1 = part_emitter_create(_ps);
//part_emitter_region(_ps, _pemit1, -32, 32, -192, -128, ps_shape_rectangle, ps_distr_linear);
////part_emitter_stream(_ps, _pemit1, _ptype1, 1);
//part_emitter_interval(_ps, _pemit1, 1, 3, time_source_units_frames);

////

//ParticleSystem2
var _ps = part_system_create();
part_system_draw_order(_ps, true);

//Emitter
var _ptype1 = part_type_create();
part_type_sprite(_ptype1, get_sprite, false, false, false)
part_type_size(_ptype1, 0.4, 0.6, 0, 0);
part_type_scale(_ptype1, 1, 0.9);
part_type_speed(_ptype1, 5, 5, 0, 0);
part_type_direction(_ptype1, 240, 300, 0, 0);
part_type_gravity(_ptype1, 0, 270);
part_type_orientation(_ptype1, 0, 360, 9, 0, false);
part_type_colour3(_ptype1, $FFFFFF, $FFFFFF, $FFFFFF);
part_type_alpha3(_ptype1, 1, 1, 0);
part_type_blend(_ptype1, false);
part_type_life(_ptype1, 90, 120);

var _pemit1 = part_emitter_create(_ps);
part_emitter_region(_ps, _pemit1, -32, 32, -32, 32, ps_shape_rectangle, ps_distr_linear);
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