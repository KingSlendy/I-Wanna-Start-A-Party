event_inherited();
draw_set_alpha_test(false);
d3d_model_destroy(model_track);
d3d_model_destroy(model_grass);
d3d_model_destroy(model_player);
d3d_model_destroy(model_cone);
d3d_model_destroy(model_spike);
d3d_model_destroy(model_pipe);

for (var i = 0; i < global.player_max; i++) {
	for (var j = 0; j < 7; j++) {
		if (sprite_exists(player_spr[i][j])) {
			sprite_delete(player_spr[i][j]);
		}
		
		if (sprite_exists(player_sprf[i][j])) {
			sprite_delete(player_sprf[i][j]);
		}
	}
}

audio_stop_sound(sndMinigame4vs_Karts_PlayerEngineIdle);
audio_stop_sound(sndMinigame4vs_Karts_PlayerEngineLow);
audio_stop_sound(sndMinigame4vs_Karts_PlayerEngineHigh);
audio_stop_sound(sndMinigame4vs_Karts_PlayerDrift);
d3d_end();