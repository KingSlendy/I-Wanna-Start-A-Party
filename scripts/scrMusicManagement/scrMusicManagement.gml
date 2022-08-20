global.music_current = null;
global.music_previous = null;
global.sound_cursor_move = sndCursorMove;
global.sound_cursor_select = sndCursorSelect;
global.sound_cursor_select2 = sndCursorSelect2;
global.sound_cursor_big_select = sndCursorBigSelect;
global.sound_cursor_back = sndCursorBack;
global.music_loop_start = -1;
global.music_loop_end = -1;

function music_play(music, loop = true) {
	global.music_previous = null;
	
	if (global.music_current != null && music != global.music_current && !music_is_same(music)) {
		audio_stop_sound(global.music_current);
	}
	
	music_change(music, loop);
}

function music_change(music, loop = true) {
	if (music != null && !music_is_same(music)) {
		global.music_current = audio_play_sound(music, 0, loop);
		music_set_loop_points(music);
	}
}

function LoopPoint(start_point, end_point) constructor {
	self.start_point = start_point;
	self.end_point = end_point;
}

global.music_loop_points = {};
var mlp = global.music_loop_points;

//Menu
mlp[$ bgmFiles] = new LoopPoint(1.967, 63.921);
mlp[$ bgmSettings] = new LoopPoint(0.048, 16.048);
mlp[$ bgmModes] = new LoopPoint(113.773, 149.373);
mlp[$ bgmParty] = new LoopPoint(1.866, 22.189);
mlp[$ bgmMinigames] = new LoopPoint(5.445, 41.943);
mlp[$ bgmSkins] = new LoopPoint(2.356, 20.473);
mlp[$ bgmTrophies] = new LoopPoint(1.657, 60.433);
	
//Boards
mlp[$ bgmBoardIsland] = new LoopPoint(5.377, 68.542);
mlp[$ bgmBoardIslandNight] = new LoopPoint(5.338, 68.513);
mlp[$ bgmBoardHotland] = new LoopPoint(37.010, 110.858);
mlp[$ bgmBoardHotlandAnnoyingDog] = new LoopPoint(0.005, 36.102);
mlp[$ bgmBoardBaba] = new LoopPoint(3.164, 118.367);
mlp[$ bgmBoardPallet] = new LoopPoint(0.666, 34.938);
mlp[$ bgmBoardDreams] = new LoopPoint(2.599, 98.539);
mlp[$ bgmBoardBasement] = new LoopPoint(41.267, 201.266);
mlp[$ bgmChanceTime] = new LoopPoint(5.779, 38.693);
mlp[$ bgmTheGuy] = new LoopPoint(0.0, 36.735);
mlp[$ bgmLastTurns] = new LoopPoint(8.321, 33.191);

//Minigames
mlp[$ bgmMinigameOverview] = new LoopPoint(2.463, 35.856);
mlp[$ bgmMinigameNA] = new LoopPoint(2.070, 45.698);
	
//4vs
mlp[$ bgmMinigame4vs_Lead] = new LoopPoint(0.226, 32.226);
mlp[$ bgmMinigame4vs_Tower] = new LoopPoint(2.105, 39.576);
mlp[$ bgmMinigame4vs_Haunted] = new LoopPoint(2.469, 26.860);
mlp[$ bgmMinigame4vs_Magic] = new LoopPoint(2.093, 35.193);
mlp[$ bgmMinigame4vs_Mansion] = new LoopPoint(4.858, 33.825);
mlp[$ bgmMinigame4vs_Painting] = new LoopPoint(0.921, 28.614);
mlp[$ bgmMinigame4vs_Bugs] = new LoopPoint(1.511, 38.392);
mlp[$ bgmMinigame4vs_Blocks] = new LoopPoint(2.296, 34.764);
mlp[$ bgmMinigame4vs_Chests] = new LoopPoint(0.980, 31.700);
mlp[$ bgmMinigame4vs_Slime] = new LoopPoint(2.543, 25.949);
mlp[$ bgmMinigame4vs_Rocket] = new LoopPoint(2.265, 26.268);
mlp[$ bgmMinigame4vs_Dizzy] = new LoopPoint(1.809, 32.023);
mlp[$ bgmMinigame4vs_Targets] = new LoopPoint(2.459, 34.037);
mlp[$ bgmMinigame4vs_Bullets] = new LoopPoint(2.275, 36.760);
mlp[$ bgmMinigame4vs_Drawn] = new LoopPoint(7.367, 57.022);
	
//1vs3
mlp[$ bgmMinigame1vs3_Avoid] = new LoopPoint(0.851, 27.852);
mlp[$ bgmMinigame1vs3_Conveyor] = new LoopPoint(2.628, 32.828);
mlp[$ bgmMinigame1vs3_Showdown] = new LoopPoint(2.307, 41.207);
mlp[$ bgmMinigame1vs3_Coins] = new LoopPoint(3.609, 34.342);
mlp[$ bgmMinigame1vs3_Race] = new LoopPoint(4.401, 36.943);
mlp[$ bgmMinigame1vs3_Warping] = new LoopPoint(2.658, 36.962);
mlp[$ bgmMinigame1vs3_Hunt] = new LoopPoint(1.923, 23.618);
	
//2vs2
mlp[$ bgmMinigame2vs2_Maze] = new LoopPoint(3.330, 43.047);
mlp[$ bgmMinigame2vs2_Fruits] = new LoopPoint(0.783, 24.056);
mlp[$ bgmMinigame2vs2_Buttons] = new LoopPoint(0.056, 35.078);
mlp[$ bgmMinigame2vs2_Squares] = new LoopPoint(2.042, 48.478);
mlp[$ bgmMinigame2vs2_Colorful] = new LoopPoint(1.703, 31.706);
mlp[$ bgmMinigame2vs2_Springing] = new LoopPoint(1.640, 27.586);
mlp[$ bgmMinigame2vs2_Duos] = new LoopPoint(1.600, 35.859);
mlp[$ bgmMinigame2vs2_Duel] = new LoopPoint(1.699, 19.974);
mlp[$ bgmMinigame2vs2_Soccer] = new LoopPoint(2.020, 36.930);
	
//Results
mlp[$ bgmResults] = new LoopPoint(5.552, 13.415);
mlp[$ bgmPartyStar] = new LoopPoint(0.560, 35.942);

function music_set_loop_points(music) {	
	var loop_start = -1;
	var loop_end = -1;
	var music_id = asset_get_index(audio_get_name(music));
	
	if (variable_struct_exists(global.music_loop_points, music_id)) {
		var loop_point = global.music_loop_points[$ music_id];
		loop_start = loop_point.start_point;
		loop_end = loop_point.end_point;
	}
	
	global.music_loop_start = loop_start;
	global.music_loop_end = loop_end - loop_start;
}

function music_is_same(music) {
	if (music == null || global.music_current == null) {
		return false;
	}
	
	return (audio_get_name(music) == audio_get_name(global.music_current));
}

function music_stop() {
	if (global.music_current != null) {
		audio_stop_sound(global.music_current);
		audio_sound_gain(global.music_current, 1, 0);
		global.music_current = null;
	}
}

function music_pause() {
	audio_pause_sound(global.music_current);
	global.music_previous = global.music_current;
}

function music_resume() {
	if (global.music_previous != null) {
		global.music_current = global.music_previous;
		audio_resume_sound(global.music_current);
		music_set_loop_points(global.music_current);
	}
}

function music_fade(time = 1000) {
	audio_sound_gain(global.music_current, 0, time);
}