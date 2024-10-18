event_inherited();

minigame_camera = CameraMode.Split4;
minigame_players = function() {
	with (objPlayerBase) {
		agent = null;
		drift_input = false;
		agent_offset_x = 0;
		agent_offset_y = 0;
		agent_offset_delay = 0;
	}
}

action_end = function() {
	with (objPlayerBase) {
		if (is_player_local(network_id)) {
			speed = 0;
			audio_stop_sound(engine_sound);
			audio_stop_sound(drift_sound);
		}
	}
}

points_draw = true;

player_type = objPlayerKart;

skyColor = make_color_rgb(248, 232, 144);
z = 18;
d3d_start();
d3d_set_lighting(false);
draw_set_alpha_test(true);
tex_track = background_get_texture(sprBkgMinigame4vs_Karts);
tex_grass = background_get_texture(sprBkgMinigame4vs_Karts_Grass);
model_track = d3d_model_create();
d3d_model_primitive_begin(model_track, pr_trianglestrip);
d3d_model_vertex_normal_texture(model_track, 0, 0, 0, 0, 0, 1, 0, 0);
d3d_model_vertex_normal_texture(model_track, 1024, 0, 0, 0, 0, 1, 1, 0);
d3d_model_vertex_normal_texture(model_track, 0, 1024, 0, 0, 0, 1, 0, 1);
d3d_model_vertex_normal_texture(model_track, 1024, 1024, 0, 0, 0, 1, 1, 1);
d3d_model_primitive_end(model_track);
model_grass = d3d_model_create();
d3d_model_primitive_begin(model_grass, pr_trianglestrip);
d3d_model_vertex_normal_texture(model_grass, -2048, -2048, 0, 0, 0, 1, 0, 0);
d3d_model_vertex_normal_texture(model_grass, 3072, -2048, 0, 0, 0, 1, 640, 0);
d3d_model_vertex_normal_texture(model_grass, -2048, 0, 0, 0, 0, 1, 0, 256);
d3d_model_vertex_normal_texture(model_grass, 3072, 0, 0, 0, 0, 1, 640, 256);
d3d_model_primitive_end(model_grass);
d3d_model_primitive_begin(model_grass, 5);
d3d_model_vertex_normal_texture(model_grass, -2048, 0, 0, 0, 0, 1, 0, 0);
d3d_model_vertex_normal_texture(model_grass, 0, 0, 0, 0, 0, 1, 256, 0);
d3d_model_vertex_normal_texture(model_grass, -2048, 1024, 0, 0, 0, 1, 0, 128);
d3d_model_vertex_normal_texture(model_grass, 0, 1024, 0, 0, 0, 1, 256, 128);
d3d_model_primitive_end(model_grass);
d3d_model_primitive_begin(model_grass, 5);
d3d_model_vertex_normal_texture(model_grass, 1024, 0, 0, 0, 0, 1, 0, 0);
d3d_model_vertex_normal_texture(model_grass, 3072, 0, 0, 0, 0, 1, 256, 0);
d3d_model_vertex_normal_texture(model_grass, 1024, 1024, 0, 0, 0, 1, 0, 128);
d3d_model_vertex_normal_texture(model_grass, 3072, 1024, 0, 0, 0, 1, 256, 128);
d3d_model_primitive_end(model_grass);
d3d_model_primitive_begin(model_grass, 5);
d3d_model_vertex_normal_texture(model_grass, -2048, 1024, 0, 0, 0, 1, 0, 0);
d3d_model_vertex_normal_texture(model_grass, 3072, 1024, 0, 0, 0, 1, 640, 0);
d3d_model_vertex_normal_texture(model_grass, -2048, 3072, 0, 0, 0, 1, 0, 256);
d3d_model_vertex_normal_texture(model_grass, 3072, 3072, 0, 0, 0, 1, 640, 256);
d3d_model_primitive_end(model_grass);
mv1 = 5.555555555555555;
mv2 = 5;
mv3 = 4.444444444444445;
dir = 0;
camFront = 0;
followDist = 10;
mode = 0;
swoopCounter = 0;
swoopTimer = 0;
targetDirection = direction;
targetX = x;
targetY = y;
swoopLength = 150;
distSwooped = 0;
swoopDir = 0;
timer = 240;
playerFinished = 0;
playerScore = 0;
playerWon = -1;
playerCheckpoint = 0;
playerWinning = -1;
    
model_player = d3d_model_create();
d3d_model_primitive_begin(model_player, 5);
d3d_model_vertex_normal_texture(model_player, -0.5, -0.5, 0, 0, 0, 1, 0, 0);
d3d_model_vertex_normal_texture(model_player, 0.5, -0.5, 0, 0, 0, 1, 1, 0);
d3d_model_vertex_normal_texture(model_player, -0.5, 0.5, 0, 0, 0, 1, 0, 1);
d3d_model_vertex_normal_texture(model_player, 0.5, 0.5, 0, 0, 0, 1, 1, 1);
d3d_model_primitive_end(model_player);

player_spr = [];
player_tex = [];
player_sprf = [];
player_texf = [];
var width = sprite_get_width(sprPlayerKartBack);
var height = sprite_get_height(sprPlayerKartBack);
var surf = surface_create(width, height);
var shd_uniform_hue = shader_get_uniform(shdMinigame4vs_Karts_PlayerKart, "u_uHue");

for (var i = 0; i < global.player_max; i++) {
	var player = focus_player_by_turn(i + 1);
	var hue = color_get_hue(player_color_by_turn(i + 1)) / 255;
	
	var sprite = null;
	array_push(player_spr, []);
	array_push(player_tex, []);
	array_push(player_sprf, []);
	array_push(player_texf, []);
	
	for (var j = 0; j < 7; j++) {
		surface_set_target(surf);
		draw_clear_alpha(c_black, 0);
		draw_sprite_ext(player.sprite_index, j % 4, 16 + round(remap(j, 0, 6, -4, 4)), 20, (j < 3) ? -1 : 1, 1, 0, c_white, 1);
		shader_set(shdMinigame4vs_Karts_PlayerKart);
		shader_set_uniform_f(shd_uniform_hue, hue);
		draw_sprite(sprPlayerKartBack, j, 0, 0);
		shader_reset();
		surface_reset_target();
		sprite = sprite_create_from_surface(surf, 0, 0, width, height, false, false, 0, 0);
		array_push(player_spr[i], sprite);
		array_push(player_tex[i], sprite_get_texture(player_spr[i][j], 0));
		
		surface_set_target(surf);
		draw_clear_alpha(c_black, 0);
		draw_sprite_ext(player.sprite_index, j % 4, 16 + round(remap(j, 0, 6, -4, 4)), 20, (j < 3) ? -1 : 1, 1, 0, c_white, 1);
		shader_set(shdMinigame4vs_Karts_PlayerKart);
		shader_set_uniform_f(shd_uniform_hue, hue);
		draw_sprite(sprPlayerKartFront, j, 0, 0);
		shader_reset();
		surface_reset_target();
		sprite = sprite_create_from_surface(surf, 0, 0, width, height, false, false, 0, 0);
		array_push(player_sprf[i], sprite);
		array_push(player_texf[i], sprite_get_texture(player_sprf[i][j], j));
	}
}

surface_free(surf);

tex_cone = sprite_get_texture(sprMinigame4vs_Karts_Cone, 0);
model_cone = d3d_model_create();
d3d_model_primitive_begin(model_cone, 5);
d3d_model_vertex_normal_texture(model_cone, -0.5, -0.5, 0, 0, 0, 1, 0, 0);
d3d_model_vertex_normal_texture(model_cone, 0.5, -0.5, 0, 0, 0, 1, 1, 0);
d3d_model_vertex_normal_texture(model_cone, -0.5, 0.5, 0, 0, 0, 1, 0, 1);
d3d_model_vertex_normal_texture(model_cone, 0.5, 0.5, 0, 0, 0, 1, 1, 1);
d3d_model_primitive_end(model_cone);

tex_spike = sprite_get_texture(sprMinigame4vs_Karts_Spike, 0);
model_spike = d3d_model_create();
d3d_model_primitive_begin(model_spike, 5);
d3d_model_vertex_normal_texture(model_spike, -0.5, -0.5, 0, 0, 0, 1, 0, 0);
d3d_model_vertex_normal_texture(model_spike, 0.5, -0.5, 0, 0, 0, 1, 1, 0);
d3d_model_vertex_normal_texture(model_spike, -0.5, 0.5, 0, 0, 0, 1, 0, 1);
d3d_model_vertex_normal_texture(model_spike, 0.5, 0.5, 0, 0, 0, 1, 1, 1);
d3d_model_primitive_end(model_spike);

tex_pipe = sprite_get_texture(sprMinigame4vs_Karts_Pipe, 0);
model_pipe = d3d_model_create();
d3d_model_primitive_begin(model_pipe, pr_trianglestrip);
d3d_model_vertex_normal_texture(model_pipe, -0.5, -0.5, 0, 0, 0, 1, 0, 0);
d3d_model_vertex_normal_texture(model_pipe, 0.5, -0.5, 0, 0, 0, 1, 1, 0);
d3d_model_vertex_normal_texture(model_pipe, -0.5, 0.5, 0, 0, 0, 1, 0, 1);
d3d_model_vertex_normal_texture(model_pipe, 0.5, 0.5, 0, 0, 0, 1, 1, 1);
d3d_model_primitive_end(model_pipe);

trophy_spring = true;

function kart_count_lap(network_id, network = true) {
	minigame4vs_points(network_id, 1);
	
	if (minigame4vs_get_points(network_id) >= 3) {
	    minigame_finish();
	} else {
	    //var lakitu = instance_create(-100, -304, objKartsLapLakitu);
		
	    //if (lap == 2) {
	    //    lakitu.image_index = 1;
	    //    audio_play_sound(sndKartsLastLap, 0, false);
	    //    audio_sound_pitch(global.currentMusic, 1.1);
	    //}
	}
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame4vs_Karts_KartCountLap);
		buffer_write_data(buffer_u8, network_id);
		network_send_tcp_packet();
	}
}

alarm_override(2, function() {
	alarm_inherited(2);
	
	if (minigame_has_won() && trophy_spring) {
		achieve_trophy(91);
	}
});

alarm_override(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
		
		var player = focus_player_by_id(i);
		
		with (player) {
			if (agent == null) {
				agent = instance_create_layer(x, y, "Actors", objMinigame4vs_Karts_CPU);
			}
			
			if (point_distance(x, y, agent.x, agent.y) <= 100) {
				agent.position = agent.path_position;
			} else {
				agent.path_position = agent.position;
			}
			
			//agent.path_speed = random_range(3, 5);
			
			var free_path = function(angle, distance) {
				mask_index = sprMinigame4vs_Karts_Line;
				image_angle = angle;
				image_xscale = distance / sprite_get_width(sprMinigame4vs_Karts_Line);
				var result = (!place_meeting(x, y, [objBlock, objMinigame4vs_Karts_Spike]));
				mask_index = sprMinigame4vs_Karts_Mask;
				image_angle = 0;
				image_xscale = 1;
				return result;
			}
			
			if (--agent_offset_delay <= 0) {
				agent_offset_x = random_range(-10, 10);
				agent_offset_y = random_range(-10, 10);
				agent_offset_delay = get_frames(0.5);
			}
			
			var dir = point_direction(x, y, agent.x + agent_offset_x, agent.y + agent_offset_y);
			var diff = angle_difference(dir, direction);
			var free_left = free_path(direction + 15, 50);
			var free_right = free_path(direction - 15, 50);
			
			if (free_path(direction, 30) && !place_meeting(x, y, objBlock)) {
				actions.up.press();
			
				if (abs(diff) > 3) {
					if (abs(diff) >= 10) {
						drift_input = true;
					}
					
					if (diff > 0 && free_left) {
						actions.left.press();
					} else if (diff < 0 && free_right) {
						actions.right.press();
					}
				} else {
					if (!free_right) {
						actions.left.press();
					} else if (!free_left) {
						actions.right.press();
					}
				}
			} else {
				if (place_meeting(x, y, objMinigame4vs_Karts_TrackCol)) {
					actions.down.hold(50);
				} else {
					actions.down.hold(200);
				}
				
				if (diff < 0 && free_path(direction - 15, 20)) {
					actions.right.hold(20);
				} else if (diff > 0 && free_path(direction + 15, 20)) {
					actions.left.hold(20);
				}
			}
			
			if (drift_input) {
				if (!place_meeting(x, y, objMinigame4vs_Karts_TrackCol)  || abs(diff) <= 1) {
					actions.jump.release(true);
					drift_input = false;
				} else if (!actions.jump.held()) {
					actions.jump.hold();
				}
			}
		}
	}

	alarm_frames(11, 1);
});