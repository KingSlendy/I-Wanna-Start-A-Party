event_inherited();

minigame_players = function() {
	with (objPlayerBase) {
		lookBehind = false;
	}
}

minigame_camera = CameraMode.Split4;
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

for (var i = 0; i < 7; i++) {
    player_tex[i] = sprite_get_texture(sprPlayerKartBack, i);
    player_texf[i] = sprite_get_texture(sprPlayerKartFront, i);
}
    
model_player = d3d_model_create();
d3d_model_primitive_begin(model_player, 5);
d3d_model_vertex_normal_texture(model_player, -0.5, -0.5, 0, 0, 0, 1, 0, 0);
d3d_model_vertex_normal_texture(model_player, 0.5, -0.5, 0, 0, 0, 1, 1, 0);
d3d_model_vertex_normal_texture(model_player, -0.5, 0.5, 0, 0, 0, 1, 0, 1);
d3d_model_vertex_normal_texture(model_player, 0.5, 0.5, 0, 0, 0, 1, 1, 1);
d3d_model_primitive_end(model_player);