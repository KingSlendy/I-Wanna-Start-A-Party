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
		audio_sound_gain(global.music_current, 1, 0);
		audio_stop_sound(global.music_current);
	}
	
	music_change(music, loop);
}

function music_play_from_position(music, position, loop = true) {
	global.music_previous = null;
	
	if (global.music_current != null && music != global.music_current && !music_is_same(music)) {
		audio_sound_gain(global.music_current, 1, 0);
		audio_stop_sound(global.music_current);
	}
	
	music_change(music, loop);
	audio_sound_gain(global.music_current, 0, 0); //Mute music
	audio_sound_set_track_position(global.music_current, position); //Load position
	audio_sound_gain(global.music_current, 1, 500); //Fade in volume
}

function music_change(music, loop = true) {
	if (music != null && !music_is_same(music)) {
		//music_set_loop_points(music);
		global.music_current = audio_play_sound(music, 0, loop, 1);
	}
}

function LoopPoint(start_point = 0.0, end_point = 0.0) constructor {
	self.start_point = start_point;
	self.end_point = end_point;
}

#region Loop Points
global.music_loop_points = {};
var mlp = global.music_loop_points;

#region Menu
music_loop_add(bgmFiles, new LoopPoint(1.967, 63.921));
music_loop_add(bgmSettings, new LoopPoint(0.048, 16.048));
music_loop_add(bgmModes, new LoopPoint(113.773, 149.373));
music_loop_add(bgmParty, new LoopPoint(1.866, 22.189));
music_loop_add(bgmMinigames, new LoopPoint(5.445, 41.943));
music_loop_add(bgmTrials, new LoopPoint(26.989, 39.789));
music_loop_add(bgmStore, new LoopPoint(2.356, 20.473));
music_loop_add(bgmTrophies, new LoopPoint(1.657, 60.433));
#endregion
	
#region Boards
music_loop_add(bgmBoardIsland, new LoopPoint(5.377, 68.542));
music_loop_add(bgmBoardIslandNight, new LoopPoint(5.338, 68.513));
music_loop_add(bgmBoardHotland, new LoopPoint(37.083, 110.929));
music_loop_add(bgmBoardHotlandAnnoyingDog, new LoopPoint(0.005, 36.102));
music_loop_add(bgmBoardBaba, new LoopPoint(3.164, 118.367));
music_loop_add(bgmBoardPallet, new LoopPoint(0.666, 34.938));
music_loop_add(bgmBoardDreams, new LoopPoint(2.599, 98.539));
music_loop_add(bgmBoardHyrule, new LoopPoint(14.129, 72.326));
music_loop_add(bgmBoardHyruleDark, new LoopPoint(1.627, 60.759));
music_loop_add(bgmBoardNsanity, new LoopPoint(0.0, 124.282));
music_loop_add(bgmBoardWorld, new LoopPoint(13.884, 90.386));
music_loop_add(bgmBoardBasement, new LoopPoint(41.267, 201.266));
music_loop_add(bgmBoardFASF, new LoopPoint(31.033, 98.164));
music_loop_add(bgmBoardFASFLast5Turns, new LoopPoint(20.269, 79.536));

music_loop_add(bgmChanceTime, new LoopPoint(5.779, 38.693));
music_loop_add(bgmTheGuy, new LoopPoint(0.0, 36.735));
music_loop_add(bgmLastTurns, new LoopPoint(8.321, 33.191));
#endregion

#region Minigames
music_loop_add(bgmMinigameOverview, new LoopPoint(2.463, 35.856));
	
#region 4vs
music_loop_add(bgmMinigame4vs_Lead, new LoopPoint(0.226, 32.226));
music_loop_add(bgmMinigame4vs_Tower, new LoopPoint(2.105, 39.576));
music_loop_add(bgmMinigame4vs_Haunted, new LoopPoint(2.469, 26.860));
music_loop_add(bgmMinigame4vs_Magic, new LoopPoint(2.093, 35.193));
music_loop_add(bgmMinigame4vs_Mansion, new LoopPoint(4.858, 33.825));
music_loop_add(bgmMinigame4vs_Painting, new LoopPoint(0.921, 28.614));
music_loop_add(bgmMinigame4vs_Bugs, new LoopPoint(1.511, 38.392));
music_loop_add(bgmMinigame4vs_Blocks, new LoopPoint(2.296, 34.764));
music_loop_add(bgmMinigame4vs_Chests, new LoopPoint(0.980, 31.700));
music_loop_add(bgmMinigame4vs_Slime, new LoopPoint(2.543, 25.949));
music_loop_add(bgmMinigame4vs_Rocket, new LoopPoint(2.265, 26.268));
music_loop_add(bgmMinigame4vs_Dizzy, new LoopPoint(1.809, 32.023));
music_loop_add(bgmMinigame4vs_Targets, new LoopPoint(2.459, 34.037));
music_loop_add(bgmMinigame4vs_Bullets, new LoopPoint(2.275, 36.760));
music_loop_add(bgmMinigame4vs_Drawn, new LoopPoint(7.367, 57.022));
music_loop_add(bgmMinigame4vs_Bubble, new LoopPoint(4.814, 51.957));
music_loop_add(bgmMinigame4vs_Golf, new LoopPoint(1.380, 28.843));
music_loop_add(bgmMinigame4vs_Waka, new LoopPoint(2.366, 41.383));
music_loop_add(bgmMinigame4vs_Jingle, new LoopPoint(3.757, 28.691));
music_loop_add(bgmMinigame4vs_Treasure, new LoopPoint(1.164, 29.710));
music_loop_add(bgmMinigame4vs_Crushers, new LoopPoint(0.996, 30.989));
music_loop_add(bgmMinigame4vs_Clockwork, new LoopPoint(4.270, 32.669));
music_loop_add(bgmMinigame4vs_Crates, new LoopPoint(1.875, 31.848));
music_loop_add(bgmMinigame4vs_Leap, new LoopPoint(2.407, 42.370));
music_loop_add(bgmMinigame4vs_Karts, new LoopPoint(5.676, 27.008));
#endregion
	
#region 1vs3
music_loop_add(bgmMinigame1vs3_Avoid, new LoopPoint(0.851, 27.852));
music_loop_add(bgmMinigame1vs3_Conveyor, new LoopPoint(2.628, 32.828));
music_loop_add(bgmMinigame1vs3_Showdown, new LoopPoint(2.307, 41.207));
music_loop_add(bgmMinigame1vs3_Coins, new LoopPoint(3.609, 34.342));
music_loop_add(bgmMinigame1vs3_Race, new LoopPoint(4.401, 36.943));
music_loop_add(bgmMinigame1vs3_Warping, new LoopPoint(2.658, 36.962));
music_loop_add(bgmMinigame1vs3_Hunt, new LoopPoint(1.923, 23.618));
music_loop_add(bgmMinigame1vs3_Aiming, new LoopPoint(4.396, 40.852));
music_loop_add(bgmMinigame1vs3_Host, new LoopPoint(2.600, 32.601));
music_loop_add(bgmMinigame1vs3_House, new LoopPoint(2.086, 37.002));
music_loop_add(bgmMinigame1vs3_Kardia, new LoopPoint(2.066, 45.703));
music_loop_add(bgmMinigame1vs3_Picture, new LoopPoint(2.803, 37.089));
#endregion
	
#region 2vs2
music_loop_add(bgmMinigame2vs2_Maze, new LoopPoint(3.330, 43.047));
music_loop_add(bgmMinigame2vs2_Fruits, new LoopPoint(0.783, 24.056));
music_loop_add(bgmMinigame2vs2_Buttons, new LoopPoint(0.056, 35.078));
music_loop_add(bgmMinigame2vs2_Squares, new LoopPoint(2.042, 48.478));
music_loop_add(bgmMinigame2vs2_Colorful, new LoopPoint(1.703, 31.706));
music_loop_add(bgmMinigame2vs2_Springing, new LoopPoint(1.640, 27.586));
music_loop_add(bgmMinigame2vs2_Duos, new LoopPoint(1.600, 35.859));
music_loop_add(bgmMinigame2vs2_Duel, new LoopPoint(1.699, 19.974));
music_loop_add(bgmMinigame2vs2_Soccer, new LoopPoint(2.020, 36.930));
music_loop_add(bgmMinigame2vs2_Idol, new LoopPoint(4.831, 40.170));
music_loop_add(bgmMinigame2vs2_Castle, new LoopPoint(14.842, 41.138));
music_loop_add(bgmMinigame2vs2_Stacking, new LoopPoint(2.051, 32.484));
#endregion
	
#region Results
music_loop_add(bgmResults, new LoopPoint(5.920, 13.783));
music_loop_add(bgmPartyStar, new LoopPoint(0.560, 35.942));
#endregion

//mlp[$ null] = new LoopPoint();
#endregion

function music_loop_init() {
	struct_foreach(global.music_loop_points, function(music, loop) {
		music = asset_get_index(music);
		audio_sound_loop(music, true);
		audio_sound_loop_start(music, loop.start_point);
		audio_sound_loop_end(music, loop.end_point);
	});
}

function music_loop_add(music, loop) {
	global.music_loop_points[$ audio_get_name(music)] = loop;
}

//function music_set_loop_points(music) {	
//	var loop_start = -1;
//	var loop_end = -1;
//	var music_id = asset_get_index(audio_get_name(music));

//	if (variable_struct_exists(global.music_loop_points, music_id)) {
//		var loop_point = global.music_loop_points[$ music_id];
//		loop_start = loop_point.start_point;
//		loop_end = loop_point.end_point;
//	}

//	global.music_loop_start = loop_start;
//	global.music_loop_end = loop_end - loop_start;
//}

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
	if (global.music_current != null) {
		audio_pause_sound(global.music_current);
		global.music_previous = global.music_current;
	}
}

function music_resume() {
	if (global.music_previous != null) {
		global.music_current = global.music_previous;
		//music_set_loop_points(global.music_current);
		audio_resume_sound(global.music_current);
	}
}

function music_fade(time = 750) {
	if (global.music_current != null) {
		audio_sound_gain(global.music_current, 0, time);
	}
}

function audio_get_index(name) {
	var index = asset_get_index(name);
	
	if (index == -1) {
		index = asset_get_index(string_lower(name));
	}
	
	return index;
}