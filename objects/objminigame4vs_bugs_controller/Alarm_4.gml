if (array_length(bugs) == 0) {
	alarm[5] = get_frames(1);
	exit;
}

bug_counter++;
var bug = bugs[0];
bug.counter = bug_counter;
bug.state = 0;
array_delete(bugs, 0, 1);
audio_play_sound(sndMinigame4vs_Bugs_BugCount, 0, false);
alarm[4] = get_frames(0.5);